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
    case guideTitle
    case guidePurpose
    case guidePreparation
    case guideResult
    case issuerHelp
    case payerHelp
    case requiredMarker
    case optionalMarker
    case nameExample
    case addressExample
    case phoneExample
    case emailExample
    case receiptForExample
    case amountExample
    case paymentDateExample
    case paymentMethodExample
    case notesExample
    case signingPlaceExample
    case signingDateHelp
    case draftSavedMessage
    case draftRestoredMessage
    case clearDraftButton
    case clearDraftTitle
    case clearDraftMessage
    case clearDraftConfirm
    case businessScopeWarning
    case pdfExportErrorTitle
    case pdfExportErrorMessage
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

struct ReceiptFormData: Equatable {
    var issuer = ContractParty()
    var payer = ContractParty()
    var receiptFor = ""
    var amount = ""
    var paymentDateText = ""
    var paymentMethod = ""
    var notes = ""
    var signingPlace = ""
    var signingDate = Date()

    var hasDraftContent: Bool {
        let values = [
            issuer.name, issuer.address, issuer.phone, issuer.email,
            payer.name, payer.address, payer.phone, payer.email,
            receiptFor, amount, paymentDateText, paymentMethod, notes, signingPlace
        ]
        return values.contains { $0.trimmed.isEmpty == false }
    }

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

    func formattedDate(in language: AppLanguage) -> String {
        return signingDate.formatted(
            Date.FormatStyle(date: .long, time: .omitted).locale(language.locale)
        )
    }

