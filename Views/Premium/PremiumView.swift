//
//  PremiumView.swift
//  LexWriter
//
//  Created by Codex on 04/09/2026.
//

import StoreKit
import SwiftUI

struct PremiumView: View {
    @Environment(PurchaseManager.self) private var purchaseManager
    @Environment(\.dismiss) private var dismiss
    @Environment(\.purchase) private var purchase

    let language: AppLanguage
    let highlightedDocument: AppDocument?

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    heroCard
                    premiumBenefitsSection
                    includedDocumentsSection
                    footerSection
                }
                .padding(20)
            }
            .background(backgroundView)
            .navigationTitle(language.text(.premiumTitle))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(language.text(.close)) {
                        dismiss()
                    }
                    .accessibilityIdentifier("closePremiumButton")
                }
            }
        }
        .task {
            await purchaseManager.loadProducts()
        }
    }

    private var heroCard: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(language.text(.premiumHeadline))
                .font(.system(size: 28, weight: .bold, design: .serif))
                .foregroundStyle(.white)

            Text(heroMessage)
                .font(.body)
                .foregroundStyle(Color.white.opacity(0.82))

            Text(language.text(.premiumTestingNote))
                .font(.footnote.weight(.medium))
                .foregroundStyle(Color.white.opacity(0.66))

            if let premiumProduct = purchaseManager.premiumProduct {
                Text(premiumProduct.displayPrice)
                    .font(.title3.weight(.semibold))
                    .foregroundStyle(Color(red: 0.95, green: 0.89, blue: 0.75))
            } else {
                Text(language.text(.premiumNotAvailableYet))
                    .font(.subheadline.weight(.medium))
                    .foregroundStyle(Color.white.opacity(0.7))
            }

            VStack(spacing: 12) {
                Button {
                    Task {
                        guard let premiumProduct = purchaseManager.premiumProduct else { return }

                        purchaseManager.beginPurchase()

                        do {
                            let result = try await purchase(premiumProduct)
                            await purchaseManager.completePurchase(result)
                            if purchaseManager.hasPremiumAccess {
                                dismiss()
                            }
                        } catch {
                            purchaseManager.handlePurchaseError(error)
                        }
                    }
                } label: {
                    Text(language.text(.unlockPremiumLifetime))
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                }
                .buttonStyle(.borderedProminent)
                .tint(Color(red: 0.73, green: 0.59, blue: 0.33))
                .disabled(purchaseManager.premiumProduct == nil || purchaseManager.isProcessingPurchase)
                .accessibilityIdentifier("buyPremiumButton")

                Button {
                    Task {
                        await purchaseManager.restorePurchases()
                        if purchaseManager.hasPremiumAccess {
                            dismiss()
                        }
                    }
                } label: {
                    Text(language.text(.restorePurchases))
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 12)
                }
                .buttonStyle(.bordered)
                .tint(.white)
                .accessibilityIdentifier("restorePurchasesButton")
            }

            if purchaseManager.hasPremiumAccess {
                Text(language.text(.premiumUnlocked))
                    .font(.footnote.weight(.semibold))
                    .foregroundStyle(Color.green.opacity(0.95))
            } else if let statusMessage = purchaseManager.statusMessage, !statusMessage.isEmpty {
                Text(statusMessage)
                    .font(.footnote)
                    .foregroundStyle(Color.white.opacity(0.72))
            }
        }
        .padding(24)
        .background(
            RoundedRectangle(cornerRadius: 28)
                .fill(
                    LinearGradient(
                        colors: [
                            Color(red: 0.15, green: 0.18, blue: 0.27),
                            Color(red: 0.35, green: 0.26, blue: 0.16)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
        )
        .overlay(
            RoundedRectangle(cornerRadius: 28)
                .stroke(Color.white.opacity(0.10), lineWidth: 1)
        )
    }

    private var includedDocumentsSection: some View {
        VStack(alignment: .leading, spacing: 14) {
            Text(language.text(.premiumIncludes))
                .font(.system(size: 22, weight: .semibold, design: .serif))
                .foregroundStyle(.white)

            ForEach(MonetizationPlan.premiumDocuments) { document in
                HStack(spacing: 12) {
                    Image(systemName: highlightedDocument == document ? "star.fill" : "checkmark.seal.fill")
                        .foregroundStyle(document.accent)

                    Text(document.title(for: language))
                        .foregroundStyle(.white)

                    Spacer()

                    if highlightedDocument == document {
                        Text(language.text(.selectedPremiumDocument))
                            .font(.caption.weight(.semibold))
                            .foregroundStyle(document.accent)
                    }
                }
                .padding(.vertical, 6)
            }
        }
    }

    private var premiumBenefitsSection: some View {
        VStack(alignment: .leading, spacing: 14) {
            Text(language.text(.premiumBenefitsTitle))
                .font(.system(size: 22, weight: .semibold, design: .serif))
                .foregroundStyle(.white)

            ForEach(premiumBenefits, id: \.self) { benefit in
                HStack(alignment: .top, spacing: 12) {
                    Image(systemName: "crown.fill")
                        .foregroundStyle(Color(red: 0.73, green: 0.59, blue: 0.33))
                        .padding(.top, 2)

                    Text(benefit)
                        .foregroundStyle(Color.white.opacity(0.84))
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 24)
                .fill(Color.white.opacity(0.07))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 24)
                .stroke(Color.white.opacity(0.08), lineWidth: 1)
        )
    }

    private var footerSection: some View {
        Text(language.text(.premiumDisclaimer))
            .font(.footnote)
            .foregroundStyle(Color.white.opacity(0.68))
            .fixedSize(horizontal: false, vertical: true)
    }

    private var heroMessage: String {
        if let highlightedDocument {
            return language.premiumMessage(for: highlightedDocument)
        }

        return language.text(.premiumDescription)
    }

    private var premiumBenefits: [String] {
        [
            language.text(.premiumBenefitOne),
            language.text(.premiumBenefitTwo),
            language.text(.premiumBenefitThree)
        ]
    }

    private var backgroundView: some View {
        LinearGradient(
            colors: [
                Color(red: 0.08, green: 0.10, blue: 0.14),
                Color(red: 0.17, green: 0.13, blue: 0.10),
                Color(red: 0.32, green: 0.25, blue: 0.18)
            ],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        .ignoresSafeArea()
    }
}

#Preview {
    PremiumView(language: .english, highlightedDocument: .testament)
        .environment(PurchaseManager())
}
