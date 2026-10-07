//
//  TestamentModels.swift
//  LexWriter
//
//  Created by Terje Moe on 29/08/2026.
//

import Foundation

struct RequirementItem: Identifiable {
    let id = UUID()
    let title: String
    let isSatisfied: Bool
}

struct BeneficiaryEntry: Identifiable, Equatable {
    let id = UUID()
    var name = ""
    var disposition = ""
}

struct WitnessInfo: Equatable {
    var name = ""
    var address = ""
}

enum ValidationSeverity {
    case blocking
    case warning
}

struct ValidationMessage: Identifiable, Equatable {
    let id = UUID()
    let severity: ValidationSeverity
    let message: String
}

struct TestamentFormData {
    var testatorName = ""
    var testatorAddress = ""
    var testatorPhone = ""
    var testatorEmail = ""
    var testamentPlace = ""
    var testamentDate = Date()
    var hasChildren = true
    var hasSpouseOrRegisteredPartner = false
    var hasCohabitantWithInheritanceRights = false
    var beneficiaries: [BeneficiaryEntry] = [BeneficiaryEntry()]
    var residueClause = ""
    var specialProvisions = ""
    var witnessesPresentTogetherConfirmed = false
    var witnessesKnowItsATestamentConfirmed = false
    var witnessesAreEligibleConfirmed = false
    var witnessOne = WitnessInfo()
    var witnessTwo = WitnessInfo()

    static func signingRequirements(in language: AppLanguage) -> [RequirementItem] {
        [
            RequirementItem(
                title: language.testamentText(.signingRequirementOne),
                isSatisfied: true
            ),
            RequirementItem(
                title: language.testamentText(.signingRequirementTwo),
                isSatisfied: true
            ),
            RequirementItem(
                title: language.testamentText(.signingRequirementThree),
                isSatisfied: true
            ),
            RequirementItem(
                title: language.testamentText(.signingRequirementFour),
                isSatisfied: true
            )
        ]
    }

    var normalizedBeneficiaries: [BeneficiaryEntry] {
        beneficiaries.filter {
            $0.name.trimmed.isEmpty == false && $0.disposition.trimmed.isEmpty == false
        }
    }

    func completionRequirements(in language: AppLanguage) -> [RequirementItem] {
        [
            RequirementItem(title: language.testamentText(.completionRequirementOne), isSatisfied: testatorName.trimmed.isEmpty == false),
            RequirementItem(title: language.testamentText(.completionRequirementTwo), isSatisfied: testatorAddress.trimmed.isEmpty == false),
            RequirementItem(title: language.testamentText(.completionRequirementThree), isSatisfied: normalizedBeneficiaries.isEmpty == false),
            RequirementItem(title: language.testamentText(.completionRequirementFour), isSatisfied: testamentPlace.trimmed.isEmpty == false),
            RequirementItem(title: language.testamentText(.completionRequirementFive), isSatisfied: witnessesPresentTogetherConfirmed && witnessesKnowItsATestamentConfirmed && witnessesAreEligibleConfirmed),
            RequirementItem(title: language.testamentText(.completionRequirementSix), isSatisfied: witnessFieldsComplete)
        ]
    }

    func blockingIssues(in language: AppLanguage) -> [ValidationMessage] {
        validationMessages(in: language).filter { $0.severity == .blocking }
    }

    func warnings(in language: AppLanguage) -> [ValidationMessage] {
        validationMessages(in: language).filter { $0.severity == .warning }
    }

    var witnessFieldsComplete: Bool {
        witnessOne.name.trimmed.isEmpty == false &&
        witnessOne.address.trimmed.isEmpty == false &&
        witnessTwo.name.trimmed.isEmpty == false &&
        witnessTwo.address.trimmed.isEmpty == false
    }

