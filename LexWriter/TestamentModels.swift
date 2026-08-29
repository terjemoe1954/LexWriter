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

    var formattedDate: String {
        testamentDate.formatted(date: .long, time: .omitted)
    }

    var formattedBody: String {
        var paragraphs: [String] = []

        paragraphs.append("Jeg, \(testatorName), bosatt i \(testatorAddress), oppretter med dette som mitt testament og tilbakekaller tidligere testamenter og testamentariske disposisjoner i den utstrekning de strider mot dette dokumentet.")

        for beneficiary in beneficiaries {
            paragraphs.append("Jeg bestemmer at \(beneficiary.name.trimmed) skal arve \(beneficiary.disposition.trimmed).")
        }

        if residueClause.isEmpty {
            paragraphs.append("Arv som ikke er særskilt regulert i dette testamentet, skal fordeles etter arvelovens regler.")
        } else {
            paragraphs.append("Resten av min formue skal tilfalle \(residueClause).")
        }

        if specialProvisions.isEmpty == false {
            paragraphs.append("Særbestemmelser: \(specialProvisions)")
        }

        if familyNotice.isEmpty == false {
            paragraphs.append(familyNotice)
        }

        if testatorPhone.isEmpty == false || testatorEmail.isEmpty == false {
            var contactLines = ["Kontaktopplysninger til testator:"]

            if testatorPhone.isEmpty == false {
                contactLines.append("Telefon: \(testatorPhone)")
            }

            if testatorEmail.isEmpty == false {
                contactLines.append("E-post: \(testatorEmail)")
            }

            paragraphs.append(contactLines.joined(separator: "\n"))
        }

        return paragraphs.joined(separator: "\n\n")
    }

    var witnessStatement: String {
        "Vi bekrefter at testator i vårt samtidige nærvær underskrev eller vedkjente seg dette dokumentet som sitt testament. Vi er kjent med at dokumentet er et testament, og vi signerer som vitner mens testator er til stede."
    }

    var htmlDocument: String {
        let beneficiaryItems = beneficiaries.map {
            "<li><strong>\($0.name.htmlEscaped)</strong> skal arve \($0.disposition.htmlEscaped).</li>"
        }.joined()

        let residueHTML: String
        if residueClause.isEmpty {
            residueHTML = "<p>Arv som ikke er særskilt regulert i dette testamentet, skal fordeles etter arvelovens regler.</p>"
        } else {
            residueHTML = "<p>Resten av min formue skal tilfalle \(residueClause.htmlEscaped).</p>"
        }

        let specialHTML = specialProvisions.isEmpty ? "" : "<p><strong>Særbestemmelser:</strong> \(specialProvisions.htmlEscaped)</p>"
        let familyHTML = familyNotice.isEmpty ? "" : "<p>\(familyNotice.htmlEscaped)</p>"
        let contactHTML = formattedContactHTML

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
        }
        .signature {
            margin-top: 44px;
        }
        .line {
            border-bottom: 1px solid #4a3c2d;
            margin-top: 20px;
            padding-top: 20px;
        }
        </style>
        </head>
        <body>
            <div class="paper">
                <h1>TESTAMENT</h1>
                <p>Jeg, <strong>\(testatorName.htmlEscaped)</strong>, bosatt i \(testatorAddress.htmlEscaped), oppretter med dette som mitt testament.</p>
                <p>Tidligere testamenter og testamentariske disposisjoner tilbakekalles i den utstrekning de strider mot dette dokumentet.</p>
                <ol>\(beneficiaryItems)</ol>
                \(residueHTML)
                \(specialHTML)
                \(familyHTML)
                \(contactHTML)
                <div class="signature">
                    <p>Opprettet i \(testamentPlace.htmlEscaped), \(formattedDate.htmlEscaped).</p>
                    <div class="line">Testators underskrift</div>
                </div>
                <div class="signature">
                    <p><strong>Vitnepåtegning</strong></p>
                    <p>\(witnessStatement.htmlEscaped)</p>
                    <div class="line">Vitne 1: \(witnessOne.name.htmlEscaped)</div>
                    <div class="line">Adresse: \(witnessOne.address.htmlEscaped)</div>
                    <div class="line">Underskrift</div>
                    <div class="line">Vitne 2: \(witnessTwo.name.htmlEscaped)</div>
                    <div class="line">Adresse: \(witnessTwo.address.htmlEscaped)</div>
                    <div class="line">Underskrift</div>
                </div>
            </div>
        </body>
        </html>
        """
    }

    private var formattedContactHTML: String {
        var lines: [String] = []

        if testatorPhone.isEmpty == false {
            lines.append("Telefon: \(testatorPhone.htmlEscaped)")
        }

        if testatorEmail.isEmpty == false {
            lines.append("E-post: \(testatorEmail.htmlEscaped)")
        }

        guard lines.isEmpty == false else {
            return ""
        }

        let body = lines.joined(separator: "<br>")
        return "<p><strong>Kontaktopplysninger til testator:</strong><br>\(body)</p>"
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
