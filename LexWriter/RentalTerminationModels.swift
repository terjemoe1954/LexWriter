//
//  RentalTerminationModels.swift
//  LexWriter
//
//  Created by Codex on 03/09/2026.
//

import Foundation

enum RentalTerminationLocalizedKey {
    case title
    case cardSubtitle
    case legalChecklistTitle
    case landlordTitle
    case tenantTitle
    case terminationTermsTitle
    case propertyField
    case terminationDateField
    case moveOutDateField
    case noticeBasisField
    case depositSettlementField
    case keyReturnField
    case previewButton
    case blockingLandlord
    case blockingTenant
    case blockingProperty
    case blockingTerminationDate
    case blockingNoticeBasis
    case blockingPlace
    case warningMoveOut
    case warningDeposit
    case warningKeyReturn
    case clauseOneTitle
    case clauseTwoTitle
    case clauseThreeTitle
    case clauseFourTitle
    case clauseFiveTitle
    case bodyPartiesPrefix
    case bodyPartiesMiddle
    case bodyPropertyPrefix
    case bodyTerminationPrefix
    case bodyMoveOutPrefix
    case bodyDepositPrefix
    case bodyKeyReturnPrefix
    case bodyGoodFaith
    case defaultMoveOut
    case defaultDeposit
    case defaultKeyReturn
}

struct RentalTerminationFormData {
    var landlord = RentalParty()
    var tenant = RentalParty()
    var propertyAddress = ""
    var terminationDateText = ""
    var moveOutDateText = ""
    var noticeBasis = ""
    var depositSettlement = ""
    var keyReturn = ""
    var signingPlace = ""
    var signingDate = Date()

    func blockingIssues(in language: AppLanguage) -> [ValidationMessage] {
        var messages: [ValidationMessage] = []
        if landlord.name.trimmed.isEmpty || landlord.address.trimmed.isEmpty {
            messages.append(.init(severity: .blocking, message: language.rentalTerminationText(.blockingLandlord)))
        }
        if tenant.name.trimmed.isEmpty || tenant.address.trimmed.isEmpty {
            messages.append(.init(severity: .blocking, message: language.rentalTerminationText(.blockingTenant)))
        }
        if propertyAddress.trimmed.isEmpty {
            messages.append(.init(severity: .blocking, message: language.rentalTerminationText(.blockingProperty)))
        }
        if terminationDateText.trimmed.isEmpty {
            messages.append(.init(severity: .blocking, message: language.rentalTerminationText(.blockingTerminationDate)))
        }
        if noticeBasis.trimmed.isEmpty {
            messages.append(.init(severity: .blocking, message: language.rentalTerminationText(.blockingNoticeBasis)))
        }
        if signingPlace.trimmed.isEmpty {
            messages.append(.init(severity: .blocking, message: language.rentalTerminationText(.blockingPlace)))
        }
        return messages
    }

    func warnings(in language: AppLanguage) -> [ValidationMessage] {
        var messages: [ValidationMessage] = []
        if moveOutDateText.trimmed.isEmpty {
            messages.append(.init(severity: .warning, message: language.rentalTerminationText(.warningMoveOut)))
        }
        if depositSettlement.trimmed.isEmpty {
            messages.append(.init(severity: .warning, message: language.rentalTerminationText(.warningDeposit)))
        }
        if keyReturn.trimmed.isEmpty {
            messages.append(.init(severity: .warning, message: language.rentalTerminationText(.warningKeyReturn)))
        }
        return messages
    }

    var document: RentalTerminationDocument {
        RentalTerminationDocument(
            landlord: landlord,
            tenant: tenant,
            propertyAddress: propertyAddress.trimmed,
            terminationDateText: terminationDateText.trimmed,
            moveOutDateText: moveOutDateText.trimmed,
            noticeBasis: noticeBasis.trimmed,
            depositSettlement: depositSettlement.trimmed,
            keyReturn: keyReturn.trimmed,
            signingPlace: signingPlace.trimmed,
            signingDate: signingDate
        )
    }
}

struct RentalTerminationDocument {
    let landlord: RentalParty
    let tenant: RentalParty
    let propertyAddress: String
    let terminationDateText: String
    let moveOutDateText: String
    let noticeBasis: String
    let depositSettlement: String
    let keyReturn: String
    let signingPlace: String
    let signingDate: Date

    var formattedDate: String {
        signingDate.formatted(date: .long, time: .omitted)
    }

