//
//  CohabitationAgreementModels.swift
//  LexWriter
//
//  Created by Codex on 29/08/2026.
//

import Foundation

enum CohabitationLocalizedKey {
    case title
    case cardSubtitle
    case legalChecklistTitle
    case partnerOneTitle
    case partnerTwoTitle
    case agreementTermsTitle
    case sharedHomeField
    case ownershipField
    case separateAssetsField
    case sharedExpensesField
    case debtResponsibilityField
    case breakupField
    case specialTermsField
    case previewButton
    case blockingPartnerOne
    case blockingPartnerTwo
    case blockingSharedHome
    case blockingOwnership
    case blockingExpenses
    case blockingPlace
    case warningDebt
    case warningBreakup
    case warningSpecialTerms
    case clauseOneTitle
    case clauseTwoTitle
    case clauseThreeTitle
    case clauseFourTitle
    case clauseFiveTitle
    case clauseSixTitle
    case bodyPartiesPrefix
    case bodyPartiesMiddle
    case bodyHomePrefix
    case bodyOwnershipPrefix
    case bodySeparateAssetsPrefix
    case bodyExpensesPrefix
    case bodyDebtPrefix
    case bodyBreakupPrefix
    case bodySpecialPrefix
    case bodyGoodFaith
    case defaultDebt
    case defaultBreakup
    case defaultSpecialTerms
}

struct CohabitationParty: Equatable {
    var name = ""
    var address = ""
    var phone = ""
    var email = ""
}

struct CohabitationAgreementFormData {
    var partnerOne = CohabitationParty()
    var partnerTwo = CohabitationParty()
    var sharedHomeAddress = ""
    var ownershipDistribution = ""
    var separateAssets = ""
    var sharedExpenses = ""
    var debtResponsibility = ""
    var breakupHandling = ""
    var specialTerms = ""
    var signingPlace = ""
    var signingDate = Date()

    func blockingIssues(in language: AppLanguage) -> [ValidationMessage] {
        var messages: [ValidationMessage] = []

        if partnerOne.name.trimmed.isEmpty || partnerOne.address.trimmed.isEmpty {
            messages.append(.init(severity: .blocking, message: language.cohabitationText(.blockingPartnerOne)))
        }

        if partnerTwo.name.trimmed.isEmpty || partnerTwo.address.trimmed.isEmpty {
            messages.append(.init(severity: .blocking, message: language.cohabitationText(.blockingPartnerTwo)))
        }

        if sharedHomeAddress.trimmed.isEmpty {
            messages.append(.init(severity: .blocking, message: language.cohabitationText(.blockingSharedHome)))
        }

        if ownershipDistribution.trimmed.isEmpty {
            messages.append(.init(severity: .blocking, message: language.cohabitationText(.blockingOwnership)))
        }

        if sharedExpenses.trimmed.isEmpty {
            messages.append(.init(severity: .blocking, message: language.cohabitationText(.blockingExpenses)))
        }

        if signingPlace.trimmed.isEmpty {
            messages.append(.init(severity: .blocking, message: language.cohabitationText(.blockingPlace)))
        }

        return messages
    }

    func warnings(in language: AppLanguage) -> [ValidationMessage] {
        var messages: [ValidationMessage] = []

        if debtResponsibility.trimmed.isEmpty {
            messages.append(.init(severity: .warning, message: language.cohabitationText(.warningDebt)))
        }

        if breakupHandling.trimmed.isEmpty {
            messages.append(.init(severity: .warning, message: language.cohabitationText(.warningBreakup)))
        }

        if specialTerms.trimmed.isEmpty {
            messages.append(.init(severity: .warning, message: language.cohabitationText(.warningSpecialTerms)))
        }

        return messages
    }

    var document: CohabitationAgreementDocument {
        CohabitationAgreementDocument(
            partnerOne: partnerOne,
            partnerTwo: partnerTwo,
            sharedHomeAddress: sharedHomeAddress.trimmed,
            ownershipDistribution: ownershipDistribution.trimmed,
            separateAssets: separateAssets.trimmed,
            sharedExpenses: sharedExpenses.trimmed,
            debtResponsibility: debtResponsibility.trimmed,
            breakupHandling: breakupHandling.trimmed,
            specialTerms: specialTerms.trimmed,
            signingPlace: signingPlace.trimmed,
            signingDate: signingDate
        )
    }
}