    var generatedDocument: TestamentDocument {
        TestamentDocument(
            testatorName: testatorName.trimmed,
            testatorAddress: testatorAddress.trimmed,
            testatorPhone: testatorPhone.trimmed,
            testatorEmail: testatorEmail.trimmed,
            testamentPlace: testamentPlace.trimmed,
            testamentDate: testamentDate,
            familyNotice: familyNotice,
            beneficiaries: normalizedBeneficiaries,
            residueClause: residueClause.trimmed,
            specialProvisions: specialProvisions.trimmed,
            witnessOne: witnessOne,
            witnessTwo: witnessTwo
        )
    }

    private var familyNotice: String {
        var notices: [String] = []

        if hasChildren {
            notices.append("Testamentet skal forstås og gjennomføres innenfor reglene om pliktdelsarv til livsarvinger.")
        }

        if hasSpouseOrRegisteredPartner {
            notices.append("Ektefelles eller registrert partners rettigheter etter arveloven skal respekteres.")
        }

        if hasCohabitantWithInheritanceRights {
            notices.append("Samboers lovbestemte rettigheter skal respekteres der slike rettigheter foreligger.")
        }

        return notices.joined(separator: " ")
    }

    private func validationMessages(in language: AppLanguage) -> [ValidationMessage] {
        var messages: [ValidationMessage] = []

        if testatorName.trimmed.isEmpty {
            messages.append(.init(severity: .blocking, message: language.testamentText(.blockingMissingName)))
        }

        if testatorAddress.trimmed.isEmpty {
            messages.append(.init(severity: .blocking, message: language.testamentText(.blockingMissingAddress)))
        }

        if normalizedBeneficiaries.isEmpty {
            messages.append(.init(severity: .blocking, message: language.testamentText(.blockingMissingBeneficiary)))
        }

        if testamentPlace.trimmed.isEmpty {
            messages.append(.init(severity: .blocking, message: language.testamentText(.blockingMissingPlace)))
        }

        if witnessesPresentTogetherConfirmed == false ||
            witnessesKnowItsATestamentConfirmed == false ||
            witnessesAreEligibleConfirmed == false {
            messages.append(.init(severity: .blocking, message: language.testamentText(.blockingMissingConfirmations)))
        }

        if witnessOne.name.trimmed.isEmpty || witnessOne.address.trimmed.isEmpty ||
            witnessTwo.name.trimmed.isEmpty || witnessTwo.address.trimmed.isEmpty {
            messages.append(.init(severity: .blocking, message: language.testamentText(.blockingMissingWitnesses)))
        }

        let normalizedTestator = testatorName.trimmed.lowercased()
        let normalizedWitnessOne = witnessOne.name.trimmed.lowercased()
        let normalizedWitnessTwo = witnessTwo.name.trimmed.lowercased()
        let beneficiaryNames = Set(normalizedBeneficiaries.map { $0.name.trimmed.lowercased() })

        if normalizedWitnessOne.isEmpty == false && normalizedWitnessOne == normalizedTestator {
            messages.append(.init(severity: .blocking, message: language.testamentText(.blockingWitnessOneIsTestator)))
        }

        if normalizedWitnessTwo.isEmpty == false && normalizedWitnessTwo == normalizedTestator {
            messages.append(.init(severity: .blocking, message: language.testamentText(.blockingWitnessTwoIsTestator)))
        }

        if normalizedWitnessOne.isEmpty == false && normalizedWitnessOne == normalizedWitnessTwo {
            messages.append(.init(severity: .blocking, message: language.testamentText(.blockingWitnessesMustDiffer)))
        }

        if beneficiaryNames.contains(normalizedWitnessOne) {
            messages.append(.init(severity: .blocking, message: language.testamentText(.blockingWitnessOneIsBeneficiary)))
        }

        if beneficiaryNames.contains(normalizedWitnessTwo) {
            messages.append(.init(severity: .blocking, message: language.testamentText(.blockingWitnessTwoIsBeneficiary)))
        }

        if hasChildren {
            messages.append(.init(severity: .warning, message: language.testamentText(.warningChildren)))
        }

        if hasSpouseOrRegisteredPartner {
            messages.append(.init(severity: .warning, message: language.testamentText(.warningSpouse)))
        }

        if hasCohabitantWithInheritanceRights {
            messages.append(.init(severity: .warning, message: language.testamentText(.warningCohabitant)))
        }

        if residueClause.trimmed.isEmpty && specialProvisions.trimmed.isEmpty {
            messages.append(.init(severity: .warning, message: language.testamentText(.warningResidue)))
        }

        return messages
    }
}

