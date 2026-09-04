//
//  DebtInstrumentModels.swift
//  LexWriter
//
//  Created by Codex on 29/08/2026.
//

import Foundation

enum DebtLocalizedKey {
    case title
    case cardSubtitle
    case legalChecklistTitle
    case creditorTitle
    case debtorTitle
    case debtTermsTitle
    case principalAmountField
    case issueDateField
    case dueDateField
    case interestField
    case repaymentField
    case defaultField
    case collateralField
    case previewButton
    case blockingCreditor
    case blockingDebtor
    case blockingAmount
    case blockingDueDate
    case blockingRepayment
    case blockingPlace
    case warningInterest
    case warningDefault
    case warningCollateral
    case clauseOneTitle
    case clauseTwoTitle
    case clauseThreeTitle
    case clauseFourTitle
    case clauseFiveTitle
    case clauseSixTitle
    case bodyPartiesPrefix
    case bodyPartiesMiddle
    case bodyAmountPrefix
    case bodyIssueDatePrefix
    case bodyDueDatePrefix
    case bodyInterestPrefix
    case bodyRepaymentPrefix
    case bodyDefaultPrefix
    case bodyCollateralPrefix
    case bodyEvidence
    case defaultInterest
    case defaultDefaultTerms
    case defaultCollateral
}

struct DebtParty: Equatable {
    var name = ""
    var address = ""
    var phone = ""
    var email = ""
}

struct DebtInstrumentFormData {
    var creditor = DebtParty()
    var debtor = DebtParty()
    var principalAmount = ""
    var issueDateText = ""
    var dueDateText = ""
    var interestTerms = ""
    var repaymentTerms = ""
    var defaultConsequences = ""
    var collateral = ""
    var signingPlace = ""
    var signingDate = Date()

    func blockingIssues(in language: AppLanguage) -> [ValidationMessage] {
        var messages: [ValidationMessage] = []

        if creditor.name.trimmed.isEmpty || creditor.address.trimmed.isEmpty {
            messages.append(.init(severity: .blocking, message: language.debtText(.blockingCreditor)))
        }

        if debtor.name.trimmed.isEmpty || debtor.address.trimmed.isEmpty {
            messages.append(.init(severity: .blocking, message: language.debtText(.blockingDebtor)))
        }

        if principalAmount.trimmed.isEmpty {
            messages.append(.init(severity: .blocking, message: language.debtText(.blockingAmount)))
        }

        if dueDateText.trimmed.isEmpty {
            messages.append(.init(severity: .blocking, message: language.debtText(.blockingDueDate)))
        }

        if repaymentTerms.trimmed.isEmpty {
            messages.append(.init(severity: .blocking, message: language.debtText(.blockingRepayment)))
        }

        if signingPlace.trimmed.isEmpty {
            messages.append(.init(severity: .blocking, message: language.debtText(.blockingPlace)))
        }

        return messages
    }

    func warnings(in language: AppLanguage) -> [ValidationMessage] {
        var messages: [ValidationMessage] = []

        if interestTerms.trimmed.isEmpty {
            messages.append(.init(severity: .warning, message: language.debtText(.warningInterest)))
        }

        if defaultConsequences.trimmed.isEmpty {
            messages.append(.init(severity: .warning, message: language.debtText(.warningDefault)))
        }

        if collateral.trimmed.isEmpty {
            messages.append(.init(severity: .warning, message: language.debtText(.warningCollateral)))
        }

        return messages
    }

    var document: DebtInstrumentDocument {
        DebtInstrumentDocument(
            creditor: creditor,
            debtor: debtor,
            principalAmount: principalAmount.trimmed,
            issueDateText: issueDateText.trimmed,
            dueDateText: dueDateText.trimmed,
            interestTerms: interestTerms.trimmed,
            repaymentTerms: repaymentTerms.trimmed,
            defaultConsequences: defaultConsequences.trimmed,
            collateral: collateral.trimmed,
            signingPlace: signingPlace.trimmed,
            signingDate: signingDate
        )
    }
}