struct CohabitationAgreementDocument {
    let partnerOne: CohabitationParty
    let partnerTwo: CohabitationParty
    let sharedHomeAddress: String
    let ownershipDistribution: String
    let separateAssets: String
    let sharedExpenses: String
    let debtResponsibility: String
    let breakupHandling: String
    let specialTerms: String
    let signingPlace: String
    let signingDate: Date

    var formattedDate: String {
        signingDate.formatted(date: .long, time: .omitted)
    }

    func bodyText(in language: AppLanguage) -> String {
        let debtText = debtResponsibility.isEmpty ? language.cohabitationText(.defaultDebt) : debtResponsibility
        let breakupText = breakupHandling.isEmpty ? language.cohabitationText(.defaultBreakup) : breakupHandling
        let specialText = specialTerms.isEmpty ? language.cohabitationText(.defaultSpecialTerms) : specialTerms

        let sections = [
            "\(language.cohabitationText(.clauseOneTitle))\n\(language.cohabitationText(.bodyPartiesPrefix)) \(partnerOne.name.trimmed), \(partnerOne.address.trimmed), \(language.cohabitationText(.bodyPartiesMiddle)) \(partnerTwo.name.trimmed), \(partnerTwo.address.trimmed).",
            "\(language.cohabitationText(.clauseTwoTitle))\n\(language.cohabitationText(.bodyHomePrefix)) \(sharedHomeAddress).",
            "\(language.cohabitationText(.clauseThreeTitle))\n\(language.cohabitationText(.bodyOwnershipPrefix)) \(ownershipDistribution).",
            "\(language.cohabitationText(.clauseFourTitle))\n\(language.cohabitationText(.bodySeparateAssetsPrefix)) \(separateAssets.isEmpty ? "-" : separateAssets)\n\(language.cohabitationText(.bodyExpensesPrefix)) \(sharedExpenses).",
            "\(language.cohabitationText(.clauseFiveTitle))\n\(language.cohabitationText(.bodyDebtPrefix)) \(debtText).",
            "\(language.cohabitationText(.clauseSixTitle))\n\(language.cohabitationText(.bodyBreakupPrefix)) \(breakupText)\n\(language.cohabitationText(.bodySpecialPrefix)) \(specialText)",
            language.cohabitationText(.bodyGoodFaith)
        ]

        return sections.joined(separator: "\n\n")
    }

    func htmlDocument(in language: AppLanguage) -> String {
        """
        <html>
        <head>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <style>
        body { font-family: Georgia, 'Times New Roman', serif; color: #2c2218; margin: 44px; line-height: 1.6; background: #fbf4e7; }
        h1 { text-align: center; letter-spacing: 3px; margin-bottom: 30px; }
        .paper { border: 1px solid #8d7358; padding: 36px; background: #f8efdd; }
        .line { border-bottom: 1px solid #4a3c2d; margin-top: 20px; padding-top: 20px; }
        .signature { margin-top: 44px; }
        </style>
        </head>
        <body>
        <div class="paper">
        <h1>\(language.cohabitationText(.title).htmlEscaped)</h1>
        <p>\(bodyText(in: language).htmlEscaped.replacingOccurrences(of: "\n", with: "<br><br>"))</p>
        <div class="signature">
        <p>\(signingPlace.htmlEscaped), \(formattedDate.htmlEscaped)</p>
        <div class="line">\(partnerOne.name.htmlEscaped)</div>
        <div class="line">\(partnerTwo.name.htmlEscaped)</div>
        </div>
        </div>
        </body>
        </html>
        """
    }
}

extension AppLanguage {
    var cohabitationChecklist: [String] {
        [
            cohabitationText(.bodyOwnershipPrefix),
            cohabitationText(.warningDebt).replacingOccurrences(of: ".", with: ""),
            cohabitationText(.warningBreakup).replacingOccurrences(of: ".", with: "")
        ]
    }

