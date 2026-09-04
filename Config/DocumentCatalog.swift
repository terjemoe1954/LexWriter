//
//  DocumentCatalog.swift
//  LexWriter
//
//  Created by Codex on 04/09/2026.
//

import SwiftUI

enum DocumentAccessTier {
    case free
    case premium
}

enum AppDocument: String, CaseIterable, Identifiable {
    case testament
    case contract
    case powerOfAttorney
    case rentalAgreement
    case cohabitationAgreement
    case debtInstrument
    case purchaseAgreement
    case rentalTermination
    case receipt
    case loanAgreement
    case employmentAgreement
    case nda

    var id: String { rawValue }

    var accessTier: DocumentAccessTier {
        switch self {
        case .purchaseAgreement, .receipt, .loanAgreement:
            return .free
        case .testament,
                .contract,
                .powerOfAttorney,
                .rentalAgreement,
                .cohabitationAgreement,
                .debtInstrument,
                .rentalTermination,
                .employmentAgreement,
                .nda:
            return .premium
        }
    }

    var iconName: String {
        switch self {
        case .testament:
            return "scroll.fill"
        case .contract:
            return "doc.text.fill"
        case .powerOfAttorney:
            return "signature"
        case .rentalAgreement:
            return "building.2.fill"
        case .cohabitationAgreement:
            return "person.2.fill"
        case .debtInstrument:
            return "banknote.fill"
        case .purchaseAgreement:
            return "car.fill"
        case .rentalTermination:
            return "key.slash.fill"
        case .receipt:
            return "receipt.fill"
        case .loanAgreement:
            return "creditcard.fill"
        case .employmentAgreement:
            return "briefcase.fill"
        case .nda:
            return "lock.doc.fill"
        }
    }

    var accent: Color {
        switch self {
        case .testament:
            return Color(red: 0.78, green: 0.64, blue: 0.39)
        case .contract:
            return Color(red: 0.42, green: 0.54, blue: 0.60)
        case .powerOfAttorney:
            return Color(red: 0.52, green: 0.44, blue: 0.29)
        case .rentalAgreement:
            return Color(red: 0.38, green: 0.46, blue: 0.55)
        case .cohabitationAgreement:
            return Color(red: 0.56, green: 0.43, blue: 0.31)
        case .debtInstrument:
            return Color(red: 0.30, green: 0.50, blue: 0.39)
        case .purchaseAgreement:
            return Color(red: 0.58, green: 0.47, blue: 0.29)
        case .rentalTermination:
            return Color(red: 0.50, green: 0.42, blue: 0.32)
        case .receipt:
            return Color(red: 0.54, green: 0.46, blue: 0.24)
        case .loanAgreement:
            return Color(red: 0.32, green: 0.49, blue: 0.40)
        case .employmentAgreement:
            return Color(red: 0.36, green: 0.44, blue: 0.55)
        case .nda:
            return Color(red: 0.43, green: 0.39, blue: 0.56)
        }
    }

    func title(for language: AppLanguage) -> String {
        switch self {
        case .testament:
            return language.text(.testamentTitle)
        case .contract:
            return language.text(.contractTitle)
        case .powerOfAttorney:
            return language.text(.powerOfAttorneyTitle)
        case .rentalAgreement:
            return language.rentalText(.title)
        case .cohabitationAgreement:
            return language.cohabitationText(.title)
        case .debtInstrument:
            return language.debtText(.title)
        case .purchaseAgreement:
            return language.purchaseText(.title)
        case .rentalTermination:
            return language.rentalTerminationText(.title)
        case .receipt:
            return language.receiptText(.title)
        case .loanAgreement:
            return language.loanAgreementText(.title)
        case .employmentAgreement:
            return language.employmentAgreementText(.title)
        case .nda:
            return language.ndaText(.title)
        }
    }

    func subtitle(for language: AppLanguage) -> String {
        switch self {
        case .testament:
            return language.text(.testamentSubtitle)
        case .contract:
            return language.contractText(.cardSubtitle)
        case .powerOfAttorney:
            return language.powerOfAttorneyText(.cardSubtitle)
        case .rentalAgreement:
            return language.rentalText(.cardSubtitle)
        case .cohabitationAgreement:
            return language.cohabitationText(.cardSubtitle)
        case .debtInstrument:
            return language.debtText(.cardSubtitle)
        case .purchaseAgreement:
            return language.purchaseText(.cardSubtitle)
        case .rentalTermination:
            return language.rentalTerminationText(.cardSubtitle)
        case .receipt:
            return language.receiptText(.cardSubtitle)
        case .loanAgreement:
            return language.loanAgreementText(.cardSubtitle)
        case .employmentAgreement:
            return language.employmentAgreementText(.cardSubtitle)
        case .nda:
            return language.ndaText(.cardSubtitle)
        }
    }

    @ViewBuilder
    func destinationView(language: AppLanguage) -> some View {
        switch self {
        case .testament:
            TestamentEditorView(language: language)
        case .contract:
            ContractEditorView(language: language)
        case .powerOfAttorney:
            PowerOfAttorneyEditorView(language: language)
        case .rentalAgreement:
            RentalAgreementEditorView(language: language)
        case .cohabitationAgreement:
            CohabitationAgreementEditorView(language: language)
        case .debtInstrument:
            DebtInstrumentEditorView(language: language)
        case .purchaseAgreement:
            PurchaseAgreementEditorView(language: language)
        case .rentalTermination:
            RentalTerminationEditorView(language: language)
        case .receipt:
            ReceiptEditorView(language: language)
        case .loanAgreement:
            LoanAgreementEditorView(language: language)
        case .employmentAgreement:
            EmploymentAgreementEditorView(language: language)
        case .nda:
            NDAEditorView(language: language)
        }
    }
}

enum MonetizationPlan {
    static let premiumLockingDefaultsKey = "premiumLockingEnabled"
    static let showsPremiumBadges = false
    static let showsTestingControls = false
    static let freeDocuments: [AppDocument] = AppDocument.allCases.filter { $0.accessTier == .free }
    static let premiumDocuments: [AppDocument] = AppDocument.allCases.filter { $0.accessTier == .premium }

    static var isPremiumEnforced: Bool {
        guard showsTestingControls else { return false }
        return UserDefaults.standard.bool(forKey: premiumLockingDefaultsKey)
    }

    static func badgeText(for document: AppDocument, language: AppLanguage) -> String {
        guard showsPremiumBadges else { return "" }

        switch document.accessTier {
        case .free:
            return language.text(.freeTier)
        case .premium:
            return language.text(.premiumTier)
        }
    }
}