    func bodyText(in language: AppLanguage) -> String {
        let moveOutText = moveOutDateText.isEmpty ? language.rentalTerminationText(.defaultMoveOut) : moveOutDateText
        let depositText = depositSettlement.isEmpty ? language.rentalTerminationText(.defaultDeposit) : depositSettlement
        let keyReturnText = keyReturn.isEmpty ? language.rentalTerminationText(.defaultKeyReturn) : keyReturn

        return [
            "\(language.rentalTerminationText(.clauseOneTitle))\n\(language.rentalTerminationText(.bodyPartiesPrefix)) \(landlord.name.trimmed), \(landlord.address.trimmed), \(language.rentalTerminationText(.bodyPartiesMiddle)) \(tenant.name.trimmed), \(tenant.address.trimmed).",
            "\(language.rentalTerminationText(.clauseTwoTitle))\n\(language.rentalTerminationText(.bodyPropertyPrefix)) \(propertyAddress).",
            "\(language.rentalTerminationText(.clauseThreeTitle))\n\(language.rentalTerminationText(.bodyTerminationPrefix)) \(terminationDateText). \(noticeBasis)",
            "\(language.rentalTerminationText(.clauseFourTitle))\n\(language.rentalTerminationText(.bodyMoveOutPrefix)) \(moveOutText).",
            "\(language.rentalTerminationText(.clauseFiveTitle))\n\(language.rentalTerminationText(.bodyDepositPrefix)) \(depositText).\n\(language.rentalTerminationText(.bodyKeyReturnPrefix)) \(keyReturnText)",
            language.rentalTerminationText(.bodyGoodFaith)
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
        <h1>\(language.rentalTerminationText(.title).htmlEscaped)</h1>
        <p>\(bodyText(in: language).htmlEscaped.replacingOccurrences(of: "\n", with: "<br><br>"))</p>
        <div class="signature">
        <p>\(signingPlace.htmlEscaped), \(formattedDate.htmlEscaped)</p>
        <div class="line">\(landlord.name.htmlEscaped)</div>
        <div class="line">\(tenant.name.htmlEscaped)</div>
        </div>
        </div>
        </body>
        </html>
        """
    }
}

extension AppLanguage {
    var rentalTerminationChecklist: [String] {
        [
            rentalTerminationText(.bodyPropertyPrefix),
            rentalTerminationText(.warningDeposit).replacingOccurrences(of: ".", with: ""),
            rentalTerminationText(.warningKeyReturn).replacingOccurrences(of: ".", with: "")
        ]
    }

    func rentalTerminationText(_ key: RentalTerminationLocalizedKey) -> String {
        switch (self, key) {
        case (.norwegian, .title): return "Oppsigelse av leieforhold"
        case (.norwegian, .cardSubtitle): return "Lag en skriftlig oppsigelse med datoer, bolig, tilbakelevering og oppgjør."
        case (.norwegian, .legalChecklistTitle): return "Det som bør være tydelig i oppsigelsen"
        case (.norwegian, .landlordTitle): return "Utleier"
        case (.norwegian, .tenantTitle): return "Leietaker"
        case (.norwegian, .terminationTermsTitle): return "Oppsigelsesdetaljer"
        case (.norwegian, .propertyField): return "Hvilket leieforhold gjelder oppsigelsen?"
        case (.norwegian, .terminationDateField): return "Dato for oppsigelse"
        case (.norwegian, .moveOutDateField): return "Utflyttingsdato"
        case (.norwegian, .noticeBasisField): return "Grunnlag eller oppsigelsestid"
        case (.norwegian, .depositSettlementField): return "Oppgjør av depositum"
        case (.norwegian, .keyReturnField): return "Nøkler, overtakelse og tilbakelevering"
        case (.norwegian, .previewButton): return "Vis oppsigelse"
        case (.norwegian, .blockingLandlord): return "Utleier må ha navn og adresse."
        case (.norwegian, .blockingTenant): return "Leietaker må ha navn og adresse."
        case (.norwegian, .blockingProperty): return "Leieforholdet eller adressen må beskrives."
        case (.norwegian, .blockingTerminationDate): return "Dato for oppsigelse må fylles inn."
        case (.norwegian, .blockingNoticeBasis): return "Oppsigelsestid eller grunnlag må beskrives."
        case (.norwegian, .blockingPlace): return "Sted for signering mangler."
        case (.norwegian, .warningMoveOut): return "Utflyttingsdato er ikke fylt inn. Det bør fremgå når leieforholdet faktisk opphører."
        case (.norwegian, .warningDeposit): return "Oppgjør av depositum er ikke beskrevet. Det bør fremgå hvordan sluttoppgjøret skal håndteres."
        case (.norwegian, .warningKeyReturn): return "Tilbakelevering av nøkler eller bolig er ikke beskrevet. Det bør fremgå hvordan overlevering skal skje."
        case (.norwegian, .clauseOneTitle): return "1. Parter"
        case (.norwegian, .clauseTwoTitle): return "2. Leieforhold"
        case (.norwegian, .clauseThreeTitle): return "3. Oppsigelse"
        case (.norwegian, .clauseFourTitle): return "4. Utflytting"
        case (.norwegian, .clauseFiveTitle): return "5. Oppgjør og tilbakelevering"
        case (.norwegian, .bodyPartiesPrefix): return "Mellom"
        case (.norwegian, .bodyPartiesMiddle): return "og"
        case (.norwegian, .bodyPropertyPrefix): return "Oppsigelsen gjelder følgende leieforhold"
        case (.norwegian, .bodyTerminationPrefix): return "Leieforholdet sies opp med virkning fra"
        case (.norwegian, .bodyMoveOutPrefix): return "Utflytting og avslutning skal skje"
        case (.norwegian, .bodyDepositPrefix): return "Partene legger til grunn følgende om depositum eller økonomisk oppgjør"
        case (.norwegian, .bodyKeyReturnPrefix): return "Følgende gjelder for nøkler, tilbakelevering og eventuell gjennomgang:"
        case (.norwegian, .bodyGoodFaith): return "Partene bekrefter at oppsigelsen er lest og forstått og at den brukes som skriftlig dokumentasjon for avslutningen av leieforholdet."
        case (.norwegian, .defaultMoveOut): return "ved utløpet av oppsigelsestiden slik partene har oppgitt"
        case (.norwegian, .defaultDeposit): return "Depositum og økonomisk oppgjør behandles etter en gjennomgang av boligen."
        case (.norwegian, .defaultKeyReturn): return "Nøkler og bolig tilbakeleveres etter nærmere avtale mellom partene."
        case (.english, .title): return "Termination of Tenancy"
        case (.english, .cardSubtitle): return "Prepare a written tenancy termination with dates, property details, return, and settlement."
        case (.english, .legalChecklistTitle): return "What should be clear in the termination notice"
        case (.english, .landlordTitle): return "Landlord"
        case (.english, .tenantTitle): return "Tenant"
        case (.english, .terminationTermsTitle): return "Termination details"
        case (.english, .propertyField): return "Which tenancy does the notice concern?"
        case (.english, .terminationDateField): return "Date of termination"
        case (.english, .moveOutDateField): return "Move-out date"
        case (.english, .noticeBasisField): return "Notice basis or notice period"
        case (.english, .depositSettlementField): return "Deposit settlement"
        case (.english, .keyReturnField): return "Keys, handover, and return"
        case (.english, .previewButton): return "Show termination notice"
        case (.english, .blockingLandlord): return "The landlord must have a name and address."
        case (.english, .blockingTenant): return "The tenant must have a name and address."
        case (.english, .blockingProperty): return "The tenancy or property address must be described."
        case (.english, .blockingTerminationDate): return "The date of termination must be entered."
        case (.english, .blockingNoticeBasis): return "The notice period or basis must be described."
        case (.english, .blockingPlace): return "The place of signing is missing."
        case (.english, .warningMoveOut): return "The move-out date is not entered. It should be clear when the tenancy actually ends."
        case (.english, .warningDeposit): return "Deposit settlement is not described. It should be clear how the final financial settlement will be handled."
        case (.english, .warningKeyReturn): return "Return of keys or premises is not described. It should be clear how handover will take place."
        case (.english, .clauseOneTitle): return "1. Parties"
        case (.english, .clauseTwoTitle): return "2. Tenancy"
        case (.english, .clauseThreeTitle): return "3. Termination"
        case (.english, .clauseFourTitle): return "4. Move-out"
        case (.english, .clauseFiveTitle): return "5. Settlement and return"
        case (.english, .bodyPartiesPrefix): return "Between"
        case (.english, .bodyPartiesMiddle): return "and"
        case (.english, .bodyPropertyPrefix): return "The notice concerns the following tenancy"
        case (.english, .bodyTerminationPrefix): return "The tenancy is terminated effective"
        case (.english, .bodyMoveOutPrefix): return "Move-out and closing shall take place"
        case (.english, .bodyDepositPrefix): return "The parties apply the following regarding the deposit or financial settlement"
        case (.english, .bodyKeyReturnPrefix): return "The following applies to keys, return, and any inspection:"
        case (.english, .bodyGoodFaith): return "The parties confirm that the notice has been read and understood and is used as written documentation for ending the tenancy."
        case (.english, .defaultMoveOut): return "at the end of the stated notice period"
        case (.english, .defaultDeposit): return "The deposit and final settlement will be handled after inspection of the premises."
        case (.english, .defaultKeyReturn): return "Keys and premises will be returned as agreed between the parties."
        case (.thai, .title): return "หนังสือบอกเลิกสัญญาเช่า"
        case (.thai, .cardSubtitle): return "จัดทำหนังสือบอกเลิกสัญญาเช่าพร้อมวันที่ รายละเอียดทรัพย์สิน การคืนห้อง และการชำระบัญชี"
        case (.thai, .legalChecklistTitle): return "สิ่งที่ควรระบุให้ชัดในหนังสือบอกเลิกสัญญาเช่า"
        case (.thai, .landlordTitle): return "ผู้ให้เช่า"
        case (.thai, .tenantTitle): return "ผู้เช่า"
        case (.thai, .terminationTermsTitle): return "รายละเอียดการบอกเลิก"
        case (.thai, .propertyField): return "หนังสือบอกเลิกนี้เกี่ยวกับการเช่าใด"
        case (.thai, .terminationDateField): return "วันที่บอกเลิก"
        case (.thai, .moveOutDateField): return "วันที่ย้ายออก"
        case (.thai, .noticeBasisField): return "เหตุหรือระยะเวลาการบอกกล่าว"
        case (.thai, .depositSettlementField): return "การชำระบัญชีเงินประกัน"
        case (.thai, .keyReturnField): return "การคืนกุญแจและการส่งมอบ"
        case (.thai, .previewButton): return "แสดงหนังสือบอกเลิก"
        case (.thai, .blockingLandlord): return "ผู้ให้เช่าต้องมีชื่อและที่อยู่"
        case (.thai, .blockingTenant): return "ผู้เช่าต้องมีชื่อและที่อยู่"
        case (.thai, .blockingProperty): return "ต้องอธิบายทรัพย์สินหรือการเช่าที่เกี่ยวข้อง"
        case (.thai, .blockingTerminationDate): return "ต้องกรอกวันที่บอกเลิก"
        case (.thai, .blockingNoticeBasis): return "ต้องอธิบายเหตุหรือระยะเวลาการบอกกล่าว"
        case (.thai, .blockingPlace): return "ยังไม่ได้กรอกสถานที่ลงนาม"
        case (.thai, .warningMoveOut): return "ยังไม่ได้กรอกวันที่ย้ายออก ควรระบุให้ชัดว่าการเช่าสิ้นสุดเมื่อใด"
        case (.thai, .warningDeposit): return "ยังไม่ได้อธิบายการชำระบัญชีเงินประกัน ควรระบุให้ชัดว่าจะจัดการอย่างไร"
        case (.thai, .warningKeyReturn): return "ยังไม่ได้อธิบายการคืนกุญแจหรือสถานที่เช่า ควรระบุวิธีการส่งมอบให้ชัด"
        case (.thai, .clauseOneTitle): return "1. คู่สัญญา"
        case (.thai, .clauseTwoTitle): return "2. การเช่า"
        case (.thai, .clauseThreeTitle): return "3. การบอกเลิก"
        case (.thai, .clauseFourTitle): return "4. การย้ายออก"
        case (.thai, .clauseFiveTitle): return "5. การชำระบัญชีและการคืนทรัพย์"
        case (.thai, .bodyPartiesPrefix): return "ระหว่าง"
        case (.thai, .bodyPartiesMiddle): return "และ"
        case (.thai, .bodyPropertyPrefix): return "หนังสือฉบับนี้เกี่ยวกับการเช่าดังต่อไปนี้"
        case (.thai, .bodyTerminationPrefix): return "การเช่าถูกบอกเลิกโดยมีผลตั้งแต่"
        case (.thai, .bodyMoveOutPrefix): return "การย้ายออกและการสิ้นสุดสัญญาจะเกิดขึ้น"
        case (.thai, .bodyDepositPrefix): return "คู่สัญญาตกลงเกี่ยวกับเงินประกันหรือการชำระบัญชีดังนี้"
        case (.thai, .bodyKeyReturnPrefix): return "การคืนกุญแจ การส่งมอบ และการตรวจรับมีดังนี้:"
        case (.thai, .bodyGoodFaith): return "คู่สัญญายืนยันว่าได้อ่านและเข้าใจหนังสือฉบับนี้และใช้เป็นหลักฐานเป็นลายลักษณ์อักษรสำหรับการสิ้นสุดการเช่า"
        case (.thai, .defaultMoveOut): return "เมื่อครบกำหนดบอกกล่าวตามที่ระบุไว้"
        case (.thai, .defaultDeposit): return "เงินประกันและการชำระบัญชีสุดท้ายจะดำเนินการหลังตรวจรับสถานที่"
        case (.thai, .defaultKeyReturn): return "การคืนกุญแจและสถานที่เช่าจะเป็นไปตามที่คู่สัญญาตกลงกัน"
        }
    }
}