    var formattedDate: String {
        formattedDate(in: .norwegian)
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
        .paper { border: 1px solid #8d7358; padding: 36px; background: #f8efdd; overflow-wrap: anywhere; }
        .line { border-bottom: 1px solid #4a3c2d; margin-top: 20px; padding-top: 20px; overflow-wrap: anywhere; }
        .signature { margin-top: 44px; break-inside: avoid; page-break-inside: avoid; }
        </style>
        </head>
        <body>
        <div class="paper">
        <h1>\(language.receiptText(.title).htmlEscaped)</h1>
        <p>\(bodyText(in: language).htmlEscaped.replacingOccurrences(of: "\n", with: "<br><br>"))</p>
        <div class="signature">
        <p>\(signingPlace.htmlEscaped), \(formattedDate(in: language).htmlEscaped)</p>
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
        case (.norwegian, .guideTitle): return "Før du begynner"
        case (.norwegian, .guidePurpose): return "Bruk kvitteringen til å bekrefte at en bestemt betaling er mottatt."
        case (.norwegian, .guidePreparation): return "Ha navn og adresse til begge parter, beløp og valuta, betalingsdato og en kort beskrivelse av betalingen klart."
        case (.norwegian, .guideResult): return "Til slutt kan du kontrollere kvitteringen, lagre den som PDF eller skrive den ut."
        case (.norwegian, .issuerHelp): return "Oppgi personen eller virksomheten som mottok betalingen og utsteder kvitteringen."
        case (.norwegian, .payerHelp): return "Oppgi personen eller virksomheten som betalte."
        case (.norwegian, .requiredMarker): return "Påkrevd"
        case (.norwegian, .optionalMarker): return "Valgfritt"
        case (.norwegian, .nameExample): return "Eksempel: Kari Eksempel"
        case (.norwegian, .addressExample): return "Eksempel: Eksempelveien 10, 0123 Oslo"
        case (.norwegian, .phoneExample): return "Eksempel: 900 00 000"
        case (.norwegian, .emailExample): return "Eksempel: kari@example.no"
        case (.norwegian, .receiptForExample): return "Eksempel: Brukt skrivebord, serienummer 1234"
        case (.norwegian, .amountExample): return "Eksempel: 2 500 NOK"
        case (.norwegian, .paymentDateExample): return "Eksempel: 15.10.2026"
        case (.norwegian, .paymentMethodExample): return "Eksempel: Bankoverføring"
        case (.norwegian, .notesExample): return "Eksempel: Referanse 2026-014"
        case (.norwegian, .signingPlaceExample): return "Eksempel: Oslo"
        case (.norwegian, .signingDateHelp): return "Datoen kvitteringen signeres. Denne kan være en annen enn betalingsdatoen."
        case (.norwegian, .draftSavedMessage): return "Utfyllingen lagres automatisk som en kladd på denne enheten."
        case (.norwegian, .draftRestoredMessage): return "En tidligere kladd er gjenopprettet."
        case (.norwegian, .clearDraftButton): return "Slett kladd"
        case (.norwegian, .clearDraftTitle): return "Slette kvitteringskladden?"
        case (.norwegian, .clearDraftMessage): return "Alle opplysningene du har fylt inn i denne kvitteringen, fjernes fra appen."
        case (.norwegian, .clearDraftConfirm): return "Slett"
        case (.norwegian, .businessScopeWarning): return "Denne enkle malen er ikke laget som salgsdokumentasjon for bokførings- eller MVA-pliktige virksomheter."
        case (.norwegian, .pdfExportErrorTitle): return "Kunne ikke klargjøre PDF"
        case (.norwegian, .pdfExportErrorMessage): return "Prøv igjen. Hvis problemet fortsetter, kan du bruke Skriv ut og velge PDF der."
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
        case (.english, .guideTitle): return "Before you begin"
        case (.english, .guidePurpose): return "Use the receipt to confirm that a specific payment has been received."
        case (.english, .guidePreparation): return "Have both parties' names and addresses, the amount and currency, payment date, and a short payment description ready."
        case (.english, .guideResult): return "You can then review the receipt, save it as a PDF, or print it."
        case (.english, .issuerHelp): return "Enter the person or business that received the payment and issues the receipt."
        case (.english, .payerHelp): return "Enter the person or business that made the payment."
        case (.english, .requiredMarker): return "Required"
        case (.english, .optionalMarker): return "Optional"
        case (.english, .nameExample): return "Example: Alex Example"
        case (.english, .addressExample): return "Example: 10 Example Street, Oslo"
        case (.english, .phoneExample): return "Example: 900 00 000"
        case (.english, .emailExample): return "Example: alex@example.com"
        case (.english, .receiptForExample): return "Example: Used desk, serial number 1234"
        case (.english, .amountExample): return "Example: NOK 2,500"
        case (.english, .paymentDateExample): return "Example: 15 October 2026"
        case (.english, .paymentMethodExample): return "Example: Bank transfer"
        case (.english, .notesExample): return "Example: Reference 2026-014"
        case (.english, .signingPlaceExample): return "Example: Oslo"
        case (.english, .signingDateHelp): return "The date the receipt is signed. This may differ from the payment date."
        case (.english, .draftSavedMessage): return "Your entries are automatically saved as a draft on this device."
        case (.english, .draftRestoredMessage): return "A previous draft has been restored."
        case (.english, .clearDraftButton): return "Delete draft"
        case (.english, .clearDraftTitle): return "Delete the receipt draft?"
        case (.english, .clearDraftMessage): return "All information entered in this receipt will be removed from the app."
        case (.english, .clearDraftConfirm): return "Delete"
        case (.english, .businessScopeWarning): return "This simple template isn't designed as sales documentation for businesses subject to Norwegian bookkeeping or VAT rules."
        case (.english, .pdfExportErrorTitle): return "Couldn't prepare the PDF"
        case (.english, .pdfExportErrorMessage): return "Try again. If the problem continues, use Print and select PDF there."
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
        case (.thai, .guideTitle): return "ก่อนเริ่มต้น"
        case (.thai, .guidePurpose): return "ใช้ใบเสร็จเพื่อยืนยันว่าได้รับการชำระเงินรายการหนึ่งแล้ว"
        case (.thai, .guidePreparation): return "เตรียมชื่อและที่อยู่ของทั้งสองฝ่าย จำนวนเงินและสกุลเงิน วันที่ชำระ และคำอธิบายสั้น ๆ เกี่ยวกับการชำระเงิน"
        case (.thai, .guideResult): return "จากนั้นคุณสามารถตรวจสอบใบเสร็จ บันทึกเป็น PDF หรือพิมพ์ได้"
        case (.thai, .issuerHelp): return "กรอกชื่อบุคคลหรือธุรกิจที่รับเงินและออกใบเสร็จ"
        case (.thai, .payerHelp): return "กรอกชื่อบุคคลหรือธุรกิจที่ชำระเงิน"
        case (.thai, .requiredMarker): return "จำเป็น"
        case (.thai, .optionalMarker): return "ไม่บังคับ"
        case (.thai, .nameExample): return "ตัวอย่าง: กานดา ตัวอย่าง"
        case (.thai, .addressExample): return "ตัวอย่าง: 10 ถนนตัวอย่าง ออสโล"
        case (.thai, .phoneExample): return "ตัวอย่าง: 900 00 000"
        case (.thai, .emailExample): return "ตัวอย่าง: kanda@example.com"
        case (.thai, .receiptForExample): return "ตัวอย่าง: โต๊ะมือสอง หมายเลข 1234"
        case (.thai, .amountExample): return "ตัวอย่าง: 2,500 NOK"
        case (.thai, .paymentDateExample): return "ตัวอย่าง: 15.10.2026"
        case (.thai, .paymentMethodExample): return "ตัวอย่าง: โอนผ่านธนาคาร"
        case (.thai, .notesExample): return "ตัวอย่าง: เลขอ้างอิง 2026-014"
        case (.thai, .signingPlaceExample): return "ตัวอย่าง: ออสโล"
        case (.thai, .signingDateHelp): return "วันที่ลงนามในใบเสร็จ ซึ่งอาจต่างจากวันที่ชำระเงิน"
        case (.thai, .draftSavedMessage): return "ข้อมูลที่กรอกจะบันทึกเป็นฉบับร่างบนอุปกรณ์นี้โดยอัตโนมัติ"
        case (.thai, .draftRestoredMessage): return "กู้คืนฉบับร่างก่อนหน้าแล้ว"
        case (.thai, .clearDraftButton): return "ลบฉบับร่าง"
        case (.thai, .clearDraftTitle): return "ลบฉบับร่างใบเสร็จหรือไม่"
        case (.thai, .clearDraftMessage): return "ข้อมูลทั้งหมดที่กรอกในใบเสร็จนี้จะถูกลบออกจากแอป"
        case (.thai, .clearDraftConfirm): return "ลบ"
        case (.thai, .businessScopeWarning): return "แบบฟอร์มอย่างง่ายนี้ไม่ได้จัดทำเป็นเอกสารการขายสำหรับธุรกิจที่อยู่ภายใต้กฎการทำบัญชีหรือภาษีมูลค่าเพิ่มของนอร์เวย์"
        case (.thai, .pdfExportErrorTitle): return "ไม่สามารถเตรียม PDF ได้"
        case (.thai, .pdfExportErrorMessage): return "โปรดลองอีกครั้ง หากปัญหายังคงอยู่ ให้ใช้คำสั่งพิมพ์แล้วเลือก PDF"
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
