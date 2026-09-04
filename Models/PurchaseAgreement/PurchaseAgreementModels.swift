//
//  PurchaseAgreementModels.swift
//  LexWriter
//
//  Created by Codex on 03/09/2026.
//

import Foundation

enum PurchaseLocalizedKey {
    case title
    case cardSubtitle
    case legalChecklistTitle
    case sellerTitle
    case buyerTitle
    case agreementTermsTitle
    case itemField
    case purchasePriceField
    case handoverDateField
    case conditionField
    case paymentTermsField
    case defectsField
    case previewButton
    case blockingSeller
    case blockingBuyer
    case blockingItem
    case blockingPrice
    case blockingHandover
    case blockingPlace
    case warningCondition
    case warningPayment
    case warningDefects
    case clauseOneTitle
    case clauseTwoTitle
    case clauseThreeTitle
    case clauseFourTitle
    case clauseFiveTitle
    case clauseSixTitle
    case bodyPartiesPrefix
    case bodyPartiesMiddle
    case bodyItemPrefix
    case bodyPricePrefix
    case bodyHandoverPrefix
    case bodyConditionPrefix
    case bodyPaymentPrefix
    case bodyDefectsPrefix
    case bodyGoodFaith
    case defaultCondition
    case defaultPayment
    case defaultDefects
}

struct PurchaseAgreementFormData {
    var seller = ContractParty()
    var buyer = ContractParty()
    var itemDescription = ""
    var purchasePrice = ""
    var handoverDate = ""
    var conditionDescription = ""
    var paymentTerms = ""
    var defectsAndClaims = ""
    var signingPlace = ""
    var signingDate = Date()

    func blockingIssues(in language: AppLanguage) -> [ValidationMessage] {
        var messages: [ValidationMessage] = []

        if seller.name.trimmed.isEmpty || seller.address.trimmed.isEmpty {
            messages.append(.init(severity: .blocking, message: language.purchaseText(.blockingSeller)))
        }
        if buyer.name.trimmed.isEmpty || buyer.address.trimmed.isEmpty {
            messages.append(.init(severity: .blocking, message: language.purchaseText(.blockingBuyer)))
        }
        if itemDescription.trimmed.isEmpty {
            messages.append(.init(severity: .blocking, message: language.purchaseText(.blockingItem)))
        }
        if purchasePrice.trimmed.isEmpty {
            messages.append(.init(severity: .blocking, message: language.purchaseText(.blockingPrice)))
        }
        if handoverDate.trimmed.isEmpty {
            messages.append(.init(severity: .blocking, message: language.purchaseText(.blockingHandover)))
        }
        if signingPlace.trimmed.isEmpty {
            messages.append(.init(severity: .blocking, message: language.purchaseText(.blockingPlace)))
        }

        return messages
    }

    func warnings(in language: AppLanguage) -> [ValidationMessage] {
        var messages: [ValidationMessage] = []

        if conditionDescription.trimmed.isEmpty {
            messages.append(.init(severity: .warning, message: language.purchaseText(.warningCondition)))
        }
        if paymentTerms.trimmed.isEmpty {
            messages.append(.init(severity: .warning, message: language.purchaseText(.warningPayment)))
        }
        if defectsAndClaims.trimmed.isEmpty {
            messages.append(.init(severity: .warning, message: language.purchaseText(.warningDefects)))
        }

        return messages
    }

    var document: PurchaseAgreementDocument {
        PurchaseAgreementDocument(
            seller: seller,
            buyer: buyer,
            itemDescription: itemDescription.trimmed,
            purchasePrice: purchasePrice.trimmed,
            handoverDate: handoverDate.trimmed,
            conditionDescription: conditionDescription.trimmed,
            paymentTerms: paymentTerms.trimmed,
            defectsAndClaims: defectsAndClaims.trimmed,
            signingPlace: signingPlace.trimmed,
            signingDate: signingDate
        )
    }
}

struct PurchaseAgreementDocument {
    let seller: ContractParty
    let buyer: ContractParty
    let itemDescription: String
    let purchasePrice: String
    let handoverDate: String
    let conditionDescription: String
    let paymentTerms: String
    let defectsAndClaims: String
    let signingPlace: String
    let signingDate: Date

    var formattedDate: String {
        signingDate.formatted(date: .long, time: .omitted)
    }