struct TestamentDocument {
    let testatorName: String
    let testatorAddress: String
    let testatorPhone: String
    let testatorEmail: String
    let testamentPlace: String
    let testamentDate: Date
    let familyNotice: String
    let beneficiaries: [BeneficiaryEntry]
    let residueClause: String
    let specialProvisions: String
    let witnessOne: WitnessInfo
    let witnessTwo: WitnessInfo

    func formattedDate(in language: AppLanguage) -> String {
        let locale: Locale = switch language {
        case .norwegian:
            Locale(identifier: "nb_NO")
        case .english:
            Locale(identifier: "en_GB")
        case .thai:
            Locale(identifier: "th_TH")
        }

        return testamentDate.formatted(
            Date.FormatStyle(date: .long, time: .omitted).locale(locale)
        )
    }

    var formattedDate: String {
        formattedDate(in: .norwegian)
    }

    func formattedBody(in language: AppLanguage) -> String {
        let wording = TestamentWording(language: language)
        var paragraphs: [String] = []

        paragraphs.append(wording.introduction(name: testatorName, address: testatorAddress))

        for beneficiary in beneficiaries {
            paragraphs.append(
                wording.beneficiary(
                    name: beneficiary.name.trimmed,
                    disposition: beneficiary.disposition.trimmed
                )
            )
        }

        if residueClause.isEmpty {
            paragraphs.append(wording.defaultResidue)
        } else {
            paragraphs.append(wording.residue(residueClause))
        }

        if specialProvisions.isEmpty == false {
            paragraphs.append("\(wording.specialProvisions): \(specialProvisions)")
        }

        if familyNotice.isEmpty == false {
            paragraphs.append(wording.familyNotice(from: familyNotice))
        }

        if testatorPhone.isEmpty == false || testatorEmail.isEmpty == false {
            var contactLines = ["\(wording.contactInformation):"]

            if testatorPhone.isEmpty == false {
                contactLines.append("\(wording.phone): \(testatorPhone)")
            }

            if testatorEmail.isEmpty == false {
                contactLines.append("\(wording.email): \(testatorEmail)")
            }

            paragraphs.append(contactLines.joined(separator: "\n"))
        }

        return paragraphs.joined(separator: "\n\n")
    }

    var formattedBody: String {
        formattedBody(in: .norwegian)
    }

    func witnessStatement(in language: AppLanguage) -> String {
        TestamentWording(language: language).witnessStatement
    }

    var witnessStatement: String {
        witnessStatement(in: .norwegian)
    }