struct DebtInstrumentDocument {
    let creditor: DebtParty
    let debtor: DebtParty
    let principalAmount: String
    let issueDateText: String
    let dueDateText: String
    let interestTerms: String
    let repaymentTerms: String
    let defaultConsequences: String
    let collateral: String
    let signingPlace: String
    let signingDate: Date

    var formattedDate: String {
        signingDate.formatted(date: .long, time: .omitted)
    }

    func bodyText(in language: AppLanguage) -> String {
        let issueText = issueDateText.isEmpty ? formattedDate : issueDateText
        let interestText = interestTerms.isEmpty ? language.debtText(.defaultInterest) : interestTerms
        let defaultText = defaultConsequences.isEmpty ? language.debtText(.defaultDefaultTerms) : defaultConsequences
        let collateralText = collateral.isEmpty ? language.debtText(.defaultCollateral) : collateral

        return [
            "\(language.debtText(.clauseOneTitle))\n\(language.debtText(.bodyPartiesPrefix)) \(creditor.name.trimmed), \(creditor.address.trimmed), \(language.debtText(.bodyPartiesMiddle)) \(debtor.name.trimmed), \(debtor.address.trimmed).",
            "\(language.debtText(.clauseTwoTitle))\n\(language.debtText(.bodyAmountPrefix)) \(principalAmount).",
            "\(language.debtText(.clauseThreeTitle))\n\(language.debtText(.bodyIssueDatePrefix)) \(issueText).\n\(language.debtText(.bodyDueDatePrefix)) \(dueDateText).",
            "\(language.debtText(.clauseFourTitle))\n\(language.debtText(.bodyInterestPrefix)) \(interestText).",
            "\(language.debtText(.clauseFiveTitle))\n\(language.debtText(.bodyRepaymentPrefix)) \(repaymentTerms).",
            "\(language.debtText(.clauseSixTitle))\n\(language.debtText(.bodyDefaultPrefix)) \(defaultText)\n\(language.debtText(.bodyCollateralPrefix)) \(collateralText)",
            language.debtText(.bodyEvidence)
        ].joined(separator: "\n\n")
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
        <h1>\(language.debtText(.title).htmlEscaped)</h1>
        <p>\(bodyText(in: language).htmlEscaped.replacingOccurrences(of: "\n", with: "<br><br>"))</p>
        <div class="signature">
        <p>\(signingPlace.htmlEscaped), \(formattedDate.htmlEscaped)</p>
        <div class="line">\(creditor.name.htmlEscaped)</div>
        <div class="line">\(debtor.name.htmlEscaped)</div>
        </div>
        </div>
        </body>
        </html>
        """
    }
}

extension AppLanguage {
    var debtChecklist: [String] {
        [
            debtText(.bodyAmountPrefix),
            debtText(.warningDefault).replacingOccurrences(of: ".", with: ""),
            debtText(.warningCollateral).replacingOccurrences(of: ".", with: "")
        ]
    }

    func debtText(_ key: DebtLocalizedKey) -> String {
        switch (self, key) {
        case (.norwegian, .title):
            return "Gjeldsbrev"
        case (.norwegian, .cardSubtitle):
            return "Lag et skriftlig gjeldsbrev med beløp, forfall, nedbetaling og signatur."
        case (.norwegian, .legalChecklistTitle):
            return "Det som bør være tydelig i gjeldsbrevet"
        case (.norwegian, .creditorTitle):
            return "Kreditor"
        case (.norwegian, .debtorTitle):
            return "Skyldner"
        case (.norwegian, .debtTermsTitle):
            return "Lånevilkår"
        case (.norwegian, .principalAmountField):
            return "Beløp"
        case (.norwegian, .issueDateField):
            return "Dato for lånet / utstedelse"
        case (.norwegian, .dueDateField):
            return "Forfallsdato"
        case (.norwegian, .interestField):
            return "Renter eller rentefritt"
        case (.norwegian, .repaymentField):
            return "Hvordan og når skal beløpet betales tilbake?"
        case (.norwegian, .defaultField):
            return "Hva skjer ved forsinket betaling?"
        case (.norwegian, .collateralField):
            return "Pant eller sikkerhet"
        case (.norwegian, .previewButton):
            return "Vis gjeldsbrev"
        case (.norwegian, .blockingCreditor):
            return "Kreditor må ha navn og adresse."
        case (.norwegian, .blockingDebtor):
            return "Skyldner må ha navn og adresse."
        case (.norwegian, .blockingAmount):
            return "Beløpet må fylles inn."
        case (.norwegian, .blockingDueDate):
            return "Forfallsdato må fylles inn."
        case (.norwegian, .blockingRepayment):
            return "Tilbakebetaling må beskrives."
        case (.norwegian, .blockingPlace):
            return "Sted for signering mangler."
        case (.norwegian, .warningInterest):
            return "Renter er ikke regulert. Det bør fremgå om lånet er rentefritt eller hvilken rente som gjelder."
        case (.norwegian, .warningDefault):
            return "Forsinket betaling er ikke regulert. Det bør fremgå hva som skjer ved mislighold."
        case (.norwegian, .warningCollateral):
            return "Pant eller sikkerhet er ikke omtalt. Hvis lånet skal være usikret, kan dette med fordel sies uttrykkelig."
        case (.norwegian, .clauseOneTitle):
            return "1. Parter"
        case (.norwegian, .clauseTwoTitle):
            return "2. Lånebeløp"
        case (.norwegian, .clauseThreeTitle):
            return "3. Utstedelse og forfall"
        case (.norwegian, .clauseFourTitle):
            return "4. Renter"
        case (.norwegian, .clauseFiveTitle):
            return "5. Tilbakebetaling"
        case (.norwegian, .clauseSixTitle):
            return "6. Mislighold og sikkerhet"
        case (.norwegian, .bodyPartiesPrefix):
            return "Mellom"
        case (.norwegian, .bodyPartiesMiddle):
            return "og"
        case (.norwegian, .bodyAmountPrefix):
            return "Skyldner erkjenner å skylde kreditor følgende beløp:"
        case (.norwegian, .bodyIssueDatePrefix):
            return "Gjeldsbrevet er datert"
        case (.norwegian, .bodyDueDatePrefix):
            return "Beløpet forfaller til betaling"
        case (.norwegian, .bodyInterestPrefix):
            return "Rentevilkår:"
        case (.norwegian, .bodyRepaymentPrefix):
            return "Tilbakebetaling skal skje slik:"
        case (.norwegian, .bodyDefaultPrefix):
            return "Ved forsinket betaling eller annet mislighold gjelder følgende:"
        case (.norwegian, .bodyCollateralPrefix):
            return "Pant eller annen sikkerhet:"
        case (.norwegian, .bodyEvidence):
            return "Dokumentet er ment som skriftlig bevis for gjeldsforholdet mellom partene og bør oppbevares sammen med eventuell betalingsdokumentasjon."
        case (.norwegian, .defaultInterest):
            return "Lånet er rentefritt med mindre annet følger av senere skriftlig avtale."
        case (.norwegian, .defaultDefaultTerms):
            return "Ved mislighold kan kreditor kreve betaling i samsvar med gjeldende rett og dokumenterte kostnader."
        case (.norwegian, .defaultCollateral):
            return "Ingen særskilt sikkerhet er avtalt."
        case (.english, .title):
            return "Promissory Note"
        case (.english, .cardSubtitle):
            return "Prepare a written debt note with amount, due date, repayment, and signature."
        case (.english, .legalChecklistTitle):
            return "What should be clear in the debt note"
        case (.english, .creditorTitle):
            return "Creditor"
        case (.english, .debtorTitle):
            return "Debtor"
        case (.english, .debtTermsTitle):
            return "Loan terms"
        case (.english, .principalAmountField):
            return "Amount"
        case (.english, .issueDateField):
            return "Loan / issue date"
        case (.english, .dueDateField):
            return "Due date"
        case (.english, .interestField):
            return "Interest terms or interest-free"
        case (.english, .repaymentField):
            return "How and when will the amount be repaid?"
        case (.english, .defaultField):
            return "What happens in case of late payment?"
        case (.english, .collateralField):
            return "Collateral or security"
        case (.english, .previewButton):
            return "Show promissory note"
        case (.english, .blockingCreditor):
            return "The creditor must have a name and address."
        case (.english, .blockingDebtor):
            return "The debtor must have a name and address."
        case (.english, .blockingAmount):
            return "The amount must be entered."
        case (.english, .blockingDueDate):
            return "The due date must be entered."
        case (.english, .blockingRepayment):
            return "Repayment terms must be described."
        case (.english, .blockingPlace):
            return "The place of signing is missing."
        case (.english, .warningInterest):
            return "Interest is not regulated. It should be clear whether the loan is interest-free or what rate applies."
        case (.english, .warningDefault):
            return "Late payment is not regulated. The document should state what happens in case of default."
        case (.english, .warningCollateral):
            return "Collateral or security is not mentioned. If the loan is unsecured, it may be useful to say so expressly."
        case (.english, .clauseOneTitle):
            return "1. Parties"
        case (.english, .clauseTwoTitle):
            return "2. Principal amount"
        case (.english, .clauseThreeTitle):
            return "3. Issue and due date"
        case (.english, .clauseFourTitle):
            return "4. Interest"
        case (.english, .clauseFiveTitle):
            return "5. Repayment"
        case (.english, .clauseSixTitle):
            return "6. Default and security"
        case (.english, .bodyPartiesPrefix):
            return "Between"
        case (.english, .bodyPartiesMiddle):
            return "and"
        case (.english, .bodyAmountPrefix):
            return "The debtor acknowledges owing the creditor the following amount:"
        case (.english, .bodyIssueDatePrefix):
            return "This note is dated"
        case (.english, .bodyDueDatePrefix):
            return "The amount falls due on"
        case (.english, .bodyInterestPrefix):
            return "Interest terms:"
        case (.english, .bodyRepaymentPrefix):
            return "Repayment shall take place as follows:"
        case (.english, .bodyDefaultPrefix):
            return "In the event of late payment or other default, the following applies:"
        case (.english, .bodyCollateralPrefix):
            return "Collateral or other security:"
        case (.english, .bodyEvidence):
            return "This document is intended as written evidence of the debt relationship between the parties and should be kept together with any payment records."
        case (.english, .defaultInterest):
            return "The loan is interest-free unless otherwise agreed later in writing."
        case (.english, .defaultDefaultTerms):
            return "In the event of default, the creditor may seek payment in accordance with applicable law and documented costs."
        case (.english, .defaultCollateral):
            return "No specific security has been agreed."
        case (.thai, .title):
            return "หนังสือรับสภาพหนี้"
        case (.thai, .cardSubtitle):
            return "จัดทำเอกสารหนี้เป็นลายลักษณ์อักษรพร้อมจำนวนเงิน วันครบกำหนด การชำระคืน และลายเซ็น"
        case (.thai, .legalChecklistTitle):
            return "สิ่งที่ควรระบุให้ชัดในหนังสือรับสภาพหนี้"
        case (.thai, .creditorTitle):
            return "เจ้าหนี้"
        case (.thai, .debtorTitle):
            return "ลูกหนี้"
        case (.thai, .debtTermsTitle):
            return "เงื่อนไขเงินกู้"
        case (.thai, .principalAmountField):
            return "จำนวนเงิน"
        case (.thai, .issueDateField):
            return "วันที่ให้กู้ / วันที่ออกเอกสาร"
        case (.thai, .dueDateField):
            return "วันครบกำหนด"
        case (.thai, .interestField):
            return "ดอกเบี้ยหรือปลอดดอกเบี้ย"
        case (.thai, .repaymentField):
            return "จะชำระคืนอย่างไรและเมื่อใด"
        case (.thai, .defaultField):
            return "หากชำระล่าช้าจะเกิดอะไรขึ้น"
        case (.thai, .collateralField):
            return "หลักประกันหรือทรัพย์ค้ำประกัน"
        case (.thai, .previewButton):
            return "แสดงหนังสือรับสภาพหนี้"
        case (.thai, .blockingCreditor):
            return "เจ้าหนี้ต้องมีชื่อและที่อยู่"
        case (.thai, .blockingDebtor):
            return "ลูกหนี้ต้องมีชื่อและที่อยู่"
        case (.thai, .blockingAmount):
            return "ต้องกรอกจำนวนเงิน"
        case (.thai, .blockingDueDate):
            return "ต้องกรอกวันครบกำหนด"
        case (.thai, .blockingRepayment):
            return "ต้องอธิบายการชำระคืน"
        case (.thai, .blockingPlace):
            return "ยังไม่ได้กรอกสถานที่ลงนาม"
        case (.thai, .warningInterest):
            return "ยังไม่ได้กำหนดดอกเบี้ย ควรระบุให้ชัดว่าเงินกู้นี้ปลอดดอกเบี้ยหรือใช้อัตราใด"
        case (.thai, .warningDefault):
            return "ยังไม่ได้กำหนดผลของการผิดนัด ควรระบุว่าจะเกิดอะไรขึ้นหากชำระล่าช้า"
        case (.thai, .warningCollateral):
            return "ยังไม่ได้กล่าวถึงหลักประกัน หากเงินกู้นี้ไม่มีหลักประกัน อาจระบุไว้โดยชัดแจ้ง"
        case (.thai, .clauseOneTitle):
            return "1. คู่สัญญา"
        case (.thai, .clauseTwoTitle):
            return "2. จำนวนเงินต้น"
        case (.thai, .clauseThreeTitle):
            return "3. วันออกเอกสารและวันครบกำหนด"
        case (.thai, .clauseFourTitle):
            return "4. ดอกเบี้ย"
        case (.thai, .clauseFiveTitle):
            return "5. การชำระคืน"
        case (.thai, .clauseSixTitle):
            return "6. การผิดนัดและหลักประกัน"
        case (.thai, .bodyPartiesPrefix):
            return "ระหว่าง"
        case (.thai, .bodyPartiesMiddle):
            return "และ"
        case (.thai, .bodyAmountPrefix):
            return "ลูกหนี้รับรองว่าเป็นหนี้เจ้าหนี้เป็นจำนวนดังต่อไปนี้:"
        case (.thai, .bodyIssueDatePrefix):
            return "เอกสารนี้ลงวันที่"
        case (.thai, .bodyDueDatePrefix):
            return "จำนวนเงินครบกำหนดชำระในวันที่"
        case (.thai, .bodyInterestPrefix):
            return "เงื่อนไขดอกเบี้ย:"
        case (.thai, .bodyRepaymentPrefix):
            return "การชำระคืนให้เป็นไปดังนี้:"
        case (.thai, .bodyDefaultPrefix):
            return "หากชำระล่าช้าหรือผิดนัด ให้ใช้เงื่อนไขดังต่อไปนี้:"
        case (.thai, .bodyCollateralPrefix):
            return "หลักประกันหรือความมั่นคงอื่น:"
        case (.thai, .bodyEvidence):
            return "เอกสารนี้จัดทำขึ้นเพื่อเป็นหลักฐานเป็นลายลักษณ์อักษรของความสัมพันธ์หนี้ระหว่างคู่สัญญา และควรเก็บไว้พร้อมหลักฐานการชำระเงิน"
        case (.thai, .defaultInterest):
            return "เงินกู้นี้ปลอดดอกเบี้ย เว้นแต่จะมีข้อตกลงเป็นลายลักษณ์อักษรในภายหลัง"
        case (.thai, .defaultDefaultTerms):
            return "หากผิดนัด เจ้าหนี้อาจเรียกชำระตามกฎหมายที่ใช้บังคับและค่าใช้จ่ายที่พิสูจน์ได้"
        case (.thai, .defaultCollateral):
            return "ไม่ได้ตกลงหลักประกันเฉพาะไว้"
        }
    }
}