    func bodyText(in language: AppLanguage) -> String {
        let conditionText = conditionDescription.isEmpty ? language.purchaseText(.defaultCondition) : conditionDescription
        let paymentText = paymentTerms.isEmpty ? language.purchaseText(.defaultPayment) : paymentTerms
        let defectsText = defectsAndClaims.isEmpty ? language.purchaseText(.defaultDefects) : defectsAndClaims

        return [
            "\(language.purchaseText(.clauseOneTitle))\n\(language.purchaseText(.bodyPartiesPrefix)) \(seller.name.trimmed), \(seller.address.trimmed), \(language.purchaseText(.bodyPartiesMiddle)) \(buyer.name.trimmed), \(buyer.address.trimmed).",
            "\(language.purchaseText(.clauseTwoTitle))\n\(language.purchaseText(.bodyItemPrefix)) \(itemDescription).",
            "\(language.purchaseText(.clauseThreeTitle))\n\(language.purchaseText(.bodyPricePrefix)) \(purchasePrice).",
            "\(language.purchaseText(.clauseFourTitle))\n\(language.purchaseText(.bodyHandoverPrefix)) \(handoverDate).",
            "\(language.purchaseText(.clauseFiveTitle))\n\(language.purchaseText(.bodyConditionPrefix)) \(conditionText).",
            "\(language.purchaseText(.clauseSixTitle))\n\(language.purchaseText(.bodyPaymentPrefix)) \(paymentText).\n\(language.purchaseText(.bodyDefectsPrefix)) \(defectsText)",
            language.purchaseText(.bodyGoodFaith)
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
        <h1>\(language.purchaseText(.title).htmlEscaped)</h1>
        <p>\(bodyText(in: language).htmlEscaped.replacingOccurrences(of: "\n", with: "<br><br>"))</p>
        <div class="signature">
        <p>\(signingPlace.htmlEscaped), \(formattedDate.htmlEscaped)</p>
        <div class="line">\(seller.name.htmlEscaped)</div>
        <div class="line">\(buyer.name.htmlEscaped)</div>
        </div>
        </div>
        </body>
        </html>
        """
    }
}

extension AppLanguage {
    var purchaseChecklist: [String] {
        [
            purchaseText(.bodyItemPrefix),
            purchaseText(.warningCondition).replacingOccurrences(of: ".", with: ""),
            purchaseText(.warningDefects).replacingOccurrences(of: ".", with: "")
        ]
    }

    func purchaseText(_ key: PurchaseLocalizedKey) -> String {
        switch (self, key) {
        case (.norwegian, .title): return "Kjøpskontrakt"
        case (.norwegian, .cardSubtitle): return "Lag en tydelig avtale for privat kjøp og salg med pris, levering og tilstand."
        case (.norwegian, .legalChecklistTitle): return "Det som bør være tydelig i kjøpskontrakten"
        case (.norwegian, .sellerTitle): return "Selger"
        case (.norwegian, .buyerTitle): return "Kjøper"
        case (.norwegian, .agreementTermsTitle): return "Kjøpsvilkår"
        case (.norwegian, .itemField): return "Hva selges?"
        case (.norwegian, .purchasePriceField): return "Kjøpesum"
        case (.norwegian, .handoverDateField): return "Overtakelse / levering"
        case (.norwegian, .conditionField): return "Tilstand og kjente forhold"
        case (.norwegian, .paymentTermsField): return "Betalingsmåte og betalingstidspunkt"
        case (.norwegian, .defectsField): return "Reklamasjon, mangler eller forbehold"
        case (.norwegian, .previewButton): return "Vis kjøpskontrakt"
        case (.norwegian, .blockingSeller): return "Selger må ha navn og adresse."
        case (.norwegian, .blockingBuyer): return "Kjøper må ha navn og adresse."
        case (.norwegian, .blockingItem): return "Det må beskrives hva kjøpet gjelder."
        case (.norwegian, .blockingPrice): return "Kjøpesum må fylles inn."
        case (.norwegian, .blockingHandover): return "Overtakelse eller levering må fylles inn."
        case (.norwegian, .blockingPlace): return "Sted for signering mangler."
        case (.norwegian, .warningCondition): return "Tilstand er ikke beskrevet. Det bør fremgå om gjenstanden selges som den er eller med bestemte opplysninger."
        case (.norwegian, .warningPayment): return "Betalingsmåte er ikke beskrevet. Det bør fremgå hvordan og når betaling skal skje."
        case (.norwegian, .warningDefects): return "Mangler eller reklamasjon er ikke omtalt. Det bør fremgå hvilke forbehold partene tar."
        case (.norwegian, .clauseOneTitle): return "1. Parter"
        case (.norwegian, .clauseTwoTitle): return "2. Salgsobjekt"
        case (.norwegian, .clauseThreeTitle): return "3. Kjøpesum"
        case (.norwegian, .clauseFourTitle): return "4. Levering"
        case (.norwegian, .clauseFiveTitle): return "5. Tilstand"
        case (.norwegian, .clauseSixTitle): return "6. Betaling og forbehold"
        case (.norwegian, .bodyPartiesPrefix): return "Mellom"
        case (.norwegian, .bodyPartiesMiddle): return "og"
        case (.norwegian, .bodyItemPrefix): return "Kjøpet gjelder følgende gjenstand eller ytelse"
        case (.norwegian, .bodyPricePrefix): return "Partene har avtalt en kjøpesum på"
        case (.norwegian, .bodyHandoverPrefix): return "Overtakelse eller levering skal skje"
        case (.norwegian, .bodyConditionPrefix): return "Følgende gjelder om tilstand og opplysninger"
        case (.norwegian, .bodyPaymentPrefix): return "Betaling skal skje slik"
        case (.norwegian, .bodyDefectsPrefix): return "Partene har avtalt følgende om mangler, reklamasjon eller forbehold:"
        case (.norwegian, .bodyGoodFaith): return "Partene bekrefter at opplysningene er gitt i god tro og at avtalen er lest og forstått før signering."
        case (.norwegian, .defaultCondition): return "Objektet overtas i den tilstand det er beskrevet av partene ved signering."
        case (.norwegian, .defaultPayment): return "Betaling skjer ved levering med den betalingsmåten partene blir enige om."
        case (.norwegian, .defaultDefects): return "Partene har ikke tatt inn ytterligere særskilte forbehold."
        case (.english, .title): return "Purchase Agreement"
        case (.english, .cardSubtitle): return "Prepare a clear private sale agreement with price, delivery, and condition terms."
        case (.english, .legalChecklistTitle): return "What should be clear in the purchase agreement"
        case (.english, .sellerTitle): return "Seller"
        case (.english, .buyerTitle): return "Buyer"
        case (.english, .agreementTermsTitle): return "Purchase terms"
        case (.english, .itemField): return "What is being sold?"
        case (.english, .purchasePriceField): return "Purchase price"
        case (.english, .handoverDateField): return "Handover / delivery"
        case (.english, .conditionField): return "Condition and known circumstances"
        case (.english, .paymentTermsField): return "Payment method and due time"
        case (.english, .defectsField): return "Defects, claims, or reservations"
        case (.english, .previewButton): return "Show purchase agreement"
        case (.english, .blockingSeller): return "The seller must have a name and address."
        case (.english, .blockingBuyer): return "The buyer must have a name and address."
        case (.english, .blockingItem): return "The subject of the sale must be described."
        case (.english, .blockingPrice): return "The purchase price must be entered."
        case (.english, .blockingHandover): return "Handover or delivery must be entered."
        case (.english, .blockingPlace): return "The place of signing is missing."
        case (.english, .warningCondition): return "Condition is not described. It should be clear whether the item is sold as-is or with specific disclosures."
        case (.english, .warningPayment): return "Payment terms are not described. It should be clear how and when payment will be made."
        case (.english, .warningDefects): return "Defects or claims are not addressed. It should be clear what reservations the parties make."
        case (.english, .clauseOneTitle): return "1. Parties"
        case (.english, .clauseTwoTitle): return "2. Item"
        case (.english, .clauseThreeTitle): return "3. Purchase price"
        case (.english, .clauseFourTitle): return "4. Delivery"
        case (.english, .clauseFiveTitle): return "5. Condition"
        case (.english, .clauseSixTitle): return "6. Payment and reservations"
        case (.english, .bodyPartiesPrefix): return "Between"
        case (.english, .bodyPartiesMiddle): return "and"
        case (.english, .bodyItemPrefix): return "The sale concerns the following item or performance"
        case (.english, .bodyPricePrefix): return "The parties have agreed on a purchase price of"
        case (.english, .bodyHandoverPrefix): return "Handover or delivery shall take place"
        case (.english, .bodyConditionPrefix): return "The following applies to condition and disclosures"
        case (.english, .bodyPaymentPrefix): return "Payment shall be made as follows"
        case (.english, .bodyDefectsPrefix): return "The parties agree as follows regarding defects, claims, or reservations:"
        case (.english, .bodyGoodFaith): return "The parties confirm that the information has been given in good faith and that the agreement has been read and understood before signing."
        case (.english, .defaultCondition): return "The item is transferred in the condition described by the parties at signing."
        case (.english, .defaultPayment): return "Payment shall be made upon delivery using the method agreed by the parties."
        case (.english, .defaultDefects): return "No additional specific reservations have been included."
        case (.thai, .title): return "สัญญาซื้อขาย"
        case (.thai, .cardSubtitle): return "จัดทำสัญญาซื้อขายส่วนบุคคลที่ชัดเจนพร้อมราคา การส่งมอบ และสภาพทรัพย์สิน"
        case (.thai, .legalChecklistTitle): return "สิ่งที่ควรระบุให้ชัดในสัญญาซื้อขาย"
        case (.thai, .sellerTitle): return "ผู้ขาย"
        case (.thai, .buyerTitle): return "ผู้ซื้อ"
        case (.thai, .agreementTermsTitle): return "เงื่อนไขการซื้อขาย"
        case (.thai, .itemField): return "ขายอะไร"
        case (.thai, .purchasePriceField): return "ราคาซื้อขาย"
        case (.thai, .handoverDateField): return "วันส่งมอบ"
        case (.thai, .conditionField): return "สภาพและข้อมูลที่ทราบ"
        case (.thai, .paymentTermsField): return "วิธีและกำหนดการชำระเงิน"
        case (.thai, .defectsField): return "ตำหนิ การเรียกร้อง หรือข้อสงวน"
        case (.thai, .previewButton): return "แสดงสัญญาซื้อขาย"
        case (.thai, .blockingSeller): return "ผู้ขายต้องมีชื่อและที่อยู่"
        case (.thai, .blockingBuyer): return "ผู้ซื้อต้องมีชื่อและที่อยู่"
        case (.thai, .blockingItem): return "ต้องอธิบายสิ่งที่ซื้อขาย"
        case (.thai, .blockingPrice): return "ต้องกรอกราคาซื้อขาย"
        case (.thai, .blockingHandover): return "ต้องกรอกการส่งมอบ"
        case (.thai, .blockingPlace): return "ยังไม่ได้กรอกสถานที่ลงนาม"
        case (.thai, .warningCondition): return "ยังไม่ได้อธิบายสภาพ ควรระบุให้ชัดว่าขายตามสภาพหรือมีข้อมูลใดประกอบ"
        case (.thai, .warningPayment): return "ยังไม่ได้อธิบายการชำระเงิน ควรระบุให้ชัดว่าชำระอย่างไรและเมื่อใด"
        case (.thai, .warningDefects): return "ยังไม่ได้กล่าวถึงตำหนิหรือข้อสงวน ควรระบุให้ชัดว่าคู่สัญญาตกลงอย่างไร"
        case (.thai, .clauseOneTitle): return "1. คู่สัญญา"
        case (.thai, .clauseTwoTitle): return "2. ทรัพย์สินที่ซื้อขาย"
        case (.thai, .clauseThreeTitle): return "3. ราคาซื้อขาย"
        case (.thai, .clauseFourTitle): return "4. การส่งมอบ"
        case (.thai, .clauseFiveTitle): return "5. สภาพทรัพย์สิน"
        case (.thai, .clauseSixTitle): return "6. การชำระเงินและข้อสงวน"
        case (.thai, .bodyPartiesPrefix): return "ระหว่าง"
        case (.thai, .bodyPartiesMiddle): return "และ"
        case (.thai, .bodyItemPrefix): return "การซื้อขายนี้เกี่ยวกับทรัพย์สินหรือสิ่งต่อไปนี้"
        case (.thai, .bodyPricePrefix): return "คู่สัญญาตกลงราคาซื้อขายไว้ที่"
        case (.thai, .bodyHandoverPrefix): return "การส่งมอบจะเกิดขึ้น"
        case (.thai, .bodyConditionPrefix): return "สภาพและข้อมูลเกี่ยวกับทรัพย์สินมีดังนี้"
        case (.thai, .bodyPaymentPrefix): return "การชำระเงินจะดำเนินการดังนี้"
        case (.thai, .bodyDefectsPrefix): return "คู่สัญญาตกลงเกี่ยวกับตำหนิ การเรียกร้อง หรือข้อสงวนดังนี้:"
        case (.thai, .bodyGoodFaith): return "คู่สัญญายืนยันว่าได้ให้ข้อมูลโดยสุจริตและได้อ่านเข้าใจสัญญานี้ก่อนลงนาม"
        case (.thai, .defaultCondition): return "ทรัพย์สินจะถูกส่งมอบตามสภาพที่คู่สัญญาได้อธิบายไว้ ณ วันลงนาม"
        case (.thai, .defaultPayment): return "ชำระเงินในวันส่งมอบด้วยวิธีที่คู่สัญญาตกลงกัน"
        case (.thai, .defaultDefects): return "ไม่มีข้อสงวนเพิ่มเติมเป็นพิเศษ"
        }
    }
}
