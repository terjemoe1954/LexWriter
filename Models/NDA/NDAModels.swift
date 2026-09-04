//
//  NDAModels.swift
//  LexWriter
//
//  Created by Codex on 03/09/2026.
//

import Foundation

enum NDALocalizedKey {
    case title
    case cardSubtitle
    case legalChecklistTitle
    case disclosingPartyTitle
    case receivingPartyTitle
    case ndaTermsTitle
    case confidentialInfoField
    case purposeField
    case obligationsField
    case durationField
    case exclusionsField
    case returnField
    case governingLawField
    case previewButton
    case blockingDisclosingParty
    case blockingReceivingParty
    case blockingConfidentialInfo
    case blockingPurpose
    case blockingObligations
    case blockingPlace
    case warningDuration
    case warningExclusions
    case warningReturn
    case warningLaw
    case clauseOneTitle
    case clauseTwoTitle
    case clauseThreeTitle
    case clauseFourTitle
    case clauseFiveTitle
    case clauseSixTitle
    case bodyPartiesPrefix
    case bodyPartiesMiddle
    case bodyInfoPrefix
    case bodyPurposePrefix
    case bodyObligationsPrefix
    case bodyDurationPrefix
    case bodyExclusionsPrefix
    case bodyReturnPrefix
    case bodyLawPrefix
    case bodyGoodFaith
    case defaultDuration
    case defaultExclusions
    case defaultReturn
    case defaultLaw
}

struct NDAFormData {
    var disclosingParty = ContractParty()
    var receivingParty = ContractParty()
    var confidentialInfo = ""
    var purpose = ""
    var obligations = ""
    var duration = ""
    var exclusions = ""
    var returnMaterials = ""
    var governingLaw = ""
    var signingPlace = ""
    var signingDate = Date()

    func blockingIssues(in language: AppLanguage) -> [ValidationMessage] {
        var messages: [ValidationMessage] = []
        if disclosingParty.name.trimmed.isEmpty || disclosingParty.address.trimmed.isEmpty {
            messages.append(.init(severity: .blocking, message: language.ndaText(.blockingDisclosingParty)))
        }
        if receivingParty.name.trimmed.isEmpty || receivingParty.address.trimmed.isEmpty {
            messages.append(.init(severity: .blocking, message: language.ndaText(.blockingReceivingParty)))
        }
        if confidentialInfo.trimmed.isEmpty {
            messages.append(.init(severity: .blocking, message: language.ndaText(.blockingConfidentialInfo)))
        }
        if purpose.trimmed.isEmpty {
            messages.append(.init(severity: .blocking, message: language.ndaText(.blockingPurpose)))
        }
        if obligations.trimmed.isEmpty {
            messages.append(.init(severity: .blocking, message: language.ndaText(.blockingObligations)))
        }
        if signingPlace.trimmed.isEmpty {
            messages.append(.init(severity: .blocking, message: language.ndaText(.blockingPlace)))
        }
        return messages
    }

    func warnings(in language: AppLanguage) -> [ValidationMessage] {
        var messages: [ValidationMessage] = []
        if duration.trimmed.isEmpty {
            messages.append(.init(severity: .warning, message: language.ndaText(.warningDuration)))
        }
        if exclusions.trimmed.isEmpty {
            messages.append(.init(severity: .warning, message: language.ndaText(.warningExclusions)))
        }
        if returnMaterials.trimmed.isEmpty {
            messages.append(.init(severity: .warning, message: language.ndaText(.warningReturn)))
        }
        if governingLaw.trimmed.isEmpty {
            messages.append(.init(severity: .warning, message: language.ndaText(.warningLaw)))
        }
        return messages
    }

    var document: NDADocument {
        NDADocument(
            disclosingParty: disclosingParty,
            receivingParty: receivingParty,
            confidentialInfo: confidentialInfo.trimmed,
            purpose: purpose.trimmed,
            obligations: obligations.trimmed,
            duration: duration.trimmed,
            exclusions: exclusions.trimmed,
            returnMaterials: returnMaterials.trimmed,
            governingLaw: governingLaw.trimmed,
            signingPlace: signingPlace.trimmed,
            signingDate: signingDate
        )
    }
}

