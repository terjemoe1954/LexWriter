//
//  RentalAgreementModels.swift
//  LexWriter
//
//  Created by Codex on 29/08/2026.
//

import Foundation

enum RentalLocalizedKey {
    case title
    case cardSubtitle
    case legalChecklistTitle
    case landlordTitle
    case tenantTitle
    case rentalTermsTitle
    case propertyAddressField
    case rentalObjectField
    case monthlyRentField
    case depositField
    case startDateField
    case durationField
    case utilitiesField
    case noticePeriodField
    case houseRulesField
    case previewButton
    case blockingLandlord
    case blockingTenant
    case blockingProperty
    case blockingRent
    case blockingDeposit
    case blockingPlace
    case warningDuration
    case warningUtilities
    case warningNotice
    case clauseOneTitle
    case clauseTwoTitle
    case clauseThreeTitle
    case clauseFourTitle
    case clauseFiveTitle
    case clauseSixTitle
    case bodyPartiesPrefix
    case bodyPartiesMiddle
    case bodyPropertyPrefix
    case bodyRentPrefix
    case bodyDepositPrefix
    case bodyDurationPrefix
    case bodyUtilitiesPrefix
    case bodyNoticePrefix
    case bodyRulesPrefix
    case bodyCompliance
    case defaultDuration
    case defaultUtilities
    case defaultNotice
    case defaultRules
}

struct RentalParty: Equatable {
    var name = ""
    var address = ""
    var phone = ""
    var email = ""
}

struct RentalAgreementFormData {
    var landlord = RentalParty()
    var tenant = RentalParty()
    var propertyAddress = ""
    var rentalObjectDescription = ""
    var monthlyRent = ""
    var deposit = ""
    var startDate = ""
    var duration = ""
    var utilities = ""
    var noticePeriod = ""
    var houseRules = ""
    var signingPlace = ""
    var signingDate = Date()

    func blockingIssues(in language: AppLanguage) -> [ValidationMessage] {
        var messages: [ValidationMessage] = []

        if landlord.name.trimmed.isEmpty || landlord.address.trimmed.isEmpty {
            messages.append(.init(severity: .blocking, message: language.rentalText(.blockingLandlord)))
        }

        if tenant.name.trimmed.isEmpty || tenant.address.trimmed.isEmpty {
            messages.append(.init(severity: .blocking, message: language.rentalText(.blockingTenant)))
        }

        if propertyAddress.trimmed.isEmpty || rentalObjectDescription.trimmed.isEmpty {
            messages.append(.init(severity: .blocking, message: language.rentalText(.blockingProperty)))
        }

        if monthlyRent.trimmed.isEmpty {
            messages.append(.init(severity: .blocking, message: language.rentalText(.blockingRent)))
        }

        if deposit.trimmed.isEmpty {
            messages.append(.init(severity: .blocking, message: language.rentalText(.blockingDeposit)))
        }

        if signingPlace.trimmed.isEmpty {
            messages.append(.init(severity: .blocking, message: language.rentalText(.blockingPlace)))
        }

        return messages
    }

    func warnings(in language: AppLanguage) -> [ValidationMessage] {
        var messages: [ValidationMessage] = []

        if duration.trimmed.isEmpty {
            messages.append(.init(severity: .warning, message: language.rentalText(.warningDuration)))
        }

        if utilities.trimmed.isEmpty {
            messages.append(.init(severity: .warning, message: language.rentalText(.warningUtilities)))
        }

        if noticePeriod.trimmed.isEmpty {
            messages.append(.init(severity: .warning, message: language.rentalText(.warningNotice)))
        }

        return messages
    }

    var document: RentalAgreementDocument {
        RentalAgreementDocument(
            landlord: landlord,
            tenant: tenant,
            propertyAddress: propertyAddress.trimmed,
            rentalObjectDescription: rentalObjectDescription.trimmed,
            monthlyRent: monthlyRent.trimmed,
            deposit: deposit.trimmed,
            startDate: startDate.trimmed,
            duration: duration.trimmed,
            utilities: utilities.trimmed,
            noticePeriod: noticePeriod.trimmed,
            houseRules: houseRules.trimmed,
            signingPlace: signingPlace.trimmed,
            signingDate: signingDate
        )
    }
}

