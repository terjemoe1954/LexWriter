//
//  LexWriterTests.swift
//  LexWriterTests
//
//  Created by Terje Moe on 28/08/2026.
//

import Foundation
import Testing
@testable import LexWriter

@MainActor
struct LexWriterTests {
    @Test func monetizationPlanShowsBadgesWithoutEnforcingPremium() async throws {
        #expect(MonetizationPlan.showsPremiumBadges)
        #expect(!MonetizationPlan.isPremiumStoreEnabled)
        #expect(!MonetizationPlan.enforcesPremiumAccess)
        #expect(!MonetizationPlan.isPremiumEnforced)
    }

    @Test func monetizationPlanKeepsExpectedFreeAndPremiumDocuments() async throws {
        #expect(MonetizationPlan.freeDocuments == [.purchaseAgreement, .receipt, .loanAgreement])
        #expect(MonetizationPlan.premiumDocuments.contains(.testament))
        #expect(MonetizationPlan.premiumDocuments.contains(.nda))
        #expect(MonetizationPlan.premiumDocuments.count == 9)
    }

    @Test func monetizationPlanReturnsLocalizedBadgeText() async throws {
        #expect(MonetizationPlan.badgeText(for: .purchaseAgreement, language: .norwegian) == "Gratis")
        #expect(MonetizationPlan.badgeText(for: .testament, language: .norwegian) == "Premium")
        #expect(MonetizationPlan.badgeText(for: .purchaseAgreement, language: .english) == "Free")
        #expect(MonetizationPlan.badgeText(for: .testament, language: .english) == "Premium")
    }

    @Test func premiumPreviewStatusExplainsAllDocumentsAreOpen() async throws {
        #expect(AppLanguage.norwegian.text(.allDocumentsOpenNow) == "Alle dokumenter er åpne nå")
        #expect(AppLanguage.english.text(.allDocumentsOpenNow) == "All documents open now")
    }

    @Test func premiumPreviewHeadlineExplainsPremiumIsPlanned() async throws {
        #expect(AppLanguage.norwegian.text(.premiumPreviewHeadline) == "Premium er planlagt")
        #expect(AppLanguage.english.text(.premiumPreviewHeadline) == "Premium is planned")
    }

    @Test func premiumPreviewIncludesExplainsCollectionIsPlanned() async throws {
        #expect(AppLanguage.norwegian.text(.premiumPreviewIncludes) == "Planlagt premiumsamling")
        #expect(AppLanguage.english.text(.premiumPreviewIncludes) == "Planned premium collection")
    }

    @Test func settingsPremiumButtonExplainsPlannedPremium() async throws {
        #expect(AppLanguage.norwegian.text(.openPremiumPlan) == "Se planlagt premium")
        #expect(AppLanguage.english.text(.openPremiumPlan) == "View planned premium")
    }

    @Test func purchaseManagerUnlocksDocumentsByAccessTier() async throws {
        let suiteName = "LexWriterTests.purchaseManagerUnlocksDocumentsByAccessTier"
        let userDefaults = try #require(UserDefaults(suiteName: suiteName))
        userDefaults.removePersistentDomain(forName: suiteName)
        userDefaults.set(false, forKey: "hasPremiumAccess")
        let freeManager = PurchaseManager(userDefaults: userDefaults)

        #expect(freeManager.isDocumentUnlocked(.purchaseAgreement))
        #expect(!freeManager.isDocumentUnlocked(.testament))

        userDefaults.set(true, forKey: "hasPremiumAccess")
        let premiumManager = PurchaseManager(userDefaults: userDefaults)

        #expect(premiumManager.isDocumentUnlocked(.purchaseAgreement))
        #expect(premiumManager.isDocumentUnlocked(.testament))

        userDefaults.removePersistentDomain(forName: suiteName)
    }

    @Test func witnessCannotAlsoBeBeneficiary() async throws {
        var form = TestamentFormData()
        form.testatorName = "Ola Nordmann"
        form.testatorAddress = "Gate 1"
        form.testamentPlace = "Oslo"
        form.witnessesPresentTogetherConfirmed = true
        form.witnessesKnowItsATestamentConfirmed = true
        form.witnessesAreEligibleConfirmed = true
        form.beneficiaries = [
            BeneficiaryEntry(name: "Kari Nordmann", disposition: "hytten")
        ]
        form.witnessOne = WitnessInfo(name: "Kari Nordmann", address: "Vei 2")
        form.witnessTwo = WitnessInfo(name: "Per Hansen", address: "Vei 3")

        #expect(form.blockingIssues(in: .norwegian).contains { $0.message.contains("Vitne 1 kan ikke stå som arving") })
    }

    @Test func childrenProducePliktdelsWarning() async throws {
        var form = TestamentFormData()
        form.testatorName = "Ola Nordmann"
        form.testatorAddress = "Gate 1"
        form.testamentPlace = "Oslo"
        form.witnessesPresentTogetherConfirmed = true
        form.witnessesKnowItsATestamentConfirmed = true
        form.witnessesAreEligibleConfirmed = true
        form.beneficiaries = [
            BeneficiaryEntry(name: "Norsk Redningshund", disposition: "kr 500 000")
        ]
        form.witnessOne = WitnessInfo(name: "Vitne En", address: "Vei 2")
        form.witnessTwo = WitnessInfo(name: "Vitne To", address: "Vei 3")

        #expect(form.warnings(in: .norwegian).contains { $0.message.contains("§ 50") })
    }

    @Test func validFormHasNoBlockingIssues() async throws {
        var form = TestamentFormData()
        form.testatorName = "Ola Nordmann"
        form.testatorAddress = "Gate 1"
        form.testamentPlace = "Oslo"
        form.witnessesPresentTogetherConfirmed = true
        form.witnessesKnowItsATestamentConfirmed = true
        form.witnessesAreEligibleConfirmed = true
        form.hasChildren = false
        form.beneficiaries = [
            BeneficiaryEntry(name: "Kari Nordmann", disposition: "leiligheten i Oslo")
        ]
        form.witnessOne = WitnessInfo(name: "Vitne En", address: "Vei 2")
        form.witnessTwo = WitnessInfo(name: "Vitne To", address: "Vei 3")

        #expect(form.blockingIssues(in: .norwegian).isEmpty)
    }
}
