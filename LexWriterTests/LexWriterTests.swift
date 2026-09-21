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

    @Test func premiumPreviewDescriptionExplainsPaidPremiumIsLater() async throws {
        #expect(AppLanguage.norwegian.text(.premiumPreviewDescription).contains("Betalt premium er planlagt"))
        #expect(AppLanguage.english.text(.premiumPreviewDescription).contains("Paid premium is planned"))
    }

    @Test func premiumPreviewExplainsPurchasesAreUnavailableInThisVersion() async throws {
        #expect(AppLanguage.norwegian.text(.premiumPurchasesUnavailableInThisVersion) == "Kjøp er ikke tilgjengelig i denne versjonen")
        #expect(AppLanguage.english.text(.premiumPurchasesUnavailableInThisVersion) == "Purchases are not available in this version")
    }

    @Test func premiumPreviewIncludesExplainsCollectionIsPlanned() async throws {
        #expect(AppLanguage.norwegian.text(.premiumPreviewIncludes) == "Planlagt premiumsamling")
        #expect(AppLanguage.english.text(.premiumPreviewIncludes) == "Planned premium collection")
    }

    @Test func homeScreenExplainsPlannedPremiumTemplates() async throws {
        #expect(AppLanguage.norwegian.text(.plannedPremiumTemplatesTitle) == "Planlagte premium-maler")
        #expect(AppLanguage.english.text(.plannedPremiumTemplatesTitle) == "Planned premium templates")
    }

    @Test func settingsPremiumButtonExplainsPlannedPremium() async throws {
        #expect(AppLanguage.norwegian.text(.openPremiumPlan) == "Se planlagt premium")
        #expect(AppLanguage.english.text(.openPremiumPlan) == "View planned premium")
    }

    @Test func accessPlanSummaryShowsFreeAndPremiumCounts() async throws {
        #expect(AppLanguage.norwegian.text(.accessPlanSummary) == "3 gratis maler og 9 planlagte premium-maler.")
        #expect(AppLanguage.english.text(.accessPlanSummary) == "3 free templates and 9 planned premium templates.")
    }

    @Test func premiumPreviewLocalizationExistsForEveryLanguage() async throws {
        let keys: [LocalizedKey] = [
            .allDocumentsOpenNow,
            .accessPlanSummary,
            .premiumPreviewHeadline,
            .premiumPreviewDescription,
            .premiumPurchasesUnavailableInThisVersion,
            .premiumPreviewIncludes,
            .openPremiumPlan
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
}