    func htmlDocument(in language: AppLanguage) -> String {
        let wording = TestamentWording(language: language)
        let bodyHTML = formattedBody(in: language)
            .htmlEscaped
            .replacingOccurrences(of: "\n", with: "<br><br>")

        return """
        <html>
        <head>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <style>
        body {
            font-family: Georgia, 'Times New Roman', serif;
            color: #2c2218;
            margin: 44px;
            line-height: 1.6;
            background: #fbf4e7;
        }
        h1 {
            text-align: center;
            letter-spacing: 4px;
            margin-bottom: 36px;
        }
        .paper {
            border: 1px solid #8d7358;
            padding: 36px;
            background: #f8efdd;
            overflow-wrap: anywhere;
        }
        .signature {
            margin-top: 44px;
            break-inside: avoid;
            page-break-inside: avoid;
        }
        .line {
            border-bottom: 1px solid #4a3c2d;
            margin-top: 20px;
            padding-top: 20px;
            overflow-wrap: anywhere;
        }
        </style>
        </head>
        <body>
            <div class="paper">
                <h1>\(language.text(.testamentTitle).htmlEscaped)</h1>
                <p>\(bodyHTML)</p>
                <div class="signature">
                    <p>\(wording.createdIn) \(testamentPlace.htmlEscaped), \(formattedDate(in: language).htmlEscaped).</p>
                    <div class="line">\(language.text(.testatorSignature).htmlEscaped)</div>
                </div>
                <div class="signature">
                    <p><strong>\(language.text(.witnessStatementTitle).htmlEscaped)</strong></p>
                    <p>\(witnessStatement(in: language).htmlEscaped)</p>
                    <div class="line">\(language.text(.witnessOne).htmlEscaped): \(witnessOne.name.htmlEscaped)</div>
                    <div class="line">\(language.text(.address).htmlEscaped): \(witnessOne.address.htmlEscaped)</div>
                    <div class="line">\(wording.signature)</div>
                    <div class="line">\(language.text(.witnessTwo).htmlEscaped): \(witnessTwo.name.htmlEscaped)</div>
                    <div class="line">\(language.text(.address).htmlEscaped): \(witnessTwo.address.htmlEscaped)</div>
                    <div class="line">\(wording.signature)</div>
                </div>
            </div>
        </body>
        </html>
        """
    }

    var htmlDocument: String {
        htmlDocument(in: .norwegian)
    }

}

struct TestamentWording {
    let language: AppLanguage

    func introduction(name: String, address: String) -> String {
        switch language {
        case .norwegian:
            return "Jeg, \(name), bosatt i \(address), oppretter med dette som mitt testament og tilbakekaller tidligere testamenter og testamentariske disposisjoner i den utstrekning de strider mot dette dokumentet."
        case .english:
            return "I, \(name), residing at \(address), hereby make this document my will and revoke earlier wills and testamentary dispositions to the extent that they conflict with this document."
        case .thai:
            return "ข้าพเจ้า \(name) มีที่อยู่ที่ \(address) จัดทำเอกสารฉบับนี้เป็นพินัยกรรม และเพิกถอนพินัยกรรมหรือข้อกำหนดเกี่ยวกับมรดกฉบับก่อนเท่าที่ขัดกับเอกสารฉบับนี้"
        }
    }

    func beneficiary(name: String, disposition: String) -> String {
        switch language {
        case .norwegian:
            return "Jeg bestemmer at \(name) skal arve \(disposition)."
        case .english:
            return "I direct that \(name) shall inherit \(disposition)."
        case .thai:
            return "ข้าพเจ้ากำหนดให้ \(name) ได้รับมรดก \(disposition)"
        }
    }

    var defaultResidue: String {
        switch language {
        case .norwegian:
            return "Arv som ikke er særskilt regulert i dette testamentet, skal fordeles etter arvelovens regler."
        case .english:
            return "Any estate not specifically disposed of by this will shall be distributed under the Norwegian Inheritance Act."
        case .thai:
            return "ทรัพย์มรดกที่พินัยกรรมนี้ไม่ได้กำหนดไว้โดยเฉพาะให้แบ่งตามกฎหมายมรดกของนอร์เวย์"
        }
    }

    func residue(_ value: String) -> String {
        switch language {
        case .norwegian:
            return "Resten av min formue skal tilfalle \(value)."
        case .english:
            return "The remainder of my estate shall pass to \(value)."
        case .thai:
            return "ทรัพย์มรดกส่วนที่เหลือของข้าพเจ้าให้ตกแก่ \(value)"
        }
    }

