//
//  ReceiptModels.swift
//  LexWriter
//
//  Created by Codex on 03/09/2026.
//

import Foundation

enum ReceiptLocalizedKey {
    case title
    case cardSubtitle
    case legalChecklistTitle
    case issuerTitle
    case payerTitle
    case receiptTermsTitle
    case receiptForField
    case amountField
    case paymentDateField
    case paymentMethodField
    case notesField
    case previewButton
    case blockingIssuer
    case blockingPayer
    case blockingPurpose
    case blockingAmount
    case blockingPaymentDate
    case blockingPlace
    case warningMethod
    case warningNotes
    case clauseOneTitle
    case clauseTwoTitle
    case clauseThreeTitle
    case clauseFourTitle
    case bodyIssuerPrefix
    case bodyPayerPrefix
    case bodyReceiptPrefix
    case bodyPaymentPrefix
    case bodyNotesPrefix
    case bodyConfirmation
    case defaultMethod
    case defaultNotes
}

struct ReceiptFormData {
    var issuer = ContractParty()
    var payer = ContractParty()
    var receiptFor = ""
    var amount = ""
    var paymentDateText = ""
    var paymentMethod = ""
    var notes = ""
    var signingPlace = ""
    var signingDate = Date()

    func blockingIssues(in language: AppLanguage) -> [ValidationMessage] {
        var messages: [ValidationMessage] = []
        if issuer.name.trimmed.isEmpty || issuer.address.trimmed.isEmpty {
            messages.append(.init(severity: .blocking, message: language.receiptText(.blockingIssuer)))
        }
        if payer.name.trimmed.isEmpty || payer.address.trimmed.isEmpty {
            messages.append(.init(severity: .blocking, message: language.receiptText(.blockingPayer)))
        }
        if receiptFor.trimmed.isEmpty {
            messages.append(.init(severity: .blocking, message: language.receiptText(.blockingPurpose)))
        }
        if amount.trimmed.isEmpty {
            messages.append(.init(severity: .blocking, message: language.receiptText(.blockingAmount)))
        }
        if paymentDateText.trimmed.isEmpty {
            messages.append(.init(severity: .blocking, message: language.receiptText(.blockingPaymentDate)))
        }
        if signingPlace.trimmed.isEmpty {
            messages.append(.init(severity: .blocking, message: language.receiptText(.blockingPlace)))
        }
        return messages
    }

    func warnings(in language: AppLanguage) -> [ValidationMessage] {
        var messages: [ValidationMessage] = []
        if paymentMethod.trimmed.isEmpty {
            messages.append(.init(severity: .warning, message: language.receiptText(.warningMethod)))
        }
        if notes.trimmed.isEmpty {
            messages.append(.init(severity: .warning, message: language.receiptText(.warningNotes)))
        }
        return messages
    }

    var document: ReceiptDocument {
        ReceiptDocument(
            issuer: issuer,
            payer: payer,
            receiptFor: receiptFor.trimmed,
            amount: amount.trimmed,
            paymentDateText: paymentDateText.trimmed,
            paymentMethod: paymentMethod.trimmed,
            notes: notes.trimmed,
            signingPlace: signingPlace.trimmed,
            signingDate: signingDate
        )
    }
}

struct ReceiptDocument {
    let issuer: ContractParty
    let payer: ContractParty
    let receiptFor: String
    let amount: String
    let paymentDateText: String
    let paymentMethod: String
    let notes: String
    let signingPlace: String
    let signingDate: Date

    var formattedDate: String {
        signingDate.formatted(date: .long, time: .omitted)
    }