struct NDADocument {
    let disclosingParty: ContractParty
    let receivingParty: ContractParty
    let confidentialInfo: String
    let purpose: String
    let obligations: String
    let duration: String
    let exclusions: String
    let returnMaterials: String
    let governingLaw: String
    let signingPlace: String
    let signingDate: Date

    var formattedDate: String {
        signingDate.formatted(date: .long, time: .omitted)
    }

    func bodyText(in language: AppLanguage) -> String {
        let durationText = duration.isEmpty ? language.ndaText(.defaultDuration) : duration
        let exclusionsText = exclusions.isEmpty ? language.ndaText(.defaultExclusions) : exclusions
        let returnText = returnMaterials.isEmpty ? language.ndaText(.defaultReturn) : returnMaterials
        let lawText = governingLaw.isEmpty ? language.ndaText(.defaultLaw) : governingLaw

        return [
            "\(language.ndaText(.clauseOneTitle))\n\(language.ndaText(.bodyPartiesPrefix)) \(disclosingParty.name.trimmed), \(disclosingParty.address.trimmed), \(language.ndaText(.bodyPartiesMiddle)) \(receivingParty.name.trimmed), \(receivingParty.address.trimmed).",
            "\(language.ndaText(.clauseTwoTitle))\n\(language.ndaText(.bodyInfoPrefix)) \(confidentialInfo).",
            "\(language.ndaText(.clauseThreeTitle))\n\(language.ndaText(.bodyPurposePrefix)) \(purpose).\n\(language.ndaText(.bodyObligationsPrefix)) \(obligations).",
            "\(language.ndaText(.clauseFourTitle))\n\(language.ndaText(.bodyDurationPrefix)) \(durationText).",
            "\(language.ndaText(.clauseFiveTitle))\n\(language.ndaText(.bodyExclusionsPrefix)) \(exclusionsText).\n\(language.ndaText(.bodyReturnPrefix)) \(returnText).",
            "\(language.ndaText(.clauseSixTitle))\n\(language.ndaText(.bodyLawPrefix)) \(lawText)",
            language.ndaText(.bodyGoodFaith)
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
        <h1>\(language.ndaText(.title).htmlEscaped)</h1>
        <p>\(bodyText(in: language).htmlEscaped.replacingOccurrences(of: "\n", with: "<br><br>"))</p>
        <div class="signature">
        <p>\(signingPlace.htmlEscaped), \(formattedDate.htmlEscaped)</p>
        <div class="line">\(disclosingParty.name.htmlEscaped)</div>
        <div class="line">\(receivingParty.name.htmlEscaped)</div>
        </div>
        </div>
        </body>
        </html>
        """
    }
}

extension AppLanguage {
    var ndaChecklist: [String] {
        [
            ndaText(.bodyInfoPrefix),
            ndaText(.warningDuration).replacingOccurrences(of: ".", with: ""),
            ndaText(.warningLaw).replacingOccurrences(of: ".", with: "")
        ]
    }

    func ndaText(_ key: NDALocalizedKey) -> String {
        switch (self, key) {
        case (.norwegian, .title): return "NDA"
        case (.norwegian, .cardSubtitle): return "Lag en enkel konfidensialitetsavtale med formål, hemmelig informasjon og varighet."
        case (.norwegian, .legalChecklistTitle): return "Det som bør være tydelig i konfidensialitetsavtalen"
        case (.norwegian, .disclosingPartyTitle): return "Opplysningsgiver"
        case (.norwegian, .receivingPartyTitle): return "Mottaker"
        case (.norwegian, .ndaTermsTitle): return "Konfidensialitetsvilkår"
        case (.norwegian, .confidentialInfoField): return "Hvilken informasjon er konfidensiell?"
        case (.norwegian, .purposeField): return "Hva er formålet med delingen?"
        case (.norwegian, .obligationsField): return "Hva må mottakeren gjøre eller avstå fra?"
        case (.norwegian, .durationField): return "Hvor lenge gjelder konfidensialiteten?"
        case (.norwegian, .exclusionsField): return "Unntak fra konfidensialitet"
        case (.norwegian, .returnField): return "Tilbakelevering eller sletting av materiale"
        case (.norwegian, .governingLawField): return "Lovvalg eller tvisteløsning"
        case (.norwegian, .previewButton): return "Vis NDA"
        case (.norwegian, .blockingDisclosingParty): return "Opplysningsgiver må ha navn og adresse."
        case (.norwegian, .blockingReceivingParty): return "Mottaker må ha navn og adresse."
        case (.norwegian, .blockingConfidentialInfo): return "Det må beskrives hvilken informasjon som er konfidensiell."
        case (.norwegian, .blockingPurpose): return "Formålet med delingen må beskrives."
        case (.norwegian, .blockingObligations): return "Mottakerens plikter må beskrives."
        case (.norwegian, .blockingPlace): return "Sted for signering mangler."
        case (.norwegian, .warningDuration): return "Varighet er ikke regulert. Det bør fremgå hvor lenge forpliktelsen varer."
        case (.norwegian, .warningExclusions): return "Unntak er ikke omtalt. Det bør fremgå hva som ikke regnes som konfidensiell informasjon."
        case (.norwegian, .warningReturn): return "Tilbakelevering eller sletting er ikke omtalt. Det bør fremgå hva som skjer med materialet etterpå."
        case (.norwegian, .warningLaw): return "Lovvalg eller tvisteløsning er ikke omtalt. Det bør fremgå hvilken rett som gjelder eller hvordan tvister håndteres."
        case (.norwegian, .clauseOneTitle): return "1. Parter"
        case (.norwegian, .clauseTwoTitle): return "2. Konfidensiell informasjon"
        case (.norwegian, .clauseThreeTitle): return "3. Formål og plikter"
        case (.norwegian, .clauseFourTitle): return "4. Varighet"
        case (.norwegian, .clauseFiveTitle): return "5. Unntak og materiale"
        case (.norwegian, .clauseSixTitle): return "6. Lovvalg"
        case (.norwegian, .bodyPartiesPrefix): return "Mellom"
        case (.norwegian, .bodyPartiesMiddle): return "og"
        case (.norwegian, .bodyInfoPrefix): return "Følgende informasjon anses som konfidensiell"
        case (.norwegian, .bodyPurposePrefix): return "Informasjonen deles for følgende formål"
        case (.norwegian, .bodyObligationsPrefix): return "Mottakeren forplikter seg til følgende"
        case (.norwegian, .bodyDurationPrefix): return "Konfidensialitetsforpliktelsen gjelder"
        case (.norwegian, .bodyExclusionsPrefix): return "Følgende unntak gjelder"
        case (.norwegian, .bodyReturnPrefix): return "Følgende gjelder om tilbakelevering eller sletting av materiale:"
        case (.norwegian, .bodyLawPrefix): return "Følgende gjelder om lovvalg eller tvisteløsning"
        case (.norwegian, .bodyGoodFaith): return "Partene bekrefter at avtalen er lest, forstått og inngått for å beskytte konfidensiell informasjon."
        case (.norwegian, .defaultDuration): return "så lenge informasjonen har konfidensiell karakter eller til partene skriftlig avtaler noe annet"
        case (.norwegian, .defaultExclusions): return "Informasjon som allerede er offentlig kjent eller lovlig mottatt fra andre faller utenfor avtalen."
        case (.norwegian, .defaultReturn): return "Materiale skal tilbakeleveres eller slettes innen rimelig tid etter krav fra opplysningsgiver."
        case (.norwegian, .defaultLaw): return "Tvister søkes løst i minnelighet, og norsk rett legges til grunn dersom annet ikke avtales."
        case (.english, .title): return "NDA"
        case (.english, .cardSubtitle): return "Prepare a simple confidentiality agreement with purpose, confidential information, and duration."
        case (.english, .legalChecklistTitle): return "What should be clear in the confidentiality agreement"
        case (.english, .disclosingPartyTitle): return "Disclosing party"
        case (.english, .receivingPartyTitle): return "Receiving party"
        case (.english, .ndaTermsTitle): return "Confidentiality terms"
        case (.english, .confidentialInfoField): return "What information is confidential?"
        case (.english, .purposeField): return "What is the purpose of the disclosure?"
        case (.english, .obligationsField): return "What must the receiving party do or refrain from doing?"
        case (.english, .durationField): return "How long does confidentiality apply?"
        case (.english, .exclusionsField): return "Exclusions from confidentiality"
        case (.english, .returnField): return "Return or deletion of materials"
        case (.english, .governingLawField): return "Governing law or dispute resolution"
        case (.english, .previewButton): return "Show NDA"
        case (.english, .blockingDisclosingParty): return "The disclosing party must have a name and address."
        case (.english, .blockingReceivingParty): return "The receiving party must have a name and address."
        case (.english, .blockingConfidentialInfo): return "It must be described what information is confidential."
        case (.english, .blockingPurpose): return "The purpose of the disclosure must be described."
        case (.english, .blockingObligations): return "The receiving party's obligations must be described."
        case (.english, .blockingPlace): return "The place of signing is missing."
        case (.english, .warningDuration): return "Duration is not regulated. It should be clear how long the obligation lasts."
        case (.english, .warningExclusions): return "Exclusions are not addressed. It should be clear what is not treated as confidential information."
        case (.english, .warningReturn): return "Return or deletion is not addressed. It should be clear what happens to the material afterward."
        case (.english, .warningLaw): return "Governing law or dispute resolution is not addressed. It should be clear what law applies or how disputes are handled."
        case (.english, .clauseOneTitle): return "1. Parties"
        case (.english, .clauseTwoTitle): return "2. Confidential information"
        case (.english, .clauseThreeTitle): return "3. Purpose and obligations"
        case (.english, .clauseFourTitle): return "4. Duration"
        case (.english, .clauseFiveTitle): return "5. Exclusions and materials"
        case (.english, .clauseSixTitle): return "6. Governing law"
        case (.english, .bodyPartiesPrefix): return "Between"
        case (.english, .bodyPartiesMiddle): return "and"
        case (.english, .bodyInfoPrefix): return "The following information is considered confidential"
        case (.english, .bodyPurposePrefix): return "The information is disclosed for the following purpose"
        case (.english, .bodyObligationsPrefix): return "The receiving party undertakes the following"
        case (.english, .bodyDurationPrefix): return "The confidentiality obligation applies"
        case (.english, .bodyExclusionsPrefix): return "The following exclusions apply"
        case (.english, .bodyReturnPrefix): return "The following applies regarding return or deletion of materials:"
        case (.english, .bodyLawPrefix): return "The following applies regarding governing law or dispute resolution"
        case (.english, .bodyGoodFaith): return "The parties confirm that the agreement has been read, understood, and entered into to protect confidential information."
        case (.english, .defaultDuration): return "for as long as the information retains its confidential character or until the parties agree otherwise in writing"
        case (.english, .defaultExclusions): return "Information already public or lawfully received from others falls outside the agreement."
        case (.english, .defaultReturn): return "Materials shall be returned or deleted within a reasonable time upon request by the disclosing party."
        case (.english, .defaultLaw): return "Disputes should first be handled amicably, and Norwegian law applies unless otherwise agreed."
        case (.thai, .title): return "ข้อตกลงไม่เปิดเผยข้อมูล"
        case (.thai, .cardSubtitle): return "จัดทำข้อตกลงรักษาความลับอย่างง่ายพร้อมวัตถุประสงค์ ข้อมูลลับ และระยะเวลา"
        case (.thai, .legalChecklistTitle): return "สิ่งที่ควรระบุให้ชัดในข้อตกลงรักษาความลับ"
        case (.thai, .disclosingPartyTitle): return "ฝ่ายเปิดเผยข้อมูล"
        case (.thai, .receivingPartyTitle): return "ฝ่ายรับข้อมูล"
        case (.thai, .ndaTermsTitle): return "เงื่อนไขการรักษาความลับ"
        case (.thai, .confidentialInfoField): return "ข้อมูลใดเป็นความลับ"
        case (.thai, .purposeField): return "วัตถุประสงค์ของการเปิดเผยข้อมูลคืออะไร"
        case (.thai, .obligationsField): return "ฝ่ายรับข้อมูลต้องทำหรือไม่ทำอะไรบ้าง"
        case (.thai, .durationField): return "การรักษาความลับมีผลนานเท่าใด"
        case (.thai, .exclusionsField): return "ข้อยกเว้นของความลับ"
        case (.thai, .returnField): return "การคืนหรือการลบเอกสาร"
        case (.thai, .governingLawField): return "กฎหมายที่ใช้หรือการระงับข้อพิพาท"
        case (.thai, .previewButton): return "แสดง NDA"
        case (.thai, .blockingDisclosingParty): return "ฝ่ายเปิดเผยข้อมูลต้องมีชื่อและที่อยู่"
        case (.thai, .blockingReceivingParty): return "ฝ่ายรับข้อมูลต้องมีชื่อและที่อยู่"
        case (.thai, .blockingConfidentialInfo): return "ต้องอธิบายว่าข้อมูลใดเป็นความลับ"
        case (.thai, .blockingPurpose): return "ต้องอธิบายวัตถุประสงค์ของการเปิดเผยข้อมูล"
        case (.thai, .blockingObligations): return "ต้องอธิบายหน้าที่ของฝ่ายรับข้อมูล"
        case (.thai, .blockingPlace): return "ยังไม่ได้กรอกสถานที่ลงนาม"
        case (.thai, .warningDuration): return "ยังไม่ได้กำหนดระยะเวลา ควรระบุให้ชัดว่าภาระผูกพันจะมีผลนานเท่าใด"
        case (.thai, .warningExclusions): return "ยังไม่ได้กล่าวถึงข้อยกเว้น ควรระบุให้ชัดว่าข้อมูลใดไม่ถือเป็นความลับ"
        case (.thai, .warningReturn): return "ยังไม่ได้กล่าวถึงการคืนหรือลบเอกสาร ควรระบุให้ชัดว่าจะจัดการกับเอกสารอย่างไรภายหลัง"
        case (.thai, .warningLaw): return "ยังไม่ได้กล่าวถึงกฎหมายที่ใช้หรือการระงับข้อพิพาท ควรระบุให้ชัดว่าจะใช้กฎหมายใดหรือจัดการข้อพิพาทอย่างไร"
        case (.thai, .clauseOneTitle): return "1. คู่สัญญา"
        case (.thai, .clauseTwoTitle): return "2. ข้อมูลลับ"
        case (.thai, .clauseThreeTitle): return "3. วัตถุประสงค์และหน้าที่"
        case (.thai, .clauseFourTitle): return "4. ระยะเวลา"
        case (.thai, .clauseFiveTitle): return "5. ข้อยกเว้นและเอกสาร"
        case (.thai, .clauseSixTitle): return "6. กฎหมายที่ใช้"
        case (.thai, .bodyPartiesPrefix): return "ระหว่าง"
        case (.thai, .bodyPartiesMiddle): return "และ"
        case (.thai, .bodyInfoPrefix): return "ข้อมูลต่อไปนี้ถือเป็นความลับ"
        case (.thai, .bodyPurposePrefix): return "ข้อมูลถูกเปิดเผยเพื่อวัตถุประสงค์ดังต่อไปนี้"
        case (.thai, .bodyObligationsPrefix): return "ฝ่ายรับข้อมูลตกลงดังต่อไปนี้"
        case (.thai, .bodyDurationPrefix): return "ภาระผูกพันในการรักษาความลับมีผล"
        case (.thai, .bodyExclusionsPrefix): return "มีข้อยกเว้นดังต่อไปนี้"
        case (.thai, .bodyReturnPrefix): return "การคืนหรือลบเอกสารให้เป็นไปดังนี้:"
        case (.thai, .bodyLawPrefix): return "กฎหมายที่ใช้หรือการระงับข้อพิพาทเป็นดังนี้"
        case (.thai, .bodyGoodFaith): return "คู่สัญญายืนยันว่าได้อ่าน เข้าใจ และทำข้อตกลงนี้เพื่อคุ้มครองข้อมูลลับ"
        case (.thai, .defaultDuration): return "ตราบเท่าที่ข้อมูลยังคงมีลักษณะเป็นความลับหรือจนกว่าคู่สัญญาจะตกลงเป็นลายลักษณ์อักษรเป็นอย่างอื่น"
        case (.thai, .defaultExclusions): return "ข้อมูลที่เป็นสาธารณะอยู่แล้วหรือได้รับมาโดยชอบด้วยกฎหมายจากบุคคลอื่นไม่อยู่ภายใต้ข้อตกลงนี้"
        case (.thai, .defaultReturn): return "เอกสารจะต้องถูกคืนหรือลบภายในระยะเวลาที่สมเหตุสมผลเมื่อฝ่ายเปิดเผยข้อมูลร้องขอ"
        case (.thai, .defaultLaw): return "ข้อพิพาทควรพยายามแก้ไขโดยสันติก่อน และให้ใช้กฎหมายนอร์เวย์ เว้นแต่จะตกลงเป็นอย่างอื่น"
        }
    }
}