    func cohabitationText(_ key: CohabitationLocalizedKey) -> String {
        switch (self, key) {
        case (.norwegian, .title):
            return "Samboeravtale"
        case (.norwegian, .cardSubtitle):
            return "Avklar bolig, eierskap, utgifter, gjeld og hva som skjer ved brudd."
        case (.norwegian, .legalChecklistTitle):
            return "Det som bør være tydelig i samboeravtalen"
        case (.norwegian, .partnerOneTitle):
            return "Samboer 1"
        case (.norwegian, .partnerTwoTitle):
            return "Samboer 2"
        case (.norwegian, .agreementTermsTitle):
            return "Avtalepunkter"
        case (.norwegian, .sharedHomeField):
            return "Felles bolig / adresse"
        case (.norwegian, .ownershipField):
            return "Hvem eier hva, og i hvilke andeler?"
        case (.norwegian, .separateAssetsField):
            return "Eiendeler hver av partene beholder som egne"
        case (.norwegian, .sharedExpensesField):
            return "Hvordan fordeles felles utgifter?"
        case (.norwegian, .debtResponsibilityField):
            return "Hvem er ansvarlig for lån og gjeld?"
        case (.norwegian, .breakupField):
            return "Hva skal gjelde ved samlivsbrudd eller utflytting?"
        case (.norwegian, .specialTermsField):
            return "Andre bestemmelser"
        case (.norwegian, .previewButton):
            return "Vis samboeravtale"
        case (.norwegian, .blockingPartnerOne):
            return "Samboer 1 må ha navn og adresse."
        case (.norwegian, .blockingPartnerTwo):
            return "Samboer 2 må ha navn og adresse."
        case (.norwegian, .blockingSharedHome):
            return "Felles bolig eller adresse må fylles inn."
        case (.norwegian, .blockingOwnership):
            return "Eierskap eller eierandeler må beskrives."
        case (.norwegian, .blockingExpenses):
            return "Fordeling av felles utgifter må beskrives."
        case (.norwegian, .blockingPlace):
            return "Sted for signering mangler."
        case (.norwegian, .warningDebt):
            return "Gjeldsansvar er ikke regulert. Det bør fremgå hvem som svarer for hvilke lån og forpliktelser."
        case (.norwegian, .warningBreakup):
            return "Det er ikke skrevet hva som skal skje ved brudd. Det bør fremgå hvordan bolig og eiendeler håndteres."
        case (.norwegian, .warningSpecialTerms):
            return "Andre bestemmelser er tomt. Hvis det finnes særregler om kjøp, salg eller oppgjør bør de tas inn."
        case (.norwegian, .clauseOneTitle):
            return "1. Parter"
        case (.norwegian, .clauseTwoTitle):
            return "2. Felles bolig"
        case (.norwegian, .clauseThreeTitle):
            return "3. Eierskap"
        case (.norwegian, .clauseFourTitle):
            return "4. Eiendeler og utgifter"
        case (.norwegian, .clauseFiveTitle):
            return "5. Lån og gjeld"
        case (.norwegian, .clauseSixTitle):
            return "6. Opphør og særlige bestemmelser"
        case (.norwegian, .bodyPartiesPrefix):
            return "Mellom"
        case (.norwegian, .bodyPartiesMiddle):
            return "og"
        case (.norwegian, .bodyHomePrefix):
            return "Partene bor sammen i følgende bolig:"
        case (.norwegian, .bodyOwnershipPrefix):
            return "Eierskap og eierandeler er avtalt slik:"
        case (.norwegian, .bodySeparateAssetsPrefix):
            return "Følgende eiendeler skal anses som den enkeltes særskilte eiendom:"
        case (.norwegian, .bodyExpensesPrefix):
            return "Felles utgifter fordeles slik:"
        case (.norwegian, .bodyDebtPrefix):
            return "Ansvar for lån og gjeld reguleres slik:"
        case (.norwegian, .bodyBreakupPrefix):
            return "Ved samlivsbrudd eller utflytting gjelder følgende:"
        case (.norwegian, .bodySpecialPrefix):
            return "Andre bestemmelser:"
        case (.norwegian, .bodyGoodFaith):
            return "Partene bekrefter at avtalen er lest og forstått, og at den skal brukes som grunnlag for å avklare eierskap og økonomiske forhold mellom dem."
        case (.norwegian, .defaultDebt):
            return "Hver part er ansvarlig for sin egen gjeld med mindre annet er uttrykkelig avtalt."
        case (.norwegian, .defaultBreakup):
            return "Partene skal søke en skriftlig og rimelig fordeling basert på dokumentert eierskap og denne avtalen."
        case (.norwegian, .defaultSpecialTerms):
            return "Ingen ytterligere særlige bestemmelser er avtalt."
        case (.english, .title):
            return "Cohabitation Agreement"
        case (.english, .cardSubtitle):
            return "Clarify the home, ownership, expenses, debt, and what happens on separation."
        case (.english, .legalChecklistTitle):
            return "What should be clear in the cohabitation agreement"
        case (.english, .partnerOneTitle):
            return "Partner 1"
        case (.english, .partnerTwoTitle):
            return "Partner 2"
        case (.english, .agreementTermsTitle):
            return "Agreement terms"
        case (.english, .sharedHomeField):
            return "Shared home / address"
        case (.english, .ownershipField):
            return "Who owns what, and in which shares?"
        case (.english, .separateAssetsField):
            return "Assets each party keeps as separate property"
        case (.english, .sharedExpensesField):
            return "How are shared expenses divided?"
        case (.english, .debtResponsibilityField):
            return "Who is responsible for loans and debt?"
        case (.english, .breakupField):
            return "What applies if the relationship ends or one party moves out?"
        case (.english, .specialTermsField):
            return "Other provisions"
        case (.english, .previewButton):
            return "Show cohabitation agreement"
        case (.english, .blockingPartnerOne):
            return "Partner 1 must have a name and address."
        case (.english, .blockingPartnerTwo):
            return "Partner 2 must have a name and address."
        case (.english, .blockingSharedHome):
            return "The shared home or address must be entered."
        case (.english, .blockingOwnership):
            return "Ownership or ownership shares must be described."
        case (.english, .blockingExpenses):
            return "The distribution of shared expenses must be described."
        case (.english, .blockingPlace):
            return "The place of signing is missing."
        case (.english, .warningDebt):
            return "Debt responsibility is not regulated. The agreement should state who is responsible for which loans and obligations."
        case (.english, .warningBreakup):
            return "It does not say what happens on separation. The handling of the home and assets should be addressed."
        case (.english, .warningSpecialTerms):
            return "Other provisions are empty. If there are special rules for purchase, sale, or settlement, they should be included."
        case (.english, .clauseOneTitle):
            return "1. Parties"
        case (.english, .clauseTwoTitle):
            return "2. Shared home"
        case (.english, .clauseThreeTitle):
            return "3. Ownership"
        case (.english, .clauseFourTitle):
            return "4. Assets and expenses"
        case (.english, .clauseFiveTitle):
            return "5. Loans and debt"
        case (.english, .clauseSixTitle):
            return "6. Separation and special provisions"
        case (.english, .bodyPartiesPrefix):
            return "Between"
        case (.english, .bodyPartiesMiddle):
            return "and"
        case (.english, .bodyHomePrefix):
            return "The parties live together in the following home:"
        case (.english, .bodyOwnershipPrefix):
            return "Ownership and ownership shares are agreed as follows:"
        case (.english, .bodySeparateAssetsPrefix):
            return "The following assets are considered each party's separate property:"
        case (.english, .bodyExpensesPrefix):
            return "Shared expenses are divided as follows:"
        case (.english, .bodyDebtPrefix):
            return "Responsibility for loans and debt is regulated as follows:"
        case (.english, .bodyBreakupPrefix):
            return "If the relationship ends or one party moves out, the following applies:"
        case (.english, .bodySpecialPrefix):
            return "Other provisions:"
        case (.english, .bodyGoodFaith):
            return "The parties confirm that the agreement has been read and understood and will be used to clarify ownership and financial matters between them."
        case (.english, .defaultDebt):
            return "Each party is responsible for their own debt unless otherwise expressly agreed."
        case (.english, .defaultBreakup):
            return "The parties shall seek a written and reasonable allocation based on documented ownership and this agreement."
        case (.english, .defaultSpecialTerms):
            return "No additional special provisions have been agreed."
        case (.thai, .title):
            return "สัญญาอยู่กินร่วมกัน"
        case (.thai, .cardSubtitle):
            return "กำหนดเรื่องบ้าน กรรมสิทธิ์ ค่าใช้จ่าย หนี้ และแนวทางเมื่อแยกทาง"
        case (.thai, .legalChecklistTitle):
            return "สิ่งที่ควรระบุให้ชัดในสัญญาอยู่กินร่วมกัน"
        case (.thai, .partnerOneTitle):
            return "คู่ชีวิต 1"
        case (.thai, .partnerTwoTitle):
            return "คู่ชีวิต 2"
        case (.thai, .agreementTermsTitle):
            return "เงื่อนไขข้อตกลง"
        case (.thai, .sharedHomeField):
            return "บ้านหรือที่อยู่ร่วมกัน"
        case (.thai, .ownershipField):
            return "ใครเป็นเจ้าของอะไร และในสัดส่วนเท่าใด"
        case (.thai, .separateAssetsField):
            return "ทรัพย์สินที่แต่ละฝ่ายถือเป็นของตนเอง"
        case (.thai, .sharedExpensesField):
            return "แบ่งค่าใช้จ่ายร่วมกันอย่างไร"
        case (.thai, .debtResponsibilityField):
            return "ใครรับผิดชอบเงินกู้และหนี้"
        case (.thai, .breakupField):
            return "หากเลิกราหรือฝ่ายหนึ่งย้ายออกจะเป็นอย่างไร"
        case (.thai, .specialTermsField):
            return "ข้อกำหนดอื่น"
        case (.thai, .previewButton):
            return "แสดงสัญญาอยู่กินร่วมกัน"
        case (.thai, .blockingPartnerOne):
            return "คู่ชีวิต 1 ต้องมีชื่อและที่อยู่"
        case (.thai, .blockingPartnerTwo):
            return "คู่ชีวิต 2 ต้องมีชื่อและที่อยู่"
        case (.thai, .blockingSharedHome):
            return "ต้องกรอกบ้านหรือที่อยู่ร่วมกัน"
        case (.thai, .blockingOwnership):
            return "ต้องอธิบายกรรมสิทธิ์หรือสัดส่วนความเป็นเจ้าของ"
        case (.thai, .blockingExpenses):
            return "ต้องอธิบายการแบ่งค่าใช้จ่ายร่วมกัน"
        case (.thai, .blockingPlace):
            return "ยังไม่ได้กรอกสถานที่ลงนาม"
        case (.thai, .warningDebt):
            return "ยังไม่ได้กำหนดความรับผิดเรื่องหนี้ ควรระบุให้ชัดว่าใครรับผิดชอบภาระใด"
        case (.thai, .warningBreakup):
            return "ยังไม่ได้ระบุแนวทางเมื่อแยกทาง ควรกล่าวถึงการจัดการบ้านและทรัพย์สิน"
        case (.thai, .warningSpecialTerms):
            return "ช่องข้อกำหนดอื่นยังว่าง หากมีกฎพิเศษเรื่องซื้อ ขาย หรือชำระบัญชี ควรใส่ไว้"
        case (.thai, .clauseOneTitle):
            return "1. คู่สัญญา"
        case (.thai, .clauseTwoTitle):
            return "2. บ้านร่วมกัน"
        case (.thai, .clauseThreeTitle):
            return "3. กรรมสิทธิ์"
        case (.thai, .clauseFourTitle):
            return "4. ทรัพย์สินและค่าใช้จ่าย"
        case (.thai, .clauseFiveTitle):
            return "5. เงินกู้และหนี้"
        case (.thai, .clauseSixTitle):
            return "6. การยุติความสัมพันธ์และข้อกำหนดพิเศษ"
        case (.thai, .bodyPartiesPrefix):
            return "ระหว่าง"
        case (.thai, .bodyPartiesMiddle):
            return "และ"
        case (.thai, .bodyHomePrefix):
            return "คู่สัญญาอยู่ร่วมกันในบ้านดังต่อไปนี้:"
        case (.thai, .bodyOwnershipPrefix):
            return "ตกลงเรื่องกรรมสิทธิ์และสัดส่วนความเป็นเจ้าของดังนี้:"
        case (.thai, .bodySeparateAssetsPrefix):
            return "ทรัพย์สินต่อไปนี้ถือเป็นทรัพย์สินแยกของแต่ละฝ่าย:"
        case (.thai, .bodyExpensesPrefix):
            return "ค่าใช้จ่ายร่วมกันแบ่งดังนี้:"
        case (.thai, .bodyDebtPrefix):
            return "ความรับผิดชอบต่อเงินกู้และหนี้กำหนดดังนี้:"
        case (.thai, .bodyBreakupPrefix):
            return "หากเลิกราหรือฝ่ายหนึ่งย้ายออก ให้ใช้แนวทางดังต่อไปนี้:"
        case (.thai, .bodySpecialPrefix):
            return "ข้อกำหนดอื่น:"
        case (.thai, .bodyGoodFaith):
            return "คู่สัญญายืนยันว่าได้อ่านและเข้าใจข้อตกลงนี้ และจะใช้เป็นหลักในการกำหนดสิทธิในทรัพย์สินและเรื่องการเงินระหว่างกัน"
        case (.thai, .defaultDebt):
            return "แต่ละฝ่ายรับผิดชอบหนี้ของตนเอง เว้นแต่จะตกลงไว้อย่างชัดแจ้งเป็นอย่างอื่น"
        case (.thai, .defaultBreakup):
            return "คู่สัญญาจะพยายามจัดสรรเป็นลายลักษณ์อักษรอย่างสมเหตุสมผลตามหลักฐานกรรมสิทธิ์และข้อตกลงนี้"
        case (.thai, .defaultSpecialTerms):
            return "ไม่มีข้อกำหนดพิเศษเพิ่มเติม"
        }
    }
}
