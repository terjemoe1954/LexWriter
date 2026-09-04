//
//  LoanAgreementModels.swift
//  LexWriter
//
//  Created by Codex on 03/09/2026.
//

import Foundation

enum LoanAgreementLocalizedKey {
    case title
    case cardSubtitle
    case legalChecklistTitle
    case lenderTitle
    case borrowerTitle
    case loanTermsTitle
    case amountField
    case disbursementDateField
    case dueDateField
    case repaymentField
    case interestField
    case latePaymentField
    case securityField
    case purposeField
    case previewButton
    case blockingLender
    case blockingBorrower
    case blockingAmount
    case blockingDueDate
    case blockingRepayment
    case blockingPlace
    case warningInterest
    case warningLatePayment
    case warningSecurity
    case warningPurpose
    case clauseOneTitle
    case clauseTwoTitle
    case clauseThreeTitle
    case clauseFourTitle
    case clauseFiveTitle
    case clauseSixTitle
    case bodyPartiesPrefix
    case bodyPartiesMiddle
    case bodyAmountPrefix
    case bodyDisbursementPrefix
    case bodyDueDatePrefix
    case bodyRepaymentPrefix
    case bodyInterestPrefix
    case bodyLatePaymentPrefix
    case bodySecurityPrefix
    case bodyPurposePrefix
    case bodyEvidence
    case defaultInterest
    case defaultLatePayment
    case defaultSecurity
    case defaultPurpose
}

struct LoanAgreementFormData {
    var lender = ContractParty()
    var borrower = ContractParty()
    var amount = ""
    var disbursementDate = ""
    var dueDate = ""
    var repaymentTerms = ""
    var interestTerms = ""
    var latePaymentTerms = ""
    var security = ""
    var purpose = ""
    var signingPlace = ""
    var signingDate = Date()

    func blockingIssues(in language: AppLanguage) -> [ValidationMessage] {
        var messages: [ValidationMessage] = []
        if lender.name.trimmed.isEmpty || lender.address.trimmed.isEmpty {
            messages.append(.init(severity: .blocking, message: language.loanAgreementText(.blockingLender)))
        }
        if borrower.name.trimmed.isEmpty || borrower.address.trimmed.isEmpty {
            messages.append(.init(severity: .blocking, message: language.loanAgreementText(.blockingBorrower)))
        }
        if amount.trimmed.isEmpty {
            messages.append(.init(severity: .blocking, message: language.loanAgreementText(.blockingAmount)))
        }
        if dueDate.trimmed.isEmpty {
            messages.append(.init(severity: .blocking, message: language.loanAgreementText(.blockingDueDate)))
        }
        if repaymentTerms.trimmed.isEmpty {
            messages.append(.init(severity: .blocking, message: language.loanAgreementText(.blockingRepayment)))
        }
        if signingPlace.trimmed.isEmpty {
            messages.append(.init(severity: .blocking, message: language.loanAgreementText(.blockingPlace)))
        }
        return messages
    }

    func warnings(in language: AppLanguage) -> [ValidationMessage] {
        var messages: [ValidationMessage] = []
        if interestTerms.trimmed.isEmpty {
            messages.append(.init(severity: .warning, message: language.loanAgreementText(.warningInterest)))
        }
        if latePaymentTerms.trimmed.isEmpty {
            messages.append(.init(severity: .warning, message: language.loanAgreementText(.warningLatePayment)))
        }
        if security.trimmed.isEmpty {
            messages.append(.init(severity: .warning, message: language.loanAgreementText(.warningSecurity)))
        }
        if purpose.trimmed.isEmpty {
            messages.append(.init(severity: .warning, message: language.loanAgreementText(.warningPurpose)))
        }
        return messages
    }

    var document: LoanAgreementDocument {
        LoanAgreementDocument(
            lender: lender,
            borrower: borrower,
            amount: amount.trimmed,
            disbursementDate: disbursementDate.trimmed,
            dueDate: dueDate.trimmed,
            repaymentTerms: repaymentTerms.trimmed,
            interestTerms: interestTerms.trimmed,
            latePaymentTerms: latePaymentTerms.trimmed,
            security: security.trimmed,
            purpose: purpose.trimmed,
            signingPlace: signingPlace.trimmed,
            signingDate: signingDate
        )
    }
}

