//
//  PurchaseManager.swift
//  LexWriter
//
//  Created by Codex on 04/09/2026.
//

import Foundation
import Observation
import StoreKit

@MainActor
@Observable
final class PurchaseManager {
    static let premiumLifetimeProductID = "com.lexwriter.premium.lifetime"

    private let premiumAccessDefaultsKey = "hasPremiumAccess"
    private let userDefaults: UserDefaults

    private(set) var hasPremiumAccess: Bool
    private(set) var premiumProduct: Product?
    private(set) var isLoadingProducts = false
    private(set) var isProcessingPurchase = false
    private(set) var statusMessage: String?
    private(set) var statusMessageKey: LocalizedKey?

    private var updatesTask: Task<Void, Never>?

    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
        hasPremiumAccess = userDefaults.bool(forKey: premiumAccessDefaultsKey)
    }

    func start() {
        guard updatesTask == nil else { return }

        updatesTask = Task(priority: .background) { [weak self] in
            guard let self else { return }

            await self.loadProducts()
            await self.refreshEntitlements()

            for await result in Transaction.updates {
                await self.handle(transactionResult: result)
            }
        }
    }

    func isDocumentUnlocked(_ document: AppDocument) -> Bool {
        switch document.accessTier {
        case .free:
            return true
        case .premium:
            return hasPremiumAccess
        }
    }

    func loadProducts() async {
        guard premiumProduct == nil, !isLoadingProducts else { return }

        isLoadingProducts = true
        clearStatusMessage()
        defer { isLoadingProducts = false }

        do {
            let products = try await Product.products(for: [Self.premiumLifetimeProductID])
            premiumProduct = products.first
        } catch {
            statusMessage = error.localizedDescription
        }
    }

    func restorePurchases() async {
        isProcessingPurchase = true
        clearStatusMessage()
        defer { isProcessingPurchase = false }

        do {
            try await AppStore.sync()
            await refreshEntitlements()
        } catch {
            statusMessageKey = .restorePurchasesFailed
        }
    }

    func beginPurchase() {
        isProcessingPurchase = true
        clearStatusMessage()
    }

    func finishPurchase() {
        isProcessingPurchase = false
    }

    func handlePurchaseError(_ error: Error) {
        isProcessingPurchase = false
        statusMessageKey = .purchaseCouldNotComplete
    }

    func completePurchase(_ purchaseResult: Product.PurchaseResult) async {
        defer { isProcessingPurchase = false }
        await process(purchaseResult: purchaseResult)
    }

    private func refreshEntitlements() async {
        var premiumUnlocked = false

        for await result in Transaction.currentEntitlements {
            guard case .verified(let transaction) = result else { continue }
            if transaction.productID == Self.premiumLifetimeProductID, transaction.revocationDate == nil {
                premiumUnlocked = true
            }
        }

        setPremiumAccess(premiumUnlocked)
    }

    private func process(purchaseResult: Product.PurchaseResult) async {
        switch purchaseResult {
        case .success(let verification):
            await handle(transactionResult: verification)
        case .pending:
            clearStatusMessage()
        case .userCancelled:
            clearStatusMessage()
        @unknown default:
            clearStatusMessage()
        }
    }

    private func handle(transactionResult: VerificationResult<Transaction>) async {
        let transaction: Transaction

        switch transactionResult {
        case .verified(let verifiedTransaction):
            transaction = verifiedTransaction
        case .unverified:
            statusMessageKey = .purchaseCouldNotComplete
            return
        }

        defer {
            Task {
                await transaction.finish()
            }
        }

        if transaction.productID == Self.premiumLifetimeProductID {
            let isActive = transaction.revocationDate == nil
            setPremiumAccess(isActive)
        }
    }

    private func clearStatusMessage() {
        statusMessage = nil
        statusMessageKey = nil
    }

    private func setPremiumAccess(_ value: Bool) {
        hasPremiumAccess = value
        userDefaults.set(value, forKey: premiumAccessDefaultsKey)
    }
}
