//
//  LexWriterTests.swift
//  LexWriterTests
//
//  Created by Terje Moe on 28/08/2026.
//

import Foundation
import SwiftUI
import Testing
@testable import LexWriter

@MainActor
struct LexWriterTests {
    @Test func monetizationPlanShowsBadgesWithoutEnforcingPremium() async throws {
        #expect(MonetizationPlan.premiumLockingDefaultsKey == "premiumLockingEnabled")
        #expect(MonetizationPlan.showsPremiumBadges)
        #expect(!MonetizationPlan.showsTestingControls)
        #expect(!MonetizationPlan.isPremiumStoreEnabled)
        #expect(!MonetizationPlan.enforcesPremiumAccess)
        #expect(!MonetizationPlan.isPremiumEnforced)
    }

    @Test func monetizationPlanKeepsExpectedFreeAndPremiumDocuments() async throws {
        #expect(MonetizationPlan.freeDocuments == [.purchaseAgreement, .receipt, .loanAgreement])
        #expect(MonetizationPlan.premiumDocuments == [
            .testament,
            .contract,
            .powerOfAttorney,
            .rentalAgreement,
            .cohabitationAgreement,
            .debtInstrument,
            .rentalTermination,
            .employmentAgreement,
            .nda
        ])
        #expect(MonetizationPlan.freeDocuments.count + MonetizationPlan.premiumDocuments.count == AppDocument.allCases.count)
    }

    @Test func monetizationPlanMatchesDocumentAccessTiers() async throws {
        for document in AppDocument.allCases {
            switch document.accessTier {
            case .free:
                #expect(MonetizationPlan.freeDocuments.contains(document))
                #expect(!MonetizationPlan.premiumDocuments.contains(document))
            case .premium:
                #expect(MonetizationPlan.premiumDocuments.contains(document))
                #expect(!MonetizationPlan.freeDocuments.contains(document))
            }
        }
    }

    @Test func monetizationPlanReturnsLocalizedBadgeText() async throws {
        #expect(MonetizationPlan.badgeText(for: .purchaseAgreement, language: .norwegian) == "Gratis")
        #expect(MonetizationPlan.badgeText(for: .testament, language: .norwegian) == "Premium")
        #expect(MonetizationPlan.badgeText(for: .purchaseAgreement, language: .english) == "Free")
        #expect(MonetizationPlan.badgeText(for: .testament, language: .english) == "Premium")
    }

    @Test func appLanguageKeepsExpectedSupportedLanguages() async throws {
        #expect(AppLanguage.allCases == [.norwegian, .english, .thai])
        #expect(AppLanguage.allCases.map(\.rawValue) == ["norwegian", "english", "thai"])
        #expect(AppLanguage.allCases.map(\.id) == ["norwegian", "english", "thai"])
        #expect(AppLanguage.norwegian.displayName == "Norsk")
        #expect(AppLanguage.english.displayName == "English")
        #expect(AppLanguage.thai.displayName == "ไทย")
    }

    @Test func appAppearanceKeepsStableStoredIdentifiers() async throws {
        #expect(AppAppearance.allCases == [.system, .light, .dark])
        #expect(AppAppearance.allCases.map(\.rawValue) == ["system", "light", "dark"])
        #expect(AppAppearance.allCases.map(\.id) == ["system", "light", "dark"])
        #expect(AppAppearance.system.colorScheme == nil)
        #expect(AppAppearance.light.colorScheme == .light)
        #expect(AppAppearance.dark.colorScheme == .dark)

        for language in AppLanguage.allCases {
            for appearance in AppAppearance.allCases {
                #expect(!language.text(appearance.localizedKey).isEmpty)
            }
        }
    }

    @Test func settingsLocalizationExistsForEveryLanguage() async throws {
        let keys: [LocalizedKey] = [
            .settings,
            .language,
            .appearance,
            .accessPlan,
            .currentEdition,
            .allDocumentsOpenNow,
            .help,
            .userGuide,
            .privacy,
            .appInfo,
            .version,
            .build,
            .versionAndBuild
        ]

        for language in AppLanguage.allCases {
            for key in keys {
                #expect(!language.text(key).trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
            }
        }
    }

    @Test func homeLocalizationExistsForEveryLanguage() async throws {
        let keys: [LocalizedKey] = [
            .appTitle,
            .heroTitle,
            .heroSubtitle,
            .homeLegalNote,
            .documents,
            .freeDocumentsTitle,
            .moreDocumentTemplatesTitle,
            .plannedPremiumTemplatesTitle,
            .settings
        ]

        for language in AppLanguage.allCases {
            for key in keys {
                #expect(!language.text(key).trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
            }
        }
    }

    @Test func homeLegalNoteKeepsLegalScopeClearInEveryLanguage() async throws {
        #expect(AppLanguage.norwegian.text(.homeLegalNote) == "Dokumentene er maler og utkast, ikke juridisk rådgivning.")
        #expect(AppLanguage.english.text(.homeLegalNote) == "Documents are templates and drafts, not legal advice.")
        #expect(AppLanguage.thai.text(.homeLegalNote) == "เอกสารเป็นเทมเพลตและร่าง ไม่ใช่คำปรึกษาทางกฎหมาย")
    }

    @Test func privacySummaryKeepsLocalOnlyDataScopeClearInEveryLanguage() async throws {
        #expect(AppLanguage.norwegian.text(.privacySummary).contains("samler ikke inn persondata"))
        #expect(AppLanguage.norwegian.text(.privacySummary).contains("sporer deg"))
        #expect(AppLanguage.english.text(.privacySummary).contains("does not collect personal data"))
        #expect(AppLanguage.english.text(.privacySummary).contains("track you"))
        #expect(AppLanguage.thai.text(.privacySummary).contains("ไม่เก็บรวบรวมข้อมูลส่วนบุคคล"))
        #expect(AppLanguage.thai.text(.privacySummary).contains("ไม่ติดตามคุณ"))
    }

    @Test func userGuideKeepsAccessPrivacyAndLegalScopeClearInEveryLanguage() async throws {
        #expect(AppLanguage.norwegian.guideText(.accessBody).contains("alle dokumenter fortsatt tilgjengelige"))
        #expect(AppLanguage.english.guideText(.accessBody).contains("all documents remain available"))
        #expect(AppLanguage.thai.guideText(.accessBody).contains("เอกสารทั้งหมดยังคงใช้งานได้"))

        #expect(AppLanguage.norwegian.guideText(.privacyBody).contains("uten at sensitive personopplysninger må lagres permanent"))
        #expect(AppLanguage.english.guideText(.privacyBody).contains("without requiring permanent storage of sensitive personal data"))
        #expect(AppLanguage.thai.guideText(.privacyBody).contains("ไม่จำเป็นต้องจัดเก็บข้อมูลส่วนบุคคลที่อ่อนไหวอย่างถาวร"))

        #expect(AppLanguage.norwegian.guideText(.importantBody).contains("gjennomgås av advokat eller annen kvalifisert rådgiver"))
        #expect(AppLanguage.english.guideText(.importantBody).contains("reviewed by a lawyer or other qualified adviser"))
        #expect(AppLanguage.thai.guideText(.importantBody).contains("ควรให้ทนายหรือผู้เชี่ยวชาญที่เหมาะสมตรวจทาน"))
    }

    @Test func userGuideLocalizationExistsForEveryLanguage() async throws {
        let keys: [UserGuideLocalizedKey] = [
            .gettingStartedTitle,
            .gettingStartedBody,
            .documentsTitle,
            .documentsBody,
            .accessTitle,
            .accessBody,
            .printingTitle,
            .printingBody,
            .privacyTitle,
            .privacyBody,
            .importantTitle,
            .importantBody
        ]

        for language in AppLanguage.allCases {
            for key in keys {
                #expect(!language.guideText(key).isEmpty)
            }
        }
    }

    @Test func monetizationPlanReturnsExpectedBadgeTextForEveryDocument() async throws {
        for language in AppLanguage.allCases {
            for document in MonetizationPlan.freeDocuments {
                #expect(MonetizationPlan.badgeText(for: document, language: language) == language.text(.freeTier))
            }

            for document in MonetizationPlan.premiumDocuments {
                #expect(MonetizationPlan.badgeText(for: document, language: language) == language.text(.premiumTier))
            }
        }
    }

    @Test func documentCatalogProvidesTitlesAndSubtitlesForEveryLanguage() async throws {
        for language in AppLanguage.allCases {
            for document in AppDocument.allCases {
                #expect(!document.title(for: language).isEmpty)
                #expect(!document.subtitle(for: language).isEmpty)
            }
        }
    }

    @Test func documentCatalogProvidesDistinctTitlesForEveryLanguage() async throws {
        for language in AppLanguage.allCases {
            let titles = AppDocument.allCases.map { $0.title(for: language) }

            #expect(Set(titles).count == AppDocument.allCases.count)
        }
    }

    @Test func documentCatalogProvidesDistinctSubtitlesForEveryLanguage() async throws {
        for language in AppLanguage.allCases {
            let subtitles = AppDocument.allCases.map { $0.subtitle(for: language) }

            #expect(Set(subtitles).count == AppDocument.allCases.count)
        }
    }

    @Test func documentCatalogKeepsStableDocumentOrderAndIdentifiers() async throws {
        #expect(AppDocument.allCases == [
            .testament,
            .contract,
            .powerOfAttorney,
            .rentalAgreement,
            .cohabitationAgreement,
            .debtInstrument,
            .purchaseAgreement,
            .rentalTermination,
            .receipt,
            .loanAgreement,
            .employmentAgreement,
            .nda
        ])

        let identifiers = AppDocument.allCases.map(\.id)

        #expect(identifiers == [
            "testament",
            "contract",
            "powerOfAttorney",
            "rentalAgreement",
            "cohabitationAgreement",
            "debtInstrument",
            "purchaseAgreement",
            "rentalTermination",
            "receipt",
            "loanAgreement",
            "employmentAgreement",
            "nda"
        ])
        #expect(Set(identifiers).count == AppDocument.allCases.count)
    }

    @Test func documentCatalogProvidesDistinctIconsForEveryDocument() async throws {
        let iconNames = AppDocument.allCases.map(\.iconName)

        #expect(iconNames.allSatisfy { !$0.isEmpty })
        #expect(Set(iconNames).count == AppDocument.allCases.count)
    }

    @Test func documentChecklistsProvideThreeDistinctItemsForEveryLanguage() async throws {
        for language in AppLanguage.allCases {
            let checklistSections = [
                (language.purchaseText(.legalChecklistTitle), language.purchaseChecklist),
                (language.receiptText(.legalChecklistTitle), language.receiptChecklist),
                (language.loanAgreementText(.legalChecklistTitle), language.loanAgreementChecklist),
                (language.contractText(.legalChecklistTitle), language.contractChecklist),
                (language.powerOfAttorneyText(.legalChecklistTitle), language.powerOfAttorneyChecklist),
                (language.rentalText(.legalChecklistTitle), language.rentalChecklist),
                (language.cohabitationText(.legalChecklistTitle), language.cohabitationChecklist),
                (language.debtText(.legalChecklistTitle), language.debtChecklist),
                (language.rentalTerminationText(.legalChecklistTitle), language.rentalTerminationChecklist),
                (language.employmentAgreementText(.legalChecklistTitle), language.employmentAgreementChecklist),
                (language.ndaText(.legalChecklistTitle), language.ndaChecklist)
            ]

            for (title, items) in checklistSections {
                #expect(!title.isEmpty)
                #expect(items.count == 3)
                #expect(items.allSatisfy { !$0.isEmpty })
                #expect(Set(items).count == items.count)
            }
        }
    }

    @Test func documentPreviewButtonsExistForEveryLanguage() async throws {
        for language in AppLanguage.allCases {
            let previewButtonTexts = [
                language.purchaseText(.previewButton),
                language.receiptText(.previewButton),
                language.loanAgreementText(.previewButton),
                language.text(.showWill),
                language.contractText(.previewButton),
                language.powerOfAttorneyText(.previewButton),
                language.rentalText(.previewButton),
                language.cohabitationText(.previewButton),
                language.debtText(.previewButton),
                language.rentalTerminationText(.previewButton),
                language.employmentAgreementText(.previewButton),
                language.ndaText(.previewButton)
            ]

            #expect(previewButtonTexts.count == AppDocument.allCases.count)
            #expect(previewButtonTexts.allSatisfy { !$0.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty })

            switch language {
            case .norwegian:
                #expect(previewButtonTexts.allSatisfy { $0.hasPrefix("Vis") })
            case .english:
                #expect(previewButtonTexts.allSatisfy { $0.hasPrefix("Show") })
            case .thai:
                #expect(previewButtonTexts.allSatisfy { $0.hasPrefix("แสดง") })
            }
        }
    }

    @Test func printPreviewControlsExistForEveryLanguage() async throws {
        for language in AppLanguage.allCases {
            let previewControls = [
                language.text(.previewTitle),
                language.text(.close),
                language.text(.printButton),
                language.text(.savePDFButton),
                language.text(.signatureAndDate)
            ]

            #expect(previewControls.allSatisfy { !$0.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty })
            #expect(language.text(.printButton) != language.text(.savePDFButton))

            switch language {
            case .norwegian:
                #expect(language.text(.savePDFButton).contains("PDF"))
            case .english:
                #expect(language.text(.savePDFButton).contains("PDF"))
            case .thai:
                #expect(language.text(.savePDFButton).contains("PDF"))
            }
        }
    }

    @Test func documentValidationMessagesExistForEveryLanguage() async throws {
        for language in AppLanguage.allCases {
            let validationSets: [(blocking: [ValidationMessage], warnings: [ValidationMessage])] = [
                (PurchaseAgreementFormData().blockingIssues(in: language), PurchaseAgreementFormData().warnings(in: language)),
                (ReceiptFormData().blockingIssues(in: language), ReceiptFormData().warnings(in: language)),
                (LoanAgreementFormData().blockingIssues(in: language), LoanAgreementFormData().warnings(in: language)),
                (TestamentFormData().blockingIssues(in: language), TestamentFormData().warnings(in: language)),
                (ContractFormData().blockingIssues(in: language), ContractFormData().warnings(in: language)),
                (PowerOfAttorneyFormData().blockingIssues(in: language), PowerOfAttorneyFormData().warnings(in: language)),
                (RentalAgreementFormData().blockingIssues(in: language), RentalAgreementFormData().warnings(in: language)),
                (CohabitationAgreementFormData().blockingIssues(in: language), CohabitationAgreementFormData().warnings(in: language)),
                (DebtInstrumentFormData().blockingIssues(in: language), DebtInstrumentFormData().warnings(in: language)),
                (RentalTerminationFormData().blockingIssues(in: language), RentalTerminationFormData().warnings(in: language)),
                (EmploymentAgreementFormData().blockingIssues(in: language), EmploymentAgreementFormData().warnings(in: language)),
                (NDAFormData().blockingIssues(in: language), NDAFormData().warnings(in: language))
            ]

            for validationSet in validationSets {
                #expect(!validationSet.blocking.isEmpty)
                #expect(!validationSet.warnings.isEmpty)
                #expect(validationSet.blocking.allSatisfy { $0.severity == .blocking && !$0.message.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty })
                #expect(validationSet.warnings.allSatisfy { $0.severity == .warning && !$0.message.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty })
            }

            let signingRequirements = TestamentFormData.signingRequirements(in: language)
            #expect(signingRequirements.count == 4)
            #expect(signingRequirements.allSatisfy { !$0.title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty })

            let completionRequirements = TestamentFormData().completionRequirements(in: language)
            #expect(completionRequirements.count == 6)
            #expect(completionRequirements.allSatisfy { !$0.title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty })
        }
    }

    @Test func documentHTMLPreviewsKeepPrintableSignatureStructure() async throws {
        let htmlDocuments = [
            PurchaseAgreementFormData().document.htmlDocument(in: .norwegian),
            ReceiptFormData().document.htmlDocument(in: .norwegian),
            LoanAgreementFormData().document.htmlDocument(in: .norwegian),
            TestamentFormData().generatedDocument.htmlDocument,
            ContractFormData().document.htmlDocument(in: .norwegian),
            PowerOfAttorneyFormData().document.htmlDocument(in: .norwegian),
            RentalAgreementFormData().document.htmlDocument(in: .norwegian),
            CohabitationAgreementFormData().document.htmlDocument(in: .norwegian),
            DebtInstrumentFormData().document.htmlDocument(in: .norwegian),
            RentalTerminationFormData().document.htmlDocument(in: .norwegian),
            EmploymentAgreementFormData().document.htmlDocument(in: .norwegian),
            NDAFormData().document.htmlDocument(in: .norwegian)
        ]

        #expect(htmlDocuments.count == AppDocument.allCases.count)

        for html in htmlDocuments {
            #expect(html.contains("<html>"))
            #expect(html.contains("<head>"))
            #expect(html.contains("<body>"))
            #expect(html.contains("<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">"))
            #expect(html.contains("<div class=\"paper\">"))
            #expect(html.contains("<div class=\"signature\">"))
            #expect(html.contains("class=\"line\""))
            #expect(html.contains("</html>"))
        }
    }

    @Test func premiumPreviewStatusExplainsAllDocumentsAreOpen() async throws {
        #expect(AppLanguage.norwegian.text(.allDocumentsOpenNow) == "Alle dokumenter er åpne nå")
        #expect(AppLanguage.english.text(.allDocumentsOpenNow) == "All documents open now")
        #expect(AppLanguage.thai.text(.allDocumentsOpenNow) == "เอกสารทั้งหมดเปิดใช้งานอยู่ตอนนี้")
    }

    @Test func premiumPreviewHeadlineExplainsPremiumIsPlanned() async throws {
        #expect(AppLanguage.norwegian.text(.premiumPreviewHeadline) == "Premium er planlagt")
        #expect(AppLanguage.english.text(.premiumPreviewHeadline) == "Premium is planned")
        #expect(AppLanguage.thai.text(.premiumPreviewHeadline) == "มีแผนเพิ่มพรีเมียม")
    }

    @Test func premiumPreviewDescriptionExplainsPaidPremiumIsLater() async throws {
        #expect(AppLanguage.norwegian.text(.premiumPreviewDescription).contains("Betalt premium er planlagt"))
        #expect(AppLanguage.english.text(.premiumPreviewDescription).contains("Paid premium is planned"))
        #expect(AppLanguage.thai.text(.premiumPreviewDescription).contains("มีแผนเพิ่มพรีเมียมแบบชำระเงิน"))
    }

    @Test func premiumPreviewExplainsPurchasesAreUnavailableInThisVersion() async throws {
        #expect(AppLanguage.norwegian.text(.premiumPurchasesUnavailableInThisVersion) == "Kjøp er ikke tilgjengelig i denne versjonen")
        #expect(AppLanguage.english.text(.premiumPurchasesUnavailableInThisVersion) == "Purchases are not available in this version")
        #expect(AppLanguage.thai.text(.premiumPurchasesUnavailableInThisVersion) == "ยังไม่สามารถซื้อได้ในเวอร์ชันนี้")
    }

    @Test func premiumPreviewIncludesExplainsCollectionIsPlanned() async throws {
        #expect(AppLanguage.norwegian.text(.premiumPreviewIncludes) == "Planlagt premiumsamling")
        #expect(AppLanguage.english.text(.premiumPreviewIncludes) == "Planned premium collection")
        #expect(AppLanguage.thai.text(.premiumPreviewIncludes) == "ชุดพรีเมียมที่วางแผนไว้")
    }

    @Test func homeScreenExplainsPlannedPremiumTemplates() async throws {
        #expect(AppLanguage.norwegian.text(.plannedPremiumTemplatesTitle) == "Planlagte premium-maler")
        #expect(AppLanguage.english.text(.plannedPremiumTemplatesTitle) == "Planned premium templates")
        #expect(AppLanguage.thai.text(.plannedPremiumTemplatesTitle) == "เทมเพลตพรีเมียมที่วางแผนไว้")
    }

    @Test func settingsPremiumButtonExplainsPlannedPremium() async throws {
        #expect(AppLanguage.norwegian.text(.openPremiumPlan) == "Se planlagt premium")
        #expect(AppLanguage.english.text(.openPremiumPlan) == "View planned premium")
        #expect(AppLanguage.thai.text(.openPremiumPlan) == "ดูแผนพรีเมียม")
    }

    @Test func accessPlanSummaryShowsFreeAndPremiumCounts() async throws {
        #expect(AppLanguage.norwegian.text(.accessPlanSummary) == "3 gratis maler og 9 planlagte premium-maler.")
        #expect(AppLanguage.english.text(.accessPlanSummary) == "3 free templates and 9 planned premium templates.")
        #expect(AppLanguage.thai.text(.accessPlanSummary) == "มีเทมเพลตฟรี 3 รายการ และเทมเพลตพรีเมียมที่วางแผนไว้ 9 รายการ")
    }

    @Test func premiumPreviewFooterExplainsAllDocumentsAreAvailableNow() async throws {
        #expect(AppLanguage.norwegian.text(.futurePricingNote).contains("Alle dokumenter er tilgjengelige nå"))
        #expect(AppLanguage.english.text(.futurePricingNote).contains("All documents are currently available"))
        #expect(AppLanguage.thai.text(.futurePricingNote).contains("ขณะนี้เอกสารทั้งหมดใช้งานได้"))
    }

    @Test func releaseAndSupportDraftsKeepPremiumPreparationMessaging() async throws {
        let drafts = try [
            projectFileContents("APPSTORE_SUBMISSION_NOTES.md"),
            projectFileContents("SUPPORT_RESPONSES.md")
        ]

        for draft in drafts {
            let lowercaseDraft = draft.localizedLowercase
            #expect(lowercaseDraft.contains("purchases are not available in this version"))
            #expect(lowercaseDraft.contains("all documents"))
            #expect(lowercaseDraft.contains("not legal advice"))
            #expect(lowercaseDraft.contains("does not collect personal data"))

            #expect(!lowercaseDraft.contains("purchases are available in this version"))
            #expect(!lowercaseDraft.contains("premium access is enforced"))
            #expect(!lowercaseDraft.contains("premium documents are locked"))
            #expect(!lowercaseDraft.contains("buy premium now"))
            #expect(!lowercaseDraft.contains("restore purchases now"))
        }
    }

    @Test func releaseChecklistKeepsPremiumPreparationGates() async throws {
        let checklist = try projectFileContents("RELEASE_CHECKLIST.md").localizedLowercase

        #expect(checklist.contains("storekit loading"))
        #expect(checklist.contains("purchase buttons"))
        #expect(checklist.contains("restore buttons"))
        #expect(checklist.contains("premium enforcement"))
        #expect(checklist.contains("disabled"))
        #expect(checklist.contains("run ui tests if ui automation is part of this release gate"))
        #expect(checklist.contains("lexwriteruitests"))
        #expect(checklist.contains("target application should point to `lexwriter`"))
    }

    @Test func releaseChecklistKeepsSubmissionValidationStepsExplicit() async throws {
        let checklist = try projectFileContents("RELEASE_CHECKLIST.md").localizedLowercase

        #expect(checklist.contains("confirm the intended version number and build number"))
        #expect(checklist.contains("update app store connect release notes"))
        #expect(checklist.contains("launch the app on a small iphone, large iphone, and ipad"))
        #expect(checklist.contains("create at least one free document and one premium-marked document"))
        #expect(checklist.contains("preview, print, and save pdf"))
        #expect(checklist.contains("check crashes, hangs, reviews, ratings, installs, and product page performance"))
        #expect(checklist.contains("confirm privacy details still match the app"))
        #expect(checklist.contains("build the app in xcode"))
        #expect(checklist.contains("run unit tests"))
        #expect(checklist.contains("archive the exact build intended for submission"))
        #expect(checklist.contains("submit to testflight first"))
    }

    @Test func releaseChecklistKeepsProductSmokeTestScopeExplicit() async throws {
        let checklist = try projectFileContents("RELEASE_CHECKLIST.md").localizedLowercase

        #expect(checklist.contains("product smoke test"))
        #expect(checklist.contains("launch the app on a small iphone, large iphone, and ipad"))
        #expect(checklist.contains("check home screen layout, document badges, legal note, settings, user guide, and premium preview"))
        #expect(checklist.contains("confirm settings shows the current access status"))
        #expect(checklist.contains("free/premium template counts"))
        #expect(checklist.contains("planned-premium entry point"))
        #expect(checklist.contains("confirm premium preview says purchases are not available in this version while storekit is disabled"))
        #expect(checklist.contains("create at least one free document and one premium-marked document"))
        #expect(checklist.contains("preview, print, and save pdf from a representative document"))
        #expect(checklist.contains("switch language between norwegian, english, and thai"))
    }

    @Test func releaseChecklistKeepsLegalTrustReviewExplicit() async throws {
        let checklist = try projectFileContents("RELEASE_CHECKLIST.md").localizedLowercase

        #expect(checklist.contains("legal and trust"))
        #expect(checklist.contains("review `known_limitations.md`"))
        #expect(checklist.contains("confirm the home screen legal note is visible"))
        #expect(checklist.contains("confirm settings includes access and privacy information"))
        #expect(checklist.contains("documents are templates and drafts, not legal advice"))
        #expect(checklist.contains("review higher-risk templates before release"))
        #expect(checklist.contains("testament"))
        #expect(checklist.contains("debt instrument"))
        #expect(checklist.contains("power of attorney"))
        #expect(checklist.contains("employment agreement"))
        #expect(checklist.contains("nda"))
    }

    @Test func releaseChecklistKeepsAppStoreConnectChecksExplicit() async throws {
        let checklist = try projectFileContents("RELEASE_CHECKLIST.md").localizedLowercase

        #expect(checklist.contains("app store connect"))
        #expect(checklist.contains("review `appstore_submission_notes.md`"))
        #expect(checklist.contains("review `support_responses.md`"))
        #expect(checklist.contains("crashes, hangs, reviews, ratings, installs"))
        #expect(checklist.contains("product page performance"))
        #expect(checklist.contains("confirm privacy details still match the app"))
        #expect(checklist.contains("confirm screenshots match the shipped ui"))
        #expect(checklist.contains("do not include premium preview screenshots"))
        #expect(checklist.contains("support email and privacy policy links are active"))
    }

    @Test func appStoreMetadataDraftsKeepPrintAndLegalScopeClear() async throws {
        let notes = try projectFileContents("APPSTORE_SUBMISSION_NOTES.md")
        let lowercaseNotes = notes.localizedLowercase

        #expect(notes.contains("Juridiske dokumentmaler for utskrift"))
        #expect(notes.contains("Legal document templates for printing"))
        #expect(lowercaseNotes.contains("fyll inn feltene"))
        #expect(lowercaseNotes.contains("print or save it as a pdf"))
        #expect(lowercaseNotes.contains("ikke juridisk rådgivning"))
        #expect(lowercaseNotes.contains("not legal advice"))
        #expect(lowercaseNotes.contains("do not claim premium purchase availability"))
    }

    @Test func appStoreReleaseNotesKeepPremiumPreparationScopeClear() async throws {
        let notes = try projectFileContents("APPSTORE_SUBMISSION_NOTES.md").localizedLowercase

        #expect(notes.contains("suggested release notes"))
        #expect(notes.contains("tydeligere merking av gratis og kommende premium-dokumenter"))
        #expect(notes.contains("home screen now labels planned premium templates"))
        #expect(notes.contains("kjøp ikke er tilgjengelig i denne versjonen"))
        #expect(notes.contains("purchases are not available in this version"))
        #expect(notes.contains("brukerveiledningen forklarer nå gratis/premium-merking"))
        #expect(notes.contains("user guide now explains free/premium labels"))
        #expect(notes.contains("ikke juridisk rådgivning"))
        #expect(notes.contains("not legal advice"))
        #expect(!notes.contains("users can buy premium now"))
        #expect(!notes.contains("premium is available for purchase"))
        #expect(!notes.contains("start your subscription"))
    }

    @Test func appStoreKeywordDraftsKeepDocumentAndPrintScope() async throws {
        let notes = try projectFileContents("APPSTORE_SUBMISSION_NOTES.md").localizedLowercase

        #expect(notes.contains("kontrakt, avtale, testament, fullmakt, kvittering, lån, pdf, utskrift, dokumentmal"))
        #expect(notes.contains("contract, agreement, will, power of attorney, receipt, loan, pdf, print, template"))
        #expect(!notes.contains("premium, unlock, subscription"))
        #expect(!notes.contains("kjøp premium"))
        #expect(!notes.contains("buy premium"))
    }

    @Test func appStoreSubmissionNotesKeepScreenshotAndReviewScopeClear() async throws {
        let notes = try projectFileContents("APPSTORE_SUBMISSION_NOTES.md").localizedLowercase

        #expect(notes.contains("premium-preparation phase"))
        #expect(notes.contains("premium access is not enforced yet"))
        #expect(notes.contains("all documents remain available"))
        #expect(notes.contains("expected product identifier"))
        #expect(notes.contains("com.lexwriter.premium.lifetime"))
        #expect(notes.contains("not that users can buy or unlock premium now"))
        #expect(notes.contains("premium preview showing \"purchases are not available in this version\""))
        #expect(notes.contains("do not use the premium preview screenshot"))
        #expect(notes.contains("premium is being prepared but is not yet enforced"))
    }

    @Test func appStoreScreenshotChecklistKeepsCoreFlowAndPremiumCaveat() async throws {
        let notes = try projectFileContents("APPSTORE_SUBMISSION_NOTES.md").localizedLowercase

        #expect(notes.contains("screenshot checklist"))
        #expect(notes.contains("home screen with free/premium badges visible"))
        #expect(notes.contains("a representative document editor"))
        #expect(notes.contains("print preview with print/pdf controls"))
        #expect(notes.contains("settings with access status"))
        #expect(notes.contains("3 free / 9 planned premium template count"))
        #expect(notes.contains("privacy sections"))
        #expect(notes.contains("screenshot priority for a normal stability or premium-preparation update"))
        #expect(notes.contains("home screen and document list"))
        #expect(notes.contains("document editor with clear fields"))
        #expect(notes.contains("premium preview only when the listing text explicitly explains that purchases are unavailable"))
        #expect(notes.contains("premium preview showing \"purchases are not available in this version\""))
        #expect(notes.contains("only if the app store listing mentions the premium-preparation state"))
        #expect(notes.contains("do not use the premium preview screenshot for a normal stability release"))

        let plan = try projectFileContents("VERSION_1_1_CANDIDATES.md").localizedLowercase
        let milestones = try projectFileContents("MILESTONES_APPSTORE.md").localizedLowercase
        #expect(plan.contains("screenshot-priority guidance"))
        #expect(milestones.contains("screenshot-priority guidance"))
    }

    @Test func uiTestTargetKeepsLexWriterAsTargetApplication() async throws {
        let project = try projectFileContents("LexWriter.xcodeproj/project.pbxproj")

        #expect(project.contains("TEST_TARGET_NAME = LexWriter;"))
        #expect(!project.contains("TEST_TARGET_NAME = DocWriter;"))
    }

    @Test func premiumPreviewLaunchRouteStaysUITestOnly() async throws {
        let app = try projectFileContents("App/LexWriterApp.swift").localizedLowercase

        #expect(app.contains("openspremiumpreviewforuitest"))
        #expect(app.contains("processinfo.processinfo.arguments.contains(\"-openpremiumpreviewuitest\")"))
        #expect(app.contains("premiumview(language: .norwegian, highlighteddocument: nil)"))
        #expect(app.contains("if monetizationplan.ispremiumstoreenabled"))
        #expect(app.contains("purchasemanager.start()"))
    }

    @Test func versionOneOnePlanKeepsPremiumActivationDeferred() async throws {
        let plan = try projectFileContents("VERSION_1_1_CANDIDATES.md").localizedLowercase

        #expect(plan.contains("trust, polish, and premium-preparation release"))
        #expect(plan.contains("should not enable paid purchases or premium locking"))
        #expect(plan.contains("keep all documents available"))
        #expect(plan.contains("keep storekit product loading disabled"))
        #expect(plan.contains("keep purchase and restore controls hidden"))
        #expect(plan.contains("keep premium enforcement disabled"))
        #expect(plan.contains("ui-test-only `-openpremiumpreviewuitest` launch route"))
        #expect(plan.contains("defer until premium activation"))
        #expect(plan.contains("enabling `ispremiumstoreenabled`"))
        #expect(plan.contains("enabling `enforcespremiumaccess`"))
        #expect(plan.contains("showing purchase or restore buttons"))
        #expect(plan.contains("locking premium-marked documents"))
    }

    @Test func codexHandoffKeepsSafeSessionInstructionsCurrent() async throws {
        let handoff = try projectFileContents("CODEX_HANDOFF.md").localizedLowercase

        #expect(handoff.contains("premium badges are visible"))
        #expect(handoff.contains("all documents remain available"))
        #expect(handoff.contains("storekit product loading is disabled"))
        #expect(handoff.contains("purchase and restore buttons are hidden"))
        #expect(handoff.contains("premium enforcement is disabled"))
        #expect(handoff.contains("unit tests: 83/83 passed"))
        #expect(handoff.contains("build for testing: succeeded"))
        #expect(handoff.contains("ui test target now points to `lexwriter`"))
        #expect(handoff.contains("ui tests: 7/7 passed"))
        #expect(handoff.contains("ui-test-only `-openpremiumpreviewuitest` launch argument"))
        #expect(handoff.contains("do not enable storekit or premium locking"))
        #expect(handoff.contains("continue from the premium-preparation workstream"))
    }

    @Test func appStoreMilestonesKeepPremiumReadinessOrderExplicit() async throws {
        let milestones = try projectFileContents("MILESTONES_APPSTORE.md").localizedLowercase

        #expect(milestones.contains("stability and trust before monetization"))
        #expect(milestones.contains("premium version readiness"))
        #expect(milestones.contains("lifetime unlock first"))
        #expect(milestones.contains("com.lexwriter.premium.lifetime"))
        #expect(milestones.contains("before turning on premium enforcement"))
        #expect(milestones.contains("follow `premium_activation.md`"))
        #expect(milestones.contains("purchase/restore value copy only when storekit is enabled"))
        #expect(milestones.contains("test purchase, restore purchase, pending purchase, cancelled purchase"))
        #expect(milestones.contains("only enable premium locking after"))
        #expect(milestones.contains("enable premium enforcement only after the product id, price, screenshots, metadata, and restore flow are confirmed"))
    }

    @Test func appStoreMilestonesKeepNextBuildOrderConservative() async throws {
        let milestones = try projectFileContents("MILESTONES_APPSTORE.md").localizedLowercase

        #expect(milestones.contains("recommended next build order"))
        #expect(milestones.contains("check app store connect for crashes, ratings, reviews, installs, and product-page performance"))
        #expect(milestones.contains("do a live-build smoke test on device"))
        #expect(milestones.contains("language selection, document creation, preview, printing, settings, and current premium entry points"))
        #expect(milestones.contains("decide the free-versus-premium document split and the initial lifetime price"))
        #expect(milestones.contains("test the lifetime unlock product in storekit and app store connect sandbox"))
        #expect(milestones.contains("maintain `version_1_1_candidates.md` from real issues first"))
        #expect(milestones.contains("run `lexwriteruitests` if ui automation should be part of the release gate"))
        #expect(milestones.contains("prepare updated app store metadata and screenshots for the paid/premium version"))
        #expect(milestones.contains("enable premium enforcement only after the product id, price, screenshots, metadata, and restore flow are confirmed"))
    }

    @Test func supportDraftsKeepSavingAndPrintScopeClear() async throws {
        let support = try projectFileContents("SUPPORT_RESPONSES.md").localizedLowercase

        #expect(support.contains("lagre dokumenter som pdf"))
        #expect(support.contains("saving documents as pdf"))
        #expect(support.contains("ikke full dokumenthistorikk"))
        #expect(support.contains("does not currently include a full document library"))
        #expect(support.contains("cloud sync"))
        #expect(support.contains("document type"))
        #expect(support.contains("device model"))
        #expect(support.contains("ios version"))
    }

    @Test func supportDraftsKeepPrivacyScopeLocalAndClear() async throws {
        let support = try projectFileContents("SUPPORT_RESPONSES.md").localizedLowercase

        #expect(support.contains("samler ikke inn persondata"))
        #expect(support.contains("sporer ikke brukere"))
        #expect(support.contains("does not collect personal data"))
        #expect(support.contains("track users"))
        #expect(support.contains("brukes lokalt"))
        #expect(support.contains("used locally"))
        #expect(support.contains("forhåndsvisning, utskrift eller pdf-eksport"))
        #expect(support.contains("preview, printing, or pdf export"))
        #expect(support.contains("lagre utskrevne eller eksporterte dokumenter trygt"))
        #expect(support.contains("storing printed or exported documents safely"))
    }

    @Test func supportDraftsKeepLegalAdviceScopeConservative() async throws {
        let support = try projectFileContents("SUPPORT_RESPONSES.md").localizedLowercase

        #expect(support.contains("dokumentmaler og dokumentutkast, ikke juridisk rådgivning"))
        #expect(support.contains("templates and document drafts, not legal advice"))
        #expect(support.contains("viktige eller kompliserte forhold"))
        #expect(support.contains("important or complex matters"))
        #expect(support.contains("inheritance"))
        #expect(support.contains("family conflict"))
        #expect(support.contains("employment"))
        #expect(support.contains("debt"))
        #expect(support.contains("business-sensitive agreements"))
        #expect(support.contains("qualified adviser before signing"))
        #expect(support.contains("premiumvisningen er synlig"))
        #expect(support.contains("kjøp og premium-låsing er ikke aktivert"))
        #expect(support.contains("premium preview screenshots should only be used"))
        #expect(support.contains("submission text explains that purchases are not available"))
    }

    @Test func knownLimitationsKeepReleaseRisksVisible() async throws {
        let limitations = try projectFileContents("KNOWN_LIMITATIONS.md").localizedLowercase

        #expect(limitations.contains("not legal advice"))
        #expect(limitations.contains("qualified adviser"))
        #expect(limitations.contains("higher-risk documents"))
        #expect(limitations.contains("testament"))
        #expect(limitations.contains("debt instrument"))
        #expect(limitations.contains("full document library"))
        #expect(limitations.contains("cloud sync"))
        #expect(limitations.contains("premium access is not enforced yet"))
        #expect(limitations.contains("purchases are not available"))
        #expect(limitations.contains("storekit product loading"))
        #expect(limitations.contains("ui test target application now points to `lexwriter`"))
        #expect(limitations.contains("ui tests pass with 7/7"))
    }

    @Test func premiumActivationGuideKeepsActivationPreconditionsExplicit() async throws {
        let guide = try projectFileContents("PREMIUM_ACTIVATION.md").localizedLowercase

        #expect(guide.contains("use this only when the paid version is ready"))
        #expect(guide.contains("storekit product loading is disabled"))
        #expect(guide.contains("premium enforcement is disabled"))
        #expect(guide.contains("com.lexwriter.premium.lifetime"))
        #expect(guide.contains("confirm the lifetime product exists"))
        #expect(guide.contains("test the product in storekit local testing or sandbox"))
        #expect(guide.contains("confirm restore purchases works"))
        #expect(guide.contains("static let ispremiumstoreenabled = true"))
        #expect(guide.contains("static let enforcespremiumaccess = true"))
        #expect(guide.contains("ui-test-only launch route"))
        #expect(guide.contains("does not enable storekit, purchases, restore, or premium enforcement"))
        #expect(guide.contains("prefer two separate releases"))
        #expect(guide.contains("premium-preparation release"))
        #expect(guide.contains("premium-enforcement release"))
    }

    @Test func premiumActivationGuideKeepsCurrentDocumentSplitExplicit() async throws {
        let guide = try projectFileContents("PREMIUM_ACTIVATION.md").localizedLowercase

        #expect(guide.contains("current free/premium split"))
        #expect(guide.contains("free documents"))
        #expect(guide.contains("purchase agreement / kjøpskontrakt"))
        #expect(guide.contains("receipt / kvittering"))
        #expect(guide.contains("loan agreement / låneavtale"))
        #expect(guide.contains("premium-marked documents"))
        #expect(guide.contains("will / testament"))
        #expect(guide.contains("contract / kontrakt"))
        #expect(guide.contains("power of attorney / fullmakt"))
        #expect(guide.contains("rental agreement / husleiekontrakt"))
        #expect(guide.contains("cohabitation agreement / samboeravtale"))
        #expect(guide.contains("debt instrument / gjeldsbrev"))
        #expect(guide.contains("termination of tenancy / oppsigelse av leieforhold"))
        #expect(guide.contains("employment agreement / arbeidsavtale"))
        #expect(guide.contains("nda"))
    }

    @Test func purchaseManagerUsesExpectedPremiumProductIdentifier() async throws {
        #expect(PurchaseManager.premiumLifetimeProductID == "com.lexwriter.premium.lifetime")
    }

    @Test func premiumPreviewLocalizationExistsForEveryLanguage() async throws {
        let keys: [LocalizedKey] = [
            .allDocumentsOpenNow,
            .accessPlanSummary,
            .premiumPreviewHeadline,
            .premiumPreviewDescription,
            .premiumPurchasesUnavailableInThisVersion,
            .premiumPreviewIncludes,
            .futurePricingNote,
            .openPremiumPlan,
            .premiumProductIdentifier,
            .premiumTitle,
            .unlockPremiumLifetime,
            .restorePurchases,
            .premiumUnlocked,
            .premiumLoadingProducts,
            .premiumNotAvailableYet,
            .premiumDisclaimer,
            .selectedPremiumDocument,
            .premiumBenefitsTitle,
            .premiumBenefitOne,
            .premiumBenefitTwo,
            .premiumBenefitThree,
            .close
        ]

        for language in AppLanguage.allCases {
            for key in keys {
                #expect(!language.text(key).isEmpty)
            }
        }
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

    @Test func purchaseAgreementValidatesRequiredFieldsAndAdvisoryWarnings() async throws {
        #expect(PurchaseAgreementFormData().blockingIssues(in: .norwegian).count == 6)
        #expect(PurchaseAgreementFormData().warnings(in: .norwegian).count == 3)

        var form = PurchaseAgreementFormData()
        form.seller = contractParty(name: "Selger")
        form.buyer = contractParty(name: "Kjoper")
        form.itemDescription = "Brukt sykkel"
        form.purchasePrice = "3 000 kroner"
        form.handoverDate = "1. oktober 2026"
        form.conditionDescription = "Selges som besiktiget."
        form.paymentTerms = "Betales ved overlevering."
        form.defectsAndClaims = "Ingen kjente mangler."
        form.signingPlace = "Oslo"

        #expect(form.blockingIssues(in: .norwegian).isEmpty)
        #expect(form.warnings(in: .norwegian).isEmpty)

        let bodyText = form.document.bodyText(in: .norwegian)
        #expect(bodyText.contains("Selger"))
        #expect(bodyText.contains("Kjoper"))
        #expect(bodyText.contains("Brukt sykkel"))
        #expect(bodyText.contains("3 000 kroner"))
    }

    @Test func receiptValidatesRequiredFieldsAndAdvisoryWarnings() async throws {
        #expect(ReceiptFormData().blockingIssues(in: .norwegian).count == 6)
        #expect(ReceiptFormData().warnings(in: .norwegian).count == 2)

        var form = ReceiptFormData()
        form.issuer = contractParty(name: "Utsteder")
        form.payer = contractParty(name: "Betaler")
        form.receiptFor = "Depositum"
        form.amount = "10 000 kroner"
        form.paymentDateText = "21. september 2026"
        form.paymentMethod = "Bankoverforing"
        form.notes = "Referanse 123"
        form.signingPlace = "Oslo"

        #expect(form.blockingIssues(in: .norwegian).isEmpty)
        #expect(form.warnings(in: .norwegian).isEmpty)

        let bodyText = form.document.bodyText(in: .norwegian)
        #expect(bodyText.contains("Utsteder"))
        #expect(bodyText.contains("Betaler"))
        #expect(bodyText.contains("Depositum"))
        #expect(bodyText.contains("10 000 kroner"))
    }

    @Test func loanAgreementValidatesRequiredFieldsAndAdvisoryWarnings() async throws {
        #expect(LoanAgreementFormData().blockingIssues(in: .norwegian).count == 6)
        #expect(LoanAgreementFormData().warnings(in: .norwegian).count == 4)

        var form = LoanAgreementFormData()
        form.lender = contractParty(name: "Langiver")
        form.borrower = contractParty(name: "Lantaker")
        form.amount = "50 000 kroner"
        form.disbursementDate = "21. september 2026"
        form.dueDate = "21. september 2027"
        form.repaymentTerms = "Tilbakebetales i ett avdrag."
        form.interestTerms = "Rentefritt."
        form.latePaymentTerms = "Vanlige regler ved forsinkelse."
        form.security = "Usikret lan."
        form.purpose = "Privat lan."
        form.signingPlace = "Oslo"

        #expect(form.blockingIssues(in: .norwegian).isEmpty)
        #expect(form.warnings(in: .norwegian).isEmpty)

        let bodyText = form.document.bodyText(in: .norwegian)
        #expect(bodyText.contains("Langiver"))
        #expect(bodyText.contains("Lantaker"))
        #expect(bodyText.contains("50 000 kroner"))
        #expect(bodyText.contains("21. september 2027"))
    }

    @Test func freeDocumentHTMLPreviewEscapesUserEnteredText() async throws {
        var purchaseAgreement = PurchaseAgreementFormData()
        purchaseAgreement.seller = contractParty(name: "<script>Selger & Co</script>")
        purchaseAgreement.buyer = contractParty(name: "Kjoper")
        purchaseAgreement.itemDescription = "Sykkel <ny>"
        purchaseAgreement.purchasePrice = "3 000 kroner"
        purchaseAgreement.handoverDate = "1. oktober 2026"
        purchaseAgreement.signingPlace = "Oslo"

        var receipt = ReceiptFormData()
        receipt.issuer = contractParty(name: "<script>Utsteder & Co</script>")
        receipt.payer = contractParty(name: "Betaler")
        receipt.receiptFor = "Depositum <leie>"
        receipt.amount = "10 000 kroner"
        receipt.paymentDateText = "21. september 2026"
        receipt.signingPlace = "Oslo"

        var loanAgreement = LoanAgreementFormData()
        loanAgreement.lender = contractParty(name: "<script>Langiver & Co</script>")
        loanAgreement.borrower = contractParty(name: "Lantaker")
        loanAgreement.amount = "50 000 kroner"
        loanAgreement.dueDate = "21. september 2027"
        loanAgreement.repaymentTerms = "Tilbakebetales i ett avdrag."
        loanAgreement.signingPlace = "Oslo"

        let htmlDocuments = [
            purchaseAgreement.document.htmlDocument(in: .norwegian),
            receipt.document.htmlDocument(in: .norwegian),
            loanAgreement.document.htmlDocument(in: .norwegian)
        ]

        for html in htmlDocuments {
            #expect(!html.contains("<script>"))
            #expect(html.contains("&lt;script&gt;"))
            #expect(html.contains("&amp; Co"))
        }
    }

    @Test func testamentHTMLPreviewEscapesUserEnteredText() async throws {
        var form = TestamentFormData()
        form.testatorName = "<script>Ola & Co</script>"
        form.testatorAddress = "Gate <1>"
        form.testatorPhone = "123 & 456"
        form.testatorEmail = "ola@example.com"
        form.testamentPlace = "Oslo <tinghus>"
        form.hasChildren = false
        form.beneficiaries = [
            BeneficiaryEntry(name: "<script>Kari & Co</script>", disposition: "leiligheten <Oslo>")
        ]
        form.residueClause = "Kari & Per"
        form.specialProvisions = "Innbo <liste>"
        form.witnessOne = WitnessInfo(name: "Vitne <En>", address: "Vei & 2")
        form.witnessTwo = WitnessInfo(name: "Vitne <To>", address: "Vei & 3")

        let html = form.generatedDocument.htmlDocument

        #expect(!html.contains("<script>"))
        #expect(html.contains("&lt;script&gt;"))
        #expect(html.contains("&amp; Co"))
        #expect(html.contains("Gate &lt;1&gt;"))
        #expect(html.contains("leiligheten &lt;Oslo&gt;"))
        #expect(html.contains("Kari &amp; Per"))
        #expect(html.contains("Vitne &lt;En&gt;"))
    }

    @Test func powerOfAttorneyHTMLPreviewEscapesUserEnteredText() async throws {
        var form = PowerOfAttorneyFormData()
        form.principalName = "<script>Ola & Co</script>"
        form.principalAddress = "Gate <1>"
        form.principalPhone = "123 & 456"
        form.principalEmail = "ola@example.com"
        form.agentName = "<script>Kari & Co</script>"
        form.agentAddress = "Vei <2>"
        form.mandateScope = "Representere <banken>"
        form.authorizationPurpose = "Bankmote & signering"
        form.restrictions = "Bare konto <123>"
        form.validFrom = "21. september 2026"
        form.validUntil = "21. desember 2026"
        form.revocationTerms = "Kan trekkes <skriftlig>"
        form.signingPlace = "Oslo <tinghus>"

        let html = form.document.htmlDocument(in: .norwegian)

        #expect(!html.contains("<script>"))
        #expect(html.contains("&lt;script&gt;"))
        #expect(html.contains("&amp; Co"))
        #expect(html.contains("Gate &lt;1&gt;"))
        #expect(html.contains("Representere &lt;banken&gt;"))
        #expect(html.contains("Bankmote &amp; signering"))
        #expect(html.contains("Oslo &lt;tinghus&gt;"))
    }

    @Test func powerOfAttorneyValidatesRequiredFieldsAndAdvisoryWarnings() async throws {
        #expect(PowerOfAttorneyFormData().blockingIssues(in: .norwegian).count == 5)
        #expect(PowerOfAttorneyFormData().warnings(in: .norwegian).count == 3)

        var form = PowerOfAttorneyFormData()
        form.principalName = "Ola Nordmann"
        form.principalAddress = "Gate 1"
        form.agentName = "Kari Nordmann"
        form.agentAddress = "Vei 2"
        form.mandateScope = "Representere fullmaktsgiver overfor banken."
        form.authorizationPurpose = "Bankmote og signering av nodvendige dokumenter."
        form.restrictions = "Fullmakten gjelder bare kontoavslutning."
        form.validFrom = "21. september 2026"
        form.validUntil = "21. desember 2026"
        form.revocationTerms = "Kan trekkes tilbake skriftlig."
        form.signingPlace = "Oslo"

        #expect(form.blockingIssues(in: .norwegian).isEmpty)
        #expect(form.warnings(in: .norwegian).isEmpty)

        let bodyText = form.document.bodyText(in: .norwegian)
        #expect(bodyText.contains("Ola Nordmann"))
        #expect(bodyText.contains("Kari Nordmann"))
        #expect(bodyText.contains("Representere fullmaktsgiver overfor banken."))
    }

    @Test func debtInstrumentHTMLPreviewEscapesUserEnteredText() async throws {
        var form = DebtInstrumentFormData()
        form.creditor = debtParty(name: "<script>Kreditor & Co</script>")
        form.creditor.address = "Gate <1>"
        form.debtor = debtParty(name: "<script>Debitor & Co</script>")
        form.debtor.address = "Vei <2>"
        form.principalAmount = "75 000 <kroner>"
        form.issueDateText = "21. september 2026"
        form.dueDateText = "21. september 2027"
        form.interestTerms = "Rentefritt & gebyrfritt"
        form.repaymentTerms = "Tilbakebetales <samlet>"
        form.defaultConsequences = "Forsinkelsesrente & inndriving"
        form.collateral = "Pant i <sykkel>"
        form.signingPlace = "Oslo <tinghus>"

        let html = form.document.htmlDocument(in: .norwegian)

        #expect(!html.contains("<script>"))
        #expect(html.contains("&lt;script&gt;"))
        #expect(html.contains("&amp; Co"))
        #expect(html.contains("Gate &lt;1&gt;"))
        #expect(html.contains("75 000 &lt;kroner&gt;"))
        #expect(html.contains("Rentefritt &amp; gebyrfritt"))
        #expect(html.contains("Oslo &lt;tinghus&gt;"))
    }

    @Test func debtInstrumentValidatesRequiredFieldsAndAdvisoryWarnings() async throws {
        #expect(DebtInstrumentFormData().blockingIssues(in: .norwegian).count == 6)
        #expect(DebtInstrumentFormData().warnings(in: .norwegian).count == 3)

        var form = DebtInstrumentFormData()
        form.creditor = debtParty(name: "Kreditor")
        form.debtor = debtParty(name: "Debitor")
        form.principalAmount = "75 000 kroner"
        form.issueDateText = "21. september 2026"
        form.dueDateText = "21. september 2027"
        form.interestTerms = "Rentefritt."
        form.repaymentTerms = "Tilbakebetales i ett avdrag."
        form.defaultConsequences = "Vanlige regler ved mislighold."
        form.collateral = "Usikret krav."
        form.signingPlace = "Oslo"

        #expect(form.blockingIssues(in: .norwegian).isEmpty)
        #expect(form.warnings(in: .norwegian).isEmpty)

        let bodyText = form.document.bodyText(in: .norwegian)
        #expect(bodyText.contains("Kreditor"))
        #expect(bodyText.contains("Debitor"))
        #expect(bodyText.contains("75 000 kroner"))
        #expect(bodyText.contains("21. september 2027"))
    }

    @Test func employmentAgreementHTMLPreviewEscapesUserEnteredText() async throws {
        var form = EmploymentAgreementFormData()
        form.employer = contractParty(name: "<script>Arbeidsgiver & Co</script>")
        form.employer.address = "Gate <1>"
        form.employee = contractParty(name: "<script>Ansatt & Co</script>")
        form.employee.address = "Vei <2>"
        form.positionTitle = "Radgiver <senior>"
        form.duties = "Saksbehandling & kundekontakt"
        form.startDate = "1. oktober 2026"
        form.workplace = "Oslo <kontor>"
        form.salary = "600 000 <kroner> per ar"
        form.workingHours = "37,5 timer & fleksitid"
        form.probationPeriod = "Seks <maneder>"
        form.terminationNotice = "Tre maneder & skriftlig"
        form.confidentialityTerms = "Taushet om <kunder>"
        form.signingPlace = "Oslo <tinghus>"

        let html = form.document.htmlDocument(in: .norwegian)

        #expect(!html.contains("<script>"))
        #expect(html.contains("&lt;script&gt;"))
        #expect(html.contains("&amp; Co"))
        #expect(html.contains("Gate &lt;1&gt;"))
        #expect(html.contains("Radgiver &lt;senior&gt;"))
        #expect(html.contains("Saksbehandling &amp; kundekontakt"))
        #expect(html.contains("Oslo &lt;tinghus&gt;"))
    }

    @Test func employmentAgreementValidatesRequiredFieldsAndAdvisoryWarnings() async throws {
        #expect(EmploymentAgreementFormData().blockingIssues(in: .norwegian).count == 6)
        #expect(EmploymentAgreementFormData().warnings(in: .norwegian).count == 5)

        var form = EmploymentAgreementFormData()
        form.employer = contractParty(name: "Arbeidsgiver AS")
        form.employee = contractParty(name: "Ansatt Person")
        form.positionTitle = "Rådgiver"
        form.duties = "Saksbehandling og kundekontakt."
        form.startDate = "1. oktober 2026"
        form.workplace = "Oslo"
        form.salary = "600 000 kroner per år"
        form.workingHours = "37,5 timer per uke."
        form.probationPeriod = "Seks måneder."
        form.terminationNotice = "Tre måneder."
        form.confidentialityTerms = "Vanlig taushetsplikt gjelder."
        form.signingPlace = "Oslo"

        #expect(form.blockingIssues(in: .norwegian).isEmpty)
        #expect(form.warnings(in: .norwegian).isEmpty)

        let bodyText = form.document.bodyText(in: .norwegian)
        #expect(bodyText.contains("Arbeidsgiver AS"))
        #expect(bodyText.contains("Ansatt Person"))
        #expect(bodyText.contains("Rådgiver"))
        #expect(bodyText.contains("600 000 kroner per år"))
    }

    @Test func ndaHTMLPreviewEscapesUserEnteredText() async throws {
        var form = NDAFormData()
        form.disclosingParty = contractParty(name: "<script>Informasjonseier & Co</script>")
        form.disclosingParty.address = "Gate <1>"
        form.receivingParty = contractParty(name: "<script>Mottaker & Co</script>")
        form.receivingParty.address = "Vei <2>"
        form.confidentialInfo = "Produktplaner <hemmelig>"
        form.purpose = "Vurdere samarbeid & investering"
        form.obligations = "Ikke dele med <tredjepart>"
        form.duration = "Tre ar & videre"
        form.exclusions = "Offentlig kjent <informasjon>"
        form.returnMaterials = "Returnere & slette materiale"
        form.governingLaw = "Norsk rett <Oslo tingrett>"
        form.signingPlace = "Oslo <tinghus>"

        let html = form.document.htmlDocument(in: .norwegian)

        #expect(!html.contains("<script>"))
        #expect(html.contains("&lt;script&gt;"))
        #expect(html.contains("&amp; Co"))
        #expect(html.contains("Gate &lt;1&gt;"))
        #expect(html.contains("Produktplaner &lt;hemmelig&gt;"))
        #expect(html.contains("Vurdere samarbeid &amp; investering"))
        #expect(html.contains("Oslo &lt;tinghus&gt;"))
    }

    @Test func ndaValidatesRequiredFieldsAndAdvisoryWarnings() async throws {
        #expect(NDAFormData().blockingIssues(in: .norwegian).count == 6)
        #expect(NDAFormData().warnings(in: .norwegian).count == 4)

        var form = NDAFormData()
        form.disclosingParty = contractParty(name: "Informasjonseier AS")
        form.receivingParty = contractParty(name: "Mottaker AS")
        form.confidentialInfo = "Produktplaner, kundelister og teknisk dokumentasjon."
        form.purpose = "Vurdere mulig samarbeid."
        form.obligations = "Informasjonen skal holdes hemmelig og bare brukes til avtalt formål."
        form.duration = "Tre år fra signering."
        form.exclusions = "Informasjon som allerede er offentlig kjent er unntatt."
        form.returnMaterials = "Materiale skal returneres eller slettes på forespørsel."
        form.governingLaw = "Norsk rett."
        form.signingPlace = "Oslo"

        #expect(form.blockingIssues(in: .norwegian).isEmpty)
        #expect(form.warnings(in: .norwegian).isEmpty)

        let bodyText = form.document.bodyText(in: .norwegian)
        #expect(bodyText.contains("Informasjonseier AS"))
        #expect(bodyText.contains("Mottaker AS"))
        #expect(bodyText.contains("Produktplaner, kundelister og teknisk dokumentasjon."))
        #expect(bodyText.contains("Vurdere mulig samarbeid."))
    }

    @Test func rentalAgreementHTMLPreviewEscapesUserEnteredText() async throws {
        var form = RentalAgreementFormData()
        form.landlord = rentalParty(name: "<script>Utleier & Co</script>")
        form.landlord.address = "Gate <1>"
        form.tenant = rentalParty(name: "<script>Leietaker & Co</script>")
        form.tenant.address = "Vei <2>"
        form.propertyAddress = "Leiegata <1>"
        form.rentalObjectDescription = "Leilighet & bod"
        form.monthlyRent = "15 000 <kroner>"
        form.deposit = "45 000 & gebyrfritt"
        form.startDate = "1. oktober 2026"
        form.duration = "Tidsubestemt <leieforhold>"
        form.utilities = "Strom & internett"
        form.noticePeriod = "Tre <maneder>"
        form.houseRules = "Ingen røyking & husdyr etter avtale"
        form.signingPlace = "Oslo <tinghus>"

        let html = form.document.htmlDocument(in: .norwegian)

        #expect(!html.contains("<script>"))
        #expect(html.contains("&lt;script&gt;"))
        #expect(html.contains("&amp; Co"))
        #expect(html.contains("Gate &lt;1&gt;"))
        #expect(html.contains("Leiegata &lt;1&gt;"))
        #expect(html.contains("Leilighet &amp; bod"))
        #expect(html.contains("Oslo &lt;tinghus&gt;"))
    }

    @Test func rentalAgreementValidatesRequiredFieldsAndAdvisoryWarnings() async throws {
        #expect(RentalAgreementFormData().blockingIssues(in: .norwegian).count == 6)
        #expect(RentalAgreementFormData().warnings(in: .norwegian).count == 3)

        var form = RentalAgreementFormData()
        form.landlord = rentalParty(name: "Utleier")
        form.tenant = rentalParty(name: "Leietaker")
        form.propertyAddress = "Leiegata 1"
        form.rentalObjectDescription = "Leilighet H0201"
        form.monthlyRent = "15 000 kroner"
        form.deposit = "45 000 kroner"
        form.startDate = "1. oktober 2026"
        form.duration = "Tidsubestemt leieforhold."
        form.utilities = "Strøm kommer i tillegg."
        form.noticePeriod = "Tre måneder."
        form.houseRules = "Vanlige husordensregler gjelder."
        form.signingPlace = "Oslo"

        #expect(form.blockingIssues(in: .norwegian).isEmpty)
        #expect(form.warnings(in: .norwegian).isEmpty)

        let bodyText = form.document.bodyText(in: .norwegian)
        #expect(bodyText.contains("Utleier"))
        #expect(bodyText.contains("Leietaker"))
        #expect(bodyText.contains("Leiegata 1"))
        #expect(bodyText.contains("15 000 kroner"))
    }

    @Test func cohabitationAgreementHTMLPreviewEscapesUserEnteredText() async throws {
        var form = CohabitationAgreementFormData()
        form.partnerOne = cohabitationParty(name: "<script>Samboer En & Co</script>")
        form.partnerOne.address = "Gate <1>"
        form.partnerTwo = cohabitationParty(name: "<script>Samboer To & Co</script>")
        form.partnerTwo.address = "Vei <2>"
        form.sharedHomeAddress = "Fellesgata <1>"
        form.ownershipDistribution = "Eier 50 % & 50 %"
        form.separateAssets = "Eiendeler <forholdet>"
        form.sharedExpenses = "Felles utgifter & vedlikehold"
        form.debtResponsibility = "Egen gjeld <privat>"
        form.breakupHandling = "Fordeles etter eierandel & avtale"
        form.specialTerms = "Ingen <særvilkår>"
        form.signingPlace = "Oslo <tinghus>"

        let html = form.document.htmlDocument(in: .norwegian)

        #expect(!html.contains("<script>"))
        #expect(html.contains("&lt;script&gt;"))
        #expect(html.contains("&amp; Co"))
        #expect(html.contains("Gate &lt;1&gt;"))
        #expect(html.contains("Fellesgata &lt;1&gt;"))
        #expect(html.contains("Eier 50 % &amp; 50 %"))
        #expect(html.contains("Oslo &lt;tinghus&gt;"))
    }

    @Test func cohabitationAgreementValidatesRequiredFieldsAndAdvisoryWarnings() async throws {
        #expect(CohabitationAgreementFormData().blockingIssues(in: .norwegian).count == 6)
        #expect(CohabitationAgreementFormData().warnings(in: .norwegian).count == 3)

        var form = CohabitationAgreementFormData()
        form.partnerOne = cohabitationParty(name: "Samboer En")
        form.partnerTwo = cohabitationParty(name: "Samboer To")
        form.sharedHomeAddress = "Fellesgata 1"
        form.ownershipDistribution = "Partene eier boligen med en halvpart hver."
        form.separateAssets = "Hver part beholder eiendeler de eide før samlivet."
        form.sharedExpenses = "Felles utgifter deles likt."
        form.debtResponsibility = "Hver part svarer for egen gjeld."
        form.breakupHandling = "Bolig og innbo fordeles etter eierandel."
        form.specialTerms = "Ingen særvilkår."
        form.signingPlace = "Oslo"

        #expect(form.blockingIssues(in: .norwegian).isEmpty)
        #expect(form.warnings(in: .norwegian).isEmpty)

        let bodyText = form.document.bodyText(in: .norwegian)
        #expect(bodyText.contains("Samboer En"))
        #expect(bodyText.contains("Samboer To"))
        #expect(bodyText.contains("Fellesgata 1"))
        #expect(bodyText.contains("Felles utgifter deles likt."))
    }

    @Test func rentalTerminationHTMLPreviewEscapesUserEnteredText() async throws {
        var form = RentalTerminationFormData()
        form.landlord = rentalParty(name: "<script>Utleier & Co</script>")
        form.landlord.address = "Gate <1>"
        form.tenant = rentalParty(name: "<script>Leietaker & Co</script>")
        form.tenant.address = "Vei <2>"
        form.propertyAddress = "Leiegata <1>"
        form.terminationDateText = "21. september 2026"
        form.moveOutDateText = "31. desember 2026"
        form.noticeBasis = "Oppsigelse etter <avtalt> frist"
        form.depositSettlement = "Depositum & sluttoppgjør"
        form.keyReturn = "Nøkler leveres <ved fraflytting>"
        form.signingPlace = "Oslo <tinghus>"

        let html = form.document.htmlDocument(in: .norwegian)

        #expect(!html.contains("<script>"))
        #expect(html.contains("&lt;script&gt;"))
        #expect(html.contains("&amp; Co"))
        #expect(html.contains("Gate &lt;1&gt;"))
        #expect(html.contains("Leiegata &lt;1&gt;"))
        #expect(html.contains("Oppsigelse etter &lt;avtalt&gt; frist"))
        #expect(html.contains("Oslo &lt;tinghus&gt;"))
    }

    @Test func rentalTerminationValidatesRequiredFieldsAndAdvisoryWarnings() async throws {
        #expect(RentalTerminationFormData().blockingIssues(in: .norwegian).count == 6)
        #expect(RentalTerminationFormData().warnings(in: .norwegian).count == 3)

        var form = RentalTerminationFormData()
        form.landlord = rentalParty(name: "Utleier")
        form.tenant = rentalParty(name: "Leietaker")
        form.propertyAddress = "Leiegata 1"
        form.terminationDateText = "21. september 2026"
        form.moveOutDateText = "31. desember 2026"
        form.noticeBasis = "Oppsigelse etter avtalt oppsigelsestid."
        form.depositSettlement = "Depositum frigis etter sluttoppgjør."
        form.keyReturn = "Nøkler leveres ved fraflytting."
        form.signingPlace = "Oslo"

        #expect(form.blockingIssues(in: .norwegian).isEmpty)
        #expect(form.warnings(in: .norwegian).isEmpty)

        let bodyText = form.document.bodyText(in: .norwegian)
        #expect(bodyText.contains("Utleier"))
        #expect(bodyText.contains("Leietaker"))
        #expect(bodyText.contains("Leiegata 1"))
        #expect(bodyText.contains("21. september 2026"))
    }

    @Test func contractHTMLPreviewEscapesUserEnteredText() async throws {
        var form = ContractFormData()
        form.partyOne = contractParty(name: "<script>Part En & Co</script>")
        form.partyOne.address = "Gate <1>"
        form.partyTwo = contractParty(name: "<script>Part To & Co</script>")
        form.partyTwo.address = "Vei <2>"
        form.agreementTitle = "Samarbeidsavtale <pilot>"
        form.subject = "Leveranse av <radgivning>"
        form.servicesOrGoods = "Månedlig rapportering & analyse"
        form.payment = "25 000 <kroner> per måned"
        form.duration = "Tolv måneder & opsjon"
        form.breachConsequences = "Heving ved <vesentlig> mislighold"
        form.termination = "Tre måneder & skriftlig"
        form.disputeResolution = "Forhandlinger <før søksmål>"
        form.specialTerms = "Ingen & særvilkår"
        form.signingPlace = "Oslo <tinghus>"

        let html = form.document.htmlDocument(in: .norwegian)

        #expect(!html.contains("<script>"))
        #expect(html.contains("&lt;script&gt;"))
        #expect(html.contains("&amp; Co"))
        #expect(html.contains("Gate &lt;1&gt;"))
        #expect(html.contains("Samarbeidsavtale &lt;pilot&gt;"))
        #expect(html.contains("Leveranse av &lt;radgivning&gt;"))
        #expect(html.contains("Oslo &lt;tinghus&gt;"))
    }

    @Test func contractValidatesRequiredFieldsAndAdvisoryWarnings() async throws {
        #expect(ContractFormData().blockingIssues(in: .norwegian).count == 7)
        #expect(ContractFormData().warnings(in: .norwegian).count == 4)

        var form = ContractFormData()
        form.partyOne = contractParty(name: "Part En")
        form.partyTwo = contractParty(name: "Part To")
        form.agreementTitle = "Samarbeidsavtale"
        form.subject = "Leveranse av rådgivningstjenester."
        form.servicesOrGoods = "Månedlig rådgivning og rapportering."
        form.payment = "25 000 kroner per måned."
        form.duration = "Avtalen gjelder i tolv måneder."
        form.breachConsequences = "Vesentlig mislighold gir rett til heving."
        form.termination = "Oppsigelse kan skje med tre måneders varsel."
        form.disputeResolution = "Tvister søkes løst ved forhandlinger."
        form.specialTerms = "Ingen særvilkår."
        form.signingPlace = "Oslo"

        #expect(form.blockingIssues(in: .norwegian).isEmpty)
        #expect(form.warnings(in: .norwegian).isEmpty)

        let bodyText = form.document.bodyText(in: .norwegian)
        #expect(bodyText.contains("Part En"))
        #expect(bodyText.contains("Part To"))
        #expect(bodyText.contains("Leveranse av rådgivningstjenester."))
        #expect(bodyText.contains("25 000 kroner per måned."))
    }

    @Test func testamentValidatesRequiredFieldsAndAdvisoryWarnings() async throws {
        #expect(TestamentFormData().blockingIssues(in: .norwegian).count == 6)
        #expect(TestamentFormData().warnings(in: .norwegian).count == 2)

        var form = TestamentFormData()
        form.testatorName = "Ola Nordmann"
        form.testatorAddress = "Gate 1"
        form.testamentPlace = "Oslo"
        form.hasChildren = false
        form.beneficiaries = [
            BeneficiaryEntry(name: "Kari Nordmann", disposition: "leiligheten i Oslo")
        ]
        form.residueClause = "Kari Nordmann"
        form.specialProvisions = "Arving skal overta innbo etter egen liste."
        form.witnessesPresentTogetherConfirmed = true
        form.witnessesKnowItsATestamentConfirmed = true
        form.witnessesAreEligibleConfirmed = true
        form.witnessOne = WitnessInfo(name: "Vitne En", address: "Vei 2")
        form.witnessTwo = WitnessInfo(name: "Vitne To", address: "Vei 3")

        #expect(form.blockingIssues(in: .norwegian).isEmpty)
        #expect(form.warnings(in: .norwegian).isEmpty)

        let bodyText = form.generatedDocument.formattedBody
        #expect(bodyText.contains("Ola Nordmann"))
        #expect(bodyText.contains("Kari Nordmann"))
        #expect(bodyText.contains("leiligheten i Oslo"))
        #expect(bodyText.contains("Arving skal overta innbo etter egen liste."))
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

    private func contractParty(name: String) -> ContractParty {
        var party = ContractParty()
        party.name = name
        party.address = "Gate 1"
        return party
    }

    private func debtParty(name: String) -> DebtParty {
        var party = DebtParty()
        party.name = name
        party.address = "Gate 1"
        return party
    }

    private func rentalParty(name: String) -> RentalParty {
        var party = RentalParty()
        party.name = name
        party.address = "Gate 1"
        return party
    }

    private func cohabitationParty(name: String) -> CohabitationParty {
        var party = CohabitationParty()
        party.name = name
        party.address = "Gate 1"
        return party
    }

    private func projectFileContents(_ relativePath: String) throws -> String {
        let testFileURL = URL(fileURLWithPath: #filePath)
        let projectURL = testFileURL.deletingLastPathComponent().deletingLastPathComponent()
        let fileURL = projectURL.appendingPathComponent(relativePath)

        return try String(contentsOf: fileURL, encoding: .utf8)
    }
}