struct LoanAgreementDocument {
    let lender: ContractParty
    let borrower: ContractParty
    let amount: String
    let disbursementDate: String
    let dueDate: String
    let repaymentTerms: String
    let interestTerms: String
    let latePaymentTerms: String
    let security: String
    let purpose: String
    let signingPlace: String
    let signingDate: Date

    var formattedDate: String {
        signingDate.formatted(date: .long, time: .omitted)
    }

    func bodyText(in language: AppLanguage) -> String {
        let interestText = interestTerms.isEmpty ? language.loanAgreementText(.defaultInterest) : interestTerms
        let latePaymentText = latePaymentTerms.isEmpty ? language.loanAgreementText(.defaultLatePayment) : latePaymentTerms
        let securityText = security.isEmpty ? language.loanAgreementText(.defaultSecurity) : security
        let purposeText = purpose.isEmpty ? language.loanAgreementText(.defaultPurpose) : purpose
        let disbursementText = disbursementDate.isEmpty ? formattedDate : disbursementDate

        return [
            "\(language.loanAgreementText(.clauseOneTitle))\n\(language.loanAgreementText(.bodyPartiesPrefix)) \(lender.name.trimmed), \(lender.address.trimmed), \(language.loanAgreementText(.bodyPartiesMiddle)) \(borrower.name.trimmed), \(borrower.address.trimmed).",
            "\(language.loanAgreementText(.clauseTwoTitle))\n\(language.loanAgreementText(.bodyAmountPrefix)) \(amount).\n\(language.loanAgreementText(.bodyDisbursementPrefix)) \(disbursementText).",
            "\(language.loanAgreementText(.clauseThreeTitle))\n\(language.loanAgreementText(.bodyDueDatePrefix)) \(dueDate).\n\(language.loanAgreementText(.bodyRepaymentPrefix)) \(repaymentTerms).",
            "\(language.loanAgreementText(.clauseFourTitle))\n\(language.loanAgreementText(.bodyInterestPrefix)) \(interestText).",
            "\(language.loanAgreementText(.clauseFiveTitle))\n\(language.loanAgreementText(.bodyLatePaymentPrefix)) \(latePaymentText).\n\(language.loanAgreementText(.bodySecurityPrefix)) \(securityText).",
            "\(language.loanAgreementText(.clauseSixTitle))\n\(language.loanAgreementText(.bodyPurposePrefix)) \(purposeText)",
            language.loanAgreementText(.bodyEvidence)
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
        <h1>\(language.loanAgreementText(.title).htmlEscaped)</h1>
        <p>\(bodyText(in: language).htmlEscaped.replacingOccurrences(of: "\n", with: "<br><br>"))</p>
        <div class="signature">
        <p>\(signingPlace.htmlEscaped), \(formattedDate.htmlEscaped)</p>
        <div class="line">\(lender.name.htmlEscaped)</div>
        <div class="line">\(borrower.name.htmlEscaped)</div>
        </div>
        </div>
        </body>
        </html>
        """
    }
}

extension AppLanguage {
    var loanAgreementChecklist: [String] {
        [
            loanAgreementText(.bodyAmountPrefix),
            loanAgreementText(.warningLatePayment).replacingOccurrences(of: ".", with: ""),
            loanAgreementText(.warningSecurity).replacingOccurrences(of: ".", with: "")
        ]
    }

    func loanAgreementText(_ key: LoanAgreementLocalizedKey) -> String {
        switch (self, key) {
        case (.norwegian, .title): return "Låneavtale"
        case (.norwegian, .cardSubtitle): return "Lag en låneavtale med beløp, forfall, tilbakebetaling, renter og sikkerhet."
        case (.norwegian, .legalChecklistTitle): return "Det som bør være tydelig i låneavtalen"
        case (.norwegian, .lenderTitle): return "Långiver"
        case (.norwegian, .borrowerTitle): return "Låntaker"
        case (.norwegian, .loanTermsTitle): return "Lånevilkår"
        case (.norwegian, .amountField): return "Lånebeløp"
        case (.norwegian, .disbursementDateField): return "Utbetalingsdato"
        case (.norwegian, .dueDateField): return "Forfallsdato"
        case (.norwegian, .repaymentField): return "Avdrag eller tilbakebetaling"
        case (.norwegian, .interestField): return "Renter eller rentefritt"
        case (.norwegian, .latePaymentField): return "Forsinket betaling"
        case (.norwegian, .securityField): return "Sikkerhet eller pant"
        case (.norwegian, .purposeField): return "Formål med lånet"
        case (.norwegian, .previewButton): return "Vis låneavtale"
        case (.norwegian, .blockingLender): return "Långiver må ha navn og adresse."
        case (.norwegian, .blockingBorrower): return "Låntaker må ha navn og adresse."
        case (.norwegian, .blockingAmount): return "Lånebeløpet må fylles inn."
        case (.norwegian, .blockingDueDate): return "Forfallsdato må fylles inn."
        case (.norwegian, .blockingRepayment): return "Tilbakebetaling må beskrives."
        case (.norwegian, .blockingPlace): return "Sted for signering mangler."
        case (.norwegian, .warningInterest): return "Renter er ikke regulert. Det bør fremgå om lånet er rentefritt eller hvilken rente som gjelder."
        case (.norwegian, .warningLatePayment): return "Forsinket betaling er ikke regulert. Det bør fremgå hva som skjer ved mislighold."
        case (.norwegian, .warningSecurity): return "Sikkerhet er ikke omtalt. Det bør fremgå om lånet er sikret eller usikret."
        case (.norwegian, .warningPurpose): return "Formålet med lånet er ikke beskrevet. Det kan være nyttig å angi hva lånet gis til."
        case (.norwegian, .clauseOneTitle): return "1. Parter"
        case (.norwegian, .clauseTwoTitle): return "2. Lånebeløp og utbetaling"
        case (.norwegian, .clauseThreeTitle): return "3. Forfall og tilbakebetaling"
        case (.norwegian, .clauseFourTitle): return "4. Renter"
        case (.norwegian, .clauseFiveTitle): return "5. Mislighold og sikkerhet"
        case (.norwegian, .clauseSixTitle): return "6. Formål"
        case (.norwegian, .bodyPartiesPrefix): return "Mellom"
        case (.norwegian, .bodyPartiesMiddle): return "og"
        case (.norwegian, .bodyAmountPrefix): return "Långiver stiller et lån på"
        case (.norwegian, .bodyDisbursementPrefix): return "Lånet utbetales"
        case (.norwegian, .bodyDueDatePrefix): return "Lånet forfaller"
        case (.norwegian, .bodyRepaymentPrefix): return "Tilbakebetaling skal skje slik"
        case (.norwegian, .bodyInterestPrefix): return "Følgende gjelder om renter"
        case (.norwegian, .bodyLatePaymentPrefix): return "Ved forsinket betaling gjelder følgende"
        case (.norwegian, .bodySecurityPrefix): return "Følgende gjelder om sikkerhet eller pant:"
        case (.norwegian, .bodyPurposePrefix): return "Lånet er gitt til følgende formål"
        case (.norwegian, .bodyEvidence): return "Denne avtalen er ment som skriftlig dokumentasjon for låneforholdet mellom partene."
        case (.norwegian, .defaultInterest): return "Lånet er rentefritt med mindre partene senere avtaler noe annet skriftlig."
        case (.norwegian, .defaultLatePayment): return "Ved forsinket betaling kan långiver kreve oppfyllelse i samsvar med alminnelige regler og det partene ellers har avtalt."
        case (.norwegian, .defaultSecurity): return "Lånet er usikret, med mindre annet fremgår av denne avtalen."
        case (.norwegian, .defaultPurpose): return "Formål er ikke nærmere spesifisert av partene."
        case (.english, .title): return "Loan Agreement"
        case (.english, .cardSubtitle): return "Prepare a loan agreement with amount, due date, repayment, interest, and security."
        case (.english, .legalChecklistTitle): return "What should be clear in the loan agreement"
        case (.english, .lenderTitle): return "Lender"
        case (.english, .borrowerTitle): return "Borrower"
        case (.english, .loanTermsTitle): return "Loan terms"
        case (.english, .amountField): return "Loan amount"
        case (.english, .disbursementDateField): return "Disbursement date"
        case (.english, .dueDateField): return "Due date"
        case (.english, .repaymentField): return "Installments or repayment"
        case (.english, .interestField): return "Interest or interest-free"
        case (.english, .latePaymentField): return "Late payment"
        case (.english, .securityField): return "Security or collateral"
        case (.english, .purposeField): return "Purpose of the loan"
        case (.english, .previewButton): return "Show loan agreement"
        case (.english, .blockingLender): return "The lender must have a name and address."
        case (.english, .blockingBorrower): return "The borrower must have a name and address."
        case (.english, .blockingAmount): return "The loan amount must be entered."
        case (.english, .blockingDueDate): return "The due date must be entered."
        case (.english, .blockingRepayment): return "Repayment must be described."
        case (.english, .blockingPlace): return "The place of signing is missing."
        case (.english, .warningInterest): return "Interest is not regulated. It should be clear whether the loan is interest-free or which rate applies."
        case (.english, .warningLatePayment): return "Late payment is not regulated. It should be clear what happens in case of default."
        case (.english, .warningSecurity): return "Security is not addressed. It should be clear whether the loan is secured or unsecured."
        case (.english, .warningPurpose): return "The purpose of the loan is not described. It may be useful to state why the loan is granted."
        case (.english, .clauseOneTitle): return "1. Parties"
        case (.english, .clauseTwoTitle): return "2. Amount and disbursement"
        case (.english, .clauseThreeTitle): return "3. Due date and repayment"
        case (.english, .clauseFourTitle): return "4. Interest"
        case (.english, .clauseFiveTitle): return "5. Default and security"
        case (.english, .clauseSixTitle): return "6. Purpose"
        case (.english, .bodyPartiesPrefix): return "Between"
        case (.english, .bodyPartiesMiddle): return "and"
        case (.english, .bodyAmountPrefix): return "The lender provides a loan of"
        case (.english, .bodyDisbursementPrefix): return "The loan will be disbursed"
        case (.english, .bodyDueDatePrefix): return "The loan falls due"
        case (.english, .bodyRepaymentPrefix): return "Repayment shall be made as follows"
        case (.english, .bodyInterestPrefix): return "The following applies to interest"
        case (.english, .bodyLatePaymentPrefix): return "In case of late payment, the following applies"
        case (.english, .bodySecurityPrefix): return "The following applies to security or collateral:"
        case (.english, .bodyPurposePrefix): return "The loan is granted for the following purpose"
        case (.english, .bodyEvidence): return "This agreement is intended as written evidence of the loan arrangement between the parties."
        case (.english, .defaultInterest): return "The loan is interest-free unless the parties later agree otherwise in writing."
        case (.english, .defaultLatePayment): return "In case of late payment, the lender may claim performance according to ordinary rules and the parties' other agreement."
        case (.english, .defaultSecurity): return "The loan is unsecured unless otherwise stated in this agreement."
        case (.english, .defaultPurpose): return "The purpose has not been specified further by the parties."
        case (.thai, .title): return "สัญญาเงินกู้"
        case (.thai, .cardSubtitle): return "จัดทำสัญญาเงินกู้พร้อมจำนวนเงิน วันครบกำหนด การชำระคืน ดอกเบี้ย และหลักประกัน"
        case (.thai, .legalChecklistTitle): return "สิ่งที่ควรระบุให้ชัดในสัญญาเงินกู้"
        case (.thai, .lenderTitle): return "ผู้ให้กู้"
        case (.thai, .borrowerTitle): return "ผู้กู้"
        case (.thai, .loanTermsTitle): return "เงื่อนไขเงินกู้"
        case (.thai, .amountField): return "จำนวนเงินกู้"
        case (.thai, .disbursementDateField): return "วันที่จ่ายเงินกู้"
        case (.thai, .dueDateField): return "วันครบกำหนด"
        case (.thai, .repaymentField): return "การผ่อนชำระหรือการชำระคืน"
        case (.thai, .interestField): return "ดอกเบี้ยหรือปลอดดอกเบี้ย"
        case (.thai, .latePaymentField): return "การชำระล่าช้า"
        case (.thai, .securityField): return "หลักประกัน"
        case (.thai, .purposeField): return "วัตถุประสงค์ของเงินกู้"
        case (.thai, .previewButton): return "แสดงสัญญาเงินกู้"
        case (.thai, .blockingLender): return "ผู้ให้กู้ต้องมีชื่อและที่อยู่"
        case (.thai, .blockingBorrower): return "ผู้กู้ต้องมีชื่อและที่อยู่"
        case (.thai, .blockingAmount): return "ต้องกรอกจำนวนเงินกู้"
        case (.thai, .blockingDueDate): return "ต้องกรอกวันครบกำหนด"
        case (.thai, .blockingRepayment): return "ต้องอธิบายการชำระคืน"
        case (.thai, .blockingPlace): return "ยังไม่ได้กรอกสถานที่ลงนาม"
        case (.thai, .warningInterest): return "ยังไม่ได้กำหนดดอกเบี้ย ควรระบุให้ชัดว่าเป็นเงินกู้ปลอดดอกเบี้ยหรือใช้อัตราใด"
        case (.thai, .warningLatePayment): return "ยังไม่ได้กำหนดผลของการชำระล่าช้า ควรระบุให้ชัดว่าจะเกิดอะไรขึ้นเมื่อผิดนัด"
        case (.thai, .warningSecurity): return "ยังไม่ได้กล่าวถึงหลักประกัน ควรระบุให้ชัดว่าเงินกู้นี้มีหรือไม่มีหลักประกัน"
        case (.thai, .warningPurpose): return "ยังไม่ได้อธิบายวัตถุประสงค์ของเงินกู้ การระบุเหตุผลของการกู้เงินอาจเป็นประโยชน์"
        case (.thai, .clauseOneTitle): return "1. คู่สัญญา"
        case (.thai, .clauseTwoTitle): return "2. จำนวนเงินและการจ่าย"
        case (.thai, .clauseThreeTitle): return "3. วันครบกำหนดและการชำระคืน"
        case (.thai, .clauseFourTitle): return "4. ดอกเบี้ย"
        case (.thai, .clauseFiveTitle): return "5. การผิดนัดและหลักประกัน"
        case (.thai, .clauseSixTitle): return "6. วัตถุประสงค์"
        case (.thai, .bodyPartiesPrefix): return "ระหว่าง"
        case (.thai, .bodyPartiesMiddle): return "และ"
        case (.thai, .bodyAmountPrefix): return "ผู้ให้กู้ให้เงินกู้จำนวน"
        case (.thai, .bodyDisbursementPrefix): return "เงินกู้จะจ่าย"
        case (.thai, .bodyDueDatePrefix): return "เงินกู้ครบกำหนด"
        case (.thai, .bodyRepaymentPrefix): return "การชำระคืนจะเป็นดังนี้"
        case (.thai, .bodyInterestPrefix): return "ดอกเบี้ยมีเงื่อนไขดังนี้"
        case (.thai, .bodyLatePaymentPrefix): return "กรณีชำระล่าช้าให้ใช้เงื่อนไขดังนี้"
        case (.thai, .bodySecurityPrefix): return "หลักประกันหรือทรัพย์ค้ำมีดังนี้:"
        case (.thai, .bodyPurposePrefix): return "เงินกู้นี้ให้เพื่อวัตถุประสงค์ดังต่อไปนี้"
        case (.thai, .bodyEvidence): return "สัญญานี้มีวัตถุประสงค์เพื่อเป็นหลักฐานเป็นลายลักษณ์อักษรของความสัมพันธ์เงินกู้ระหว่างคู่สัญญา"
        case (.thai, .defaultInterest): return "เงินกู้นี้ปลอดดอกเบี้ย เว้นแต่คู่สัญญาจะตกลงเป็นลายลักษณ์อักษรเป็นอย่างอื่นภายหลัง"
        case (.thai, .defaultLatePayment): return "หากชำระล่าช้า ผู้ให้กู้อาจเรียกร้องให้ปฏิบัติตามกฎทั่วไปและข้อตกลงอื่นของคู่สัญญา"
        case (.thai, .defaultSecurity): return "เงินกู้นี้ไม่มีหลักประกัน เว้นแต่จะระบุไว้เป็นอย่างอื่นในสัญญานี้"
        case (.thai, .defaultPurpose): return "คู่สัญญาไม่ได้ระบุวัตถุประสงค์ของเงินกู้อย่างละเอียด"
        }
    }
}