struct RentalAgreementDocument {
    let landlord: RentalParty
    let tenant: RentalParty
    let propertyAddress: String
    let rentalObjectDescription: String
    let monthlyRent: String
    let deposit: String
    let startDate: String
    let duration: String
    let utilities: String
    let noticePeriod: String
    let houseRules: String
    let signingPlace: String
    let signingDate: Date

    var formattedDate: String {
        signingDate.formatted(date: .long, time: .omitted)
    }

    func bodyText(in language: AppLanguage) -> String {
        let durationText = duration.isEmpty ? language.rentalText(.defaultDuration) : duration
        let utilitiesText = utilities.isEmpty ? language.rentalText(.defaultUtilities) : utilities
        let noticeText = noticePeriod.isEmpty ? language.rentalText(.defaultNotice) : noticePeriod
        let rulesText = houseRules.isEmpty ? language.rentalText(.defaultRules) : houseRules
        let commencement = startDate.isEmpty ? formattedDate : startDate

        return [
            "\(language.rentalText(.clauseOneTitle))\n\(language.rentalText(.bodyPartiesPrefix)) \(landlord.name.trimmed), \(landlord.address.trimmed), \(language.rentalText(.bodyPartiesMiddle)) \(tenant.name.trimmed), \(tenant.address.trimmed).",
            "\(language.rentalText(.clauseTwoTitle))\n\(language.rentalText(.bodyPropertyPrefix)) \(propertyAddress). \(rentalObjectDescription).",
            "\(language.rentalText(.clauseThreeTitle))\n\(language.rentalText(.bodyRentPrefix)) \(monthlyRent).",
            "\(language.rentalText(.clauseFourTitle))\n\(language.rentalText(.bodyDepositPrefix)) \(deposit).",
            "\(language.rentalText(.clauseFiveTitle))\n\(language.rentalText(.bodyDurationPrefix)) \(commencement), \(durationText).",
            "\(language.rentalText(.clauseSixTitle))\n\(language.rentalText(.bodyUtilitiesPrefix)) \(utilitiesText).\n\(language.rentalText(.bodyNoticePrefix)) \(noticeText).\n\(language.rentalText(.bodyRulesPrefix)) \(rulesText)",
            language.rentalText(.bodyCompliance)
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
        <h1>\(language.rentalText(.title).htmlEscaped)</h1>
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
    var rentalChecklist: [String] {
        [
            rentalText(.bodyPropertyPrefix),
            rentalText(.warningUtilities).replacingOccurrences(of: ".", with: ""),
            rentalText(.warningNotice).replacingOccurrences(of: ".", with: "")
        ]
    }

    func rentalText(_ key: RentalLocalizedKey) -> String {
        switch (self, key) {
        case (.norwegian, .title):
            return "Husleiekontrakt"
        case (.norwegian, .cardSubtitle):
            return "Lag en ryddig leieavtale med utleier, leietaker, depositum og vilkår."
        case (.norwegian, .legalChecklistTitle):
            return "Det som bør være tydelig i husleiekontrakten"
        case (.norwegian, .landlordTitle):
            return "Utleier"
        case (.norwegian, .tenantTitle):
            return "Leietaker"
        case (.norwegian, .rentalTermsTitle):
            return "Leieforhold"
        case (.norwegian, .propertyAddressField):
            return "Adresse til boligen"
        case (.norwegian, .rentalObjectField):
            return "Hva leies ut?"
        case (.norwegian, .monthlyRentField):
            return "Månedlig husleie"
        case (.norwegian, .depositField):
            return "Depositum"
        case (.norwegian, .startDateField):
            return "Innflytting / oppstart"
        case (.norwegian, .durationField):
            return "Varighet eller om avtalen er tidsubestemt"
        case (.norwegian, .utilitiesField):
            return "Hva er inkludert i husleien?"
        case (.norwegian, .noticePeriodField):
            return "Oppsigelsestid"
        case (.norwegian, .houseRulesField):
            return "Ordensregler, dyr, røyking eller særlige vilkår"
        case (.norwegian, .previewButton):
            return "Vis husleiekontrakt"
        case (.norwegian, .blockingLandlord):
            return "Utleier må ha navn og adresse."
        case (.norwegian, .blockingTenant):
            return "Leietaker må ha navn og adresse."
        case (.norwegian, .blockingProperty):
            return "Boligens adresse og hva som leies ut må beskrives."
        case (.norwegian, .blockingRent):
            return "Husleie må fylles inn."
        case (.norwegian, .blockingDeposit):
            return "Depositum må fylles inn eller beskrives som ikke aktuelt."
        case (.norwegian, .blockingPlace):
            return "Sted for signering mangler."
        case (.norwegian, .warningDuration):
            return "Varighet er ikke fylt inn. Det bør være klart om avtalen er tidsbestemt eller tidsubestemt."
        case (.norwegian, .warningUtilities):
            return "Det er ikke oppgitt hva som er inkludert i husleien. Strøm, internett og andre kostnader bør avklares."
        case (.norwegian, .warningNotice):
            return "Oppsigelsestid er ikke fylt inn. Avtalen bør tydelig regulere hvordan oppsigelse skjer."
        case (.norwegian, .clauseOneTitle):
            return "1. Parter"
        case (.norwegian, .clauseTwoTitle):
            return "2. Leieobjekt"
        case (.norwegian, .clauseThreeTitle):
            return "3. Husleie"
        case (.norwegian, .clauseFourTitle):
            return "4. Depositum"
        case (.norwegian, .clauseFiveTitle):
            return "5. Oppstart og varighet"
        case (.norwegian, .clauseSixTitle):
            return "6. Løpende vilkår"
        case (.norwegian, .bodyPartiesPrefix):
            return "Mellom"
        case (.norwegian, .bodyPartiesMiddle):
            return "og"
        case (.norwegian, .bodyPropertyPrefix):
            return "Leieforholdet gjelder følgende bolig eller del av bolig:"
        case (.norwegian, .bodyRentPrefix):
            return "Månedlig husleie er avtalt til"
        case (.norwegian, .bodyDepositPrefix):
            return "Depositum er avtalt til"
        case (.norwegian, .bodyDurationPrefix):
            return "Leieforholdet starter"
        case (.norwegian, .bodyUtilitiesPrefix):
            return "Følgende ytelser eller kostnader er inkludert i husleien:"
        case (.norwegian, .bodyNoticePrefix):
            return "Oppsigelse og oppsigelsestid:"
        case (.norwegian, .bodyRulesPrefix):
            return "Særlige regler og forbehold:"
        case (.norwegian, .bodyCompliance):
            return "Partene er innforstått med at ufravikelige regler i husleieloven går foran avtalevilkår som stiller leietaker dårligere enn loven tillater."
        case (.norwegian, .defaultDuration):
            return "avtalen løper inntil den sies opp i samsvar med lov og avtale"
        case (.norwegian, .defaultUtilities):
            return "Ingen tillegg er spesifisert."
        case (.norwegian, .defaultNotice):
            return "Oppsigelse skal skje skriftlig med lovens eller avtalens varsel."
        case (.norwegian, .defaultRules):
            return "Ingen særlige regler er skrevet inn."
        case (.english, .title):
            return "Rental Agreement"
        case (.english, .cardSubtitle):
            return "Prepare a clear lease with landlord, tenant, deposit, and key terms."
        case (.english, .legalChecklistTitle):
            return "What should be clear in the rental agreement"
        case (.english, .landlordTitle):
            return "Landlord"
        case (.english, .tenantTitle):
            return "Tenant"
        case (.english, .rentalTermsTitle):
            return "Tenancy terms"
        case (.english, .propertyAddressField):
            return "Address of the property"
        case (.english, .rentalObjectField):
            return "What is being rented?"
        case (.english, .monthlyRentField):
            return "Monthly rent"
        case (.english, .depositField):
            return "Deposit"
        case (.english, .startDateField):
            return "Move-in / commencement"
        case (.english, .durationField):
            return "Duration or whether the lease is open-ended"
        case (.english, .utilitiesField):
            return "What is included in the rent?"
        case (.english, .noticePeriodField):
            return "Notice period"
        case (.english, .houseRulesField):
            return "House rules, pets, smoking, or special terms"
        case (.english, .previewButton):
            return "Show rental agreement"
        case (.english, .blockingLandlord):
            return "The landlord must have a name and address."
        case (.english, .blockingTenant):
            return "The tenant must have a name and address."
        case (.english, .blockingProperty):
            return "The property address and rented premises must be described."
        case (.english, .blockingRent):
            return "Rent must be entered."
        case (.english, .blockingDeposit):
            return "Deposit must be entered or stated as not applicable."
        case (.english, .blockingPlace):
            return "The place of signing is missing."
        case (.english, .warningDuration):
            return "Duration is not filled in. It should be clear whether the lease is fixed-term or open-ended."
        case (.english, .warningUtilities):
            return "It is not stated what is included in the rent. Electricity, internet, and other costs should be clarified."
        case (.english, .warningNotice):
            return "The notice period is not filled in. The agreement should clearly regulate termination."
        case (.english, .clauseOneTitle):
            return "1. Parties"
        case (.english, .clauseTwoTitle):
            return "2. Rented premises"
        case (.english, .clauseThreeTitle):
            return "3. Rent"
        case (.english, .clauseFourTitle):
            return "4. Deposit"
        case (.english, .clauseFiveTitle):
            return "5. Commencement and duration"
        case (.english, .clauseSixTitle):
            return "6. Ongoing terms"
        case (.english, .bodyPartiesPrefix):
            return "Between"
        case (.english, .bodyPartiesMiddle):
            return "and"
        case (.english, .bodyPropertyPrefix):
            return "The tenancy concerns the following dwelling or part of a dwelling:"
        case (.english, .bodyRentPrefix):
            return "Monthly rent is agreed as"
        case (.english, .bodyDepositPrefix):
            return "The deposit is agreed as"
        case (.english, .bodyDurationPrefix):
            return "The tenancy starts"
        case (.english, .bodyUtilitiesPrefix):
            return "The following services or costs are included in the rent:"
        case (.english, .bodyNoticePrefix):
            return "Termination and notice period:"
        case (.english, .bodyRulesPrefix):
            return "Special rules and reservations:"
        case (.english, .bodyCompliance):
            return "The parties acknowledge that mandatory rules of the Norwegian Tenancy Act prevail over terms that place the tenant in a worse position than the law permits."
        case (.english, .defaultDuration):
            return "and continues until terminated in accordance with law and agreement"
        case (.english, .defaultUtilities):
            return "No additional inclusions are specified."
        case (.english, .defaultNotice):
            return "Termination shall be given in writing with the notice required by law or agreement."
        case (.english, .defaultRules):
            return "No special rules have been written in."
        case (.thai, .title):
            return "สัญญาเช่า"
        case (.thai, .cardSubtitle):
            return "จัดทำสัญญาเช่าที่ชัดเจนพร้อมผู้ให้เช่า ผู้เช่า เงินประกัน และเงื่อนไขสำคัญ"
        case (.thai, .legalChecklistTitle):
            return "สิ่งที่ควรระบุให้ชัดในสัญญาเช่า"
        case (.thai, .landlordTitle):
            return "ผู้ให้เช่า"
        case (.thai, .tenantTitle):
            return "ผู้เช่า"
        case (.thai, .rentalTermsTitle):
            return "เงื่อนไขการเช่า"
        case (.thai, .propertyAddressField):
            return "ที่อยู่ของทรัพย์สิน"
        case (.thai, .rentalObjectField):
            return "ให้เช่าอะไร"
        case (.thai, .monthlyRentField):
            return "ค่าเช่ารายเดือน"
        case (.thai, .depositField):
            return "เงินประกัน"
        case (.thai, .startDateField):
            return "วันเข้าอยู่ / วันเริ่มต้น"
        case (.thai, .durationField):
            return "ระยะเวลาหรือระบุว่าเป็นสัญญาไม่มีกำหนด"
        case (.thai, .utilitiesField):
            return "ค่าใช้จ่ายใดรวมอยู่ในค่าเช่า"
        case (.thai, .noticePeriodField):
            return "ระยะเวลาบอกเลิก"
        case (.thai, .houseRulesField):
            return "กฎบ้าน สัตว์เลี้ยง การสูบบุหรี่ หรือเงื่อนไขพิเศษ"
        case (.thai, .previewButton):
            return "แสดงสัญญาเช่า"
        case (.thai, .blockingLandlord):
            return "ผู้ให้เช่าต้องมีชื่อและที่อยู่"
        case (.thai, .blockingTenant):
            return "ผู้เช่าต้องมีชื่อและที่อยู่"
        case (.thai, .blockingProperty):
            return "ต้องระบุที่อยู่ของทรัพย์สินและรายละเอียดสิ่งที่ให้เช่า"
        case (.thai, .blockingRent):
            return "ต้องกรอกค่าเช่า"
        case (.thai, .blockingDeposit):
            return "ต้องกรอกเงินประกันหรือระบุว่าไม่ใช้"
        case (.thai, .blockingPlace):
            return "ยังไม่ได้กรอกสถานที่ลงนาม"
        case (.thai, .warningDuration):
            return "ยังไม่ได้กรอกระยะเวลา ควรระบุให้ชัดว่าเป็นสัญญามีกำหนดหรือไม่มีกำหนด"
        case (.thai, .warningUtilities):
            return "ยังไม่ได้ระบุสิ่งที่รวมอยู่ในค่าเช่า ควรชี้แจงเรื่องไฟฟ้า อินเทอร์เน็ต และค่าใช้จ่ายอื่น"
        case (.thai, .warningNotice):
            return "ยังไม่ได้กรอกระยะเวลาบอกเลิก สัญญาควรระบุวิธีสิ้นสุดให้ชัด"
        case (.thai, .clauseOneTitle):
            return "1. คู่สัญญา"
        case (.thai, .clauseTwoTitle):
            return "2. ทรัพย์สินที่เช่า"
        case (.thai, .clauseThreeTitle):
            return "3. ค่าเช่า"
        case (.thai, .clauseFourTitle):
            return "4. เงินประกัน"
        case (.thai, .clauseFiveTitle):
            return "5. วันเริ่มต้นและระยะเวลา"
        case (.thai, .clauseSixTitle):
            return "6. เงื่อนไขต่อเนื่อง"
        case (.thai, .bodyPartiesPrefix):
            return "ระหว่าง"
        case (.thai, .bodyPartiesMiddle):
            return "และ"
        case (.thai, .bodyPropertyPrefix):
            return "การเช่านี้เกี่ยวกับที่อยู่อาศัยหรือส่วนของที่อยู่อาศัยดังต่อไปนี้:"
        case (.thai, .bodyRentPrefix):
            return "ตกลงค่าเช่ารายเดือนเป็น"
        case (.thai, .bodyDepositPrefix):
            return "ตกลงเงินประกันเป็น"
        case (.thai, .bodyDurationPrefix):
            return "การเช่าเริ่มต้น"
        case (.thai, .bodyUtilitiesPrefix):
            return "ค่าใช้จ่ายหรือบริการที่รวมอยู่ในค่าเช่ามีดังนี้:"
        case (.thai, .bodyNoticePrefix):
            return "การบอกเลิกและระยะเวลาบอกเลิก:"
        case (.thai, .bodyRulesPrefix):
            return "กฎพิเศษและข้อสงวน:"
        case (.thai, .bodyCompliance):
            return "คู่สัญญารับทราบว่ากฎบังคับของกฎหมายการเช่าของนอร์เวย์มีผลเหนือข้อสัญญาที่ทำให้ผู้เช่าเสียเปรียบเกินกว่าที่กฎหมายอนุญาต"
        case (.thai, .defaultDuration):
            return "และมีผลต่อไปจนกว่าจะมีการยกเลิกตามกฎหมายและสัญญา"
        case (.thai, .defaultUtilities):
            return "ไม่ได้ระบุสิ่งที่รวมเพิ่มเติม"
        case (.thai, .defaultNotice):
            return "การบอกเลิกต้องทำเป็นลายลักษณ์อักษรตามระยะเวลาที่กฎหมายหรือสัญญากำหนด"
        case (.thai, .defaultRules):
            return "ไม่ได้ระบุกฎพิเศษไว้"
        }
    }
}