    var specialProvisions: String {
        switch language {
        case .norwegian: "Særbestemmelser"
        case .english: "Special provisions"
        case .thai: "ข้อกำหนดพิเศษ"
        }
    }

    var contactInformation: String {
        switch language {
        case .norwegian: "Kontaktopplysninger til testator"
        case .english: "Testator contact information"
        case .thai: "ข้อมูลติดต่อของผู้ทำพินัยกรรม"
        }
    }

    var phone: String {
        switch language {
        case .norwegian: "Telefon"
        case .english: "Phone"
        case .thai: "โทรศัพท์"
        }
    }

    var email: String {
        switch language {
        case .norwegian: "E-post"
        case .english: "Email"
        case .thai: "อีเมล"
        }
    }

    var createdIn: String {
        switch language {
        case .norwegian: "Opprettet i"
        case .english: "Made in"
        case .thai: "จัดทำ ณ"
        }
    }

    var signature: String {
        switch language {
        case .norwegian: "Underskrift"
        case .english: "Signature"
        case .thai: "ลายมือชื่อ"
        }
    }

    var witnessStatement: String {
        switch language {
        case .norwegian:
            return "Vi bekrefter at testator i vårt samtidige nærvær underskrev eller vedkjente seg dette dokumentet som sitt testament. Vi er kjent med at dokumentet er et testament, og vi signerer som vitner mens testator er til stede."
        case .english:
            return "We confirm that the testator signed or acknowledged this document as their will in our simultaneous presence. We know that the document is a will and sign as witnesses while the testator is present."
        case .thai:
            return "เราขอยืนยันว่าผู้ทำพินัยกรรมได้ลงนามหรือรับรองเอกสารฉบับนี้ว่าเป็นพินัยกรรมต่อหน้าเราทั้งสองพร้อมกัน เราทราบว่าเอกสารนี้เป็นพินัยกรรมและลงนามเป็นพยานในขณะที่ผู้ทำพินัยกรรมอยู่ด้วย"
        }
    }

    func familyNotice(from norwegianNotice: String) -> String {
        guard language != .norwegian else {
            return norwegianNotice
        }

        let notices = [
            (
                "Testamentet skal forstås og gjennomføres innenfor reglene om pliktdelsarv til livsarvinger.",
                language == .english
                    ? "This will shall be interpreted and implemented subject to the mandatory inheritance rights of lineal descendants."
                    : "พินัยกรรมนี้ให้ตีความและดำเนินการภายใต้สิทธิรับมรดกภาคบังคับของผู้สืบสันดาน"
            ),
            (
                "Ektefelles eller registrert partners rettigheter etter arveloven skal respekteres.",
                language == .english
                    ? "The rights of a spouse or registered partner under the Norwegian Inheritance Act shall be respected."
                    : "ต้องเคารพสิทธิของคู่สมรสหรือคู่จดทะเบียนตามกฎหมายมรดกของนอร์เวย์"
            ),
            (
                "Samboers lovbestemte rettigheter skal respekteres der slike rettigheter foreligger.",
                language == .english
                    ? "A cohabitant's statutory rights shall be respected where such rights apply."
                    : "ต้องเคารพสิทธิตามกฎหมายของคู่ชีวิตในกรณีที่มีสิทธิดังกล่าว"
            )
        ]

        return notices.reduce(norwegianNotice) { result, notice in
            result.replacingOccurrences(of: notice.0, with: notice.1)
        }
    }
}

extension String {
    var trimmed: String {
        trimmingCharacters(in: .whitespacesAndNewlines)
    }

    var htmlEscaped: String {
        self
            .replacingOccurrences(of: "&", with: "&amp;")
            .replacingOccurrences(of: "<", with: "&lt;")
            .replacingOccurrences(of: ">", with: "&gt;")
            .replacingOccurrences(of: "\"", with: "&quot;")
            .replacingOccurrences(of: "'", with: "&#39;")
    }
}