    func bodyText(in language: AppLanguage) -> String {
        let methodText = paymentMethod.isEmpty ? language.receiptText(.defaultMethod) : paymentMethod
        let notesText = notes.isEmpty ? language.receiptText(.defaultNotes) : notes

        return [
            "\(language.receiptText(.clauseOneTitle))\n\(language.receiptText(.bodyIssuerPrefix)) \(issuer.name.trimmed), \(issuer.address.trimmed).",
            "\(language.receiptText(.clauseTwoTitle))\n\(language.receiptText(.bodyPayerPrefix)) \(payer.name.trimmed), \(payer.address.trimmed).",
            "\(language.receiptText(.clauseThreeTitle))\n\(language.receiptText(.bodyReceiptPrefix)) \(receiptFor).\n\(language.receiptText(.bodyPaymentPrefix)) \(amount), \(paymentDateText), \(methodText).",
            "\(language.receiptText(.clauseFourTitle))\n\(language.receiptText(.bodyNotesPrefix)) \(notesText)",
            language.receiptText(.bodyConfirmation)
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
        <h1>\(language.receiptText(.title).htmlEscaped)</h1>
        <p>\(bodyText(in: language).htmlEscaped.replacingOccurrences(of: "\n", with: "<br><br>"))</p>
        <div class="signature">
        <p>\(signingPlace.htmlEscaped), \(formattedDate.htmlEscaped)</p>
        <div class="line">\(issuer.name.htmlEscaped)</div>
        <div class="line">\(payer.name.htmlEscaped)</div>
        </div>
        </div>
        </body>
        </html>
        """
    }
}

extension AppLanguage {
    var receiptChecklist: [String] {
        [
            receiptText(.bodyReceiptPrefix),
            receiptText(.warningMethod).replacingOccurrences(of: ".", with: ""),
            receiptText(.warningNotes).replacingOccurrences(of: ".", with: "")
        ]
    }

    func receiptText(_ key: ReceiptLocalizedKey) -> String {
        switch (self, key) {
        case (.norwegian, .title): return "Kvittering"
        case (.norwegian, .cardSubtitle): return "Lag en enkel betalingsbekreftelse med beløp, dato og hva betalingen gjelder."
        case (.norwegian, .legalChecklistTitle): return "Det som bør være tydelig i kvitteringen"
        case (.norwegian, .issuerTitle): return "Mottaker / utsteder"
        case (.norwegian, .payerTitle): return "Betaler"
        case (.norwegian, .receiptTermsTitle): return "Betalingsdetaljer"
        case (.norwegian, .receiptForField): return "Hva gjelder betalingen?"
        case (.norwegian, .amountField): return "Beløp"
        case (.norwegian, .paymentDateField): return "Betalingsdato"
        case (.norwegian, .paymentMethodField): return "Betalingsmåte"
        case (.norwegian, .notesField): return "Merknader eller referanse"
        case (.norwegian, .previewButton): return "Vis kvittering"
        case (.norwegian, .blockingIssuer): return "Utsteder må ha navn og adresse."
        case (.norwegian, .blockingPayer): return "Betaler må ha navn og adresse."
        case (.norwegian, .blockingPurpose): return "Det må beskrives hva betalingen gjelder."
        case (.norwegian, .blockingAmount): return "Beløpet må fylles inn."
        case (.norwegian, .blockingPaymentDate): return "Betalingsdato må fylles inn."
        case (.norwegian, .blockingPlace): return "Sted for signering mangler."
        case (.norwegian, .warningMethod): return "Betalingsmåte er ikke fylt inn. Det bør fremgå om betalingen skjedde kontant, via konto eller på annen måte."
        case (.norwegian, .warningNotes): return "Merknader er tomt. Referansenummer eller annen presisering kan være nyttig."
        case (.norwegian, .clauseOneTitle): return "1. Utsteder"
        case (.norwegian, .clauseTwoTitle): return "2. Betaler"
        case (.norwegian, .clauseThreeTitle): return "3. Betaling"
        case (.norwegian, .clauseFourTitle): return "4. Merknader"
        case (.norwegian, .bodyIssuerPrefix): return "Kvitteringen utstedes av"
        case (.norwegian, .bodyPayerPrefix): return "Betaling er mottatt fra"
        case (.norwegian, .bodyReceiptPrefix): return "Betalingen gjelder"
        case (.norwegian, .bodyPaymentPrefix): return "Mottatt beløp og betalingsdetaljer er"
        case (.norwegian, .bodyNotesPrefix): return "Følgende merknader eller referanser gjelder:"
        case (.norwegian, .bodyConfirmation): return "Utsteder bekrefter at opplysningene ovenfor beskriver mottatt betaling."
        case (.norwegian, .defaultMethod): return "betalingsmåte ikke spesifisert"
        case (.norwegian, .defaultNotes): return "Ingen ytterligere merknader er ført opp."
        case (.english, .title): return "Receipt"
        case (.english, .cardSubtitle): return "Prepare a simple payment confirmation with amount, date, and purpose."
        case (.english, .legalChecklistTitle): return "What should be clear in the receipt"
        case (.english, .issuerTitle): return "Recipient / issuer"
        case (.english, .payerTitle): return "Payer"
        case (.english, .receiptTermsTitle): return "Payment details"
        case (.english, .receiptForField): return "What is the payment for?"
        case (.english, .amountField): return "Amount"
        case (.english, .paymentDateField): return "Payment date"
        case (.english, .paymentMethodField): return "Payment method"
        case (.english, .notesField): return "Notes or reference"
        case (.english, .previewButton): return "Show receipt"
        case (.english, .blockingIssuer): return "The issuer must have a name and address."
        case (.english, .blockingPayer): return "The payer must have a name and address."
        case (.english, .blockingPurpose): return "The purpose of the payment must be described."
        case (.english, .blockingAmount): return "The amount must be entered."
        case (.english, .blockingPaymentDate): return "The payment date must be entered."
        case (.english, .blockingPlace): return "The place of signing is missing."
        case (.english, .warningMethod): return "The payment method is not entered. It should be clear whether the payment was made in cash, by transfer, or otherwise."
        case (.english, .warningNotes): return "Notes are empty. A reference number or clarification may be useful."
        case (.english, .clauseOneTitle): return "1. Issuer"
        case (.english, .clauseTwoTitle): return "2. Payer"
        case (.english, .clauseThreeTitle): return "3. Payment"
        case (.english, .clauseFourTitle): return "4. Notes"
        case (.english, .bodyIssuerPrefix): return "The receipt is issued by"
        case (.english, .bodyPayerPrefix): return "Payment has been received from"
        case (.english, .bodyReceiptPrefix): return "The payment concerns"
        case (.english, .bodyPaymentPrefix): return "The received amount and payment details are"
        case (.english, .bodyNotesPrefix): return "The following notes or references apply:"
        case (.english, .bodyConfirmation): return "The issuer confirms that the information above describes the received payment."
        case (.english, .defaultMethod): return "payment method not specified"
        case (.english, .defaultNotes): return "No additional notes have been entered."
        case (.thai, .title): return "ใบเสร็จรับเงิน"
        case (.thai, .cardSubtitle): return "จัดทำหลักฐานการชำระเงินอย่างง่ายพร้อมจำนวนเงิน วันที่ และวัตถุประสงค์ของการชำระ"
        case (.thai, .legalChecklistTitle): return "สิ่งที่ควรระบุให้ชัดในใบเสร็จรับเงิน"
        case (.thai, .issuerTitle): return "ผู้รับเงิน / ผู้ออกเอกสาร"
        case (.thai, .payerTitle): return "ผู้ชำระเงิน"
        case (.thai, .receiptTermsTitle): return "รายละเอียดการชำระเงิน"
        case (.thai, .receiptForField): return "การชำระเงินนี้เกี่ยวกับอะไร"
        case (.thai, .amountField): return "จำนวนเงิน"
        case (.thai, .paymentDateField): return "วันที่ชำระเงิน"
        case (.thai, .paymentMethodField): return "วิธีชำระเงิน"
        case (.thai, .notesField): return "หมายเหตุหรือเลขอ้างอิง"
        case (.thai, .previewButton): return "แสดงใบเสร็จรับเงิน"
        case (.thai, .blockingIssuer): return "ผู้ออกเอกสารต้องมีชื่อและที่อยู่"
        case (.thai, .blockingPayer): return "ผู้ชำระเงินต้องมีชื่อและที่อยู่"
        case (.thai, .blockingPurpose): return "ต้องอธิบายว่าการชำระเงินนี้เกี่ยวกับอะไร"
        case (.thai, .blockingAmount): return "ต้องกรอกจำนวนเงิน"
        case (.thai, .blockingPaymentDate): return "ต้องกรอกวันที่ชำระเงิน"
        case (.thai, .blockingPlace): return "ยังไม่ได้กรอกสถานที่ลงนาม"
        case (.thai, .warningMethod): return "ยังไม่ได้กรอกวิธีชำระเงิน ควรระบุว่าเป็นเงินสด โอนเงิน หรือวิธีอื่น"
        case (.thai, .warningNotes): return "ช่องหมายเหตุยังว่าง การใส่เลขอ้างอิงหรือคำอธิบายเพิ่มเติมอาจมีประโยชน์"
        case (.thai, .clauseOneTitle): return "1. ผู้ออกเอกสาร"
        case (.thai, .clauseTwoTitle): return "2. ผู้ชำระเงิน"
        case (.thai, .clauseThreeTitle): return "3. การชำระเงิน"
        case (.thai, .clauseFourTitle): return "4. หมายเหตุ"
        case (.thai, .bodyIssuerPrefix): return "ใบเสร็จนี้ออกโดย"
        case (.thai, .bodyPayerPrefix): return "ได้รับชำระเงินจาก"
        case (.thai, .bodyReceiptPrefix): return "การชำระเงินนี้เกี่ยวกับ"
        case (.thai, .bodyPaymentPrefix): return "จำนวนเงินและรายละเอียดการชำระที่ได้รับคือ"
        case (.thai, .bodyNotesPrefix): return "หมายเหตุหรือข้อมูลอ้างอิงมีดังนี้:"
        case (.thai, .bodyConfirmation): return "ผู้ออกเอกสารยืนยันว่าข้อมูลข้างต้นอธิบายการรับชำระเงินจริง"
        case (.thai, .defaultMethod): return "ไม่ได้ระบุวิธีชำระเงิน"
        case (.thai, .defaultNotes): return "ไม่มีหมายเหตุเพิ่มเติม"
        }
    }
}
