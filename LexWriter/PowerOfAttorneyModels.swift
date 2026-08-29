//
//  PowerOfAttorneyModels.swift
//  LexWriter
//
//  Created by Terje Moe on 29/08/2026.
//

import Foundation

struct PowerOfAttorneyFormData {
    var principalName = ""
    var principalAddress = ""
    var principalPhone = ""
    var principalEmail = ""
    var agentName = ""
    var agentAddress = ""
    var mandateScope = ""
    var authorizationPurpose = ""
    var restrictions = ""
    var validFrom = ""
    var validUntil = ""
    var revocationTerms = ""
    var signingPlace = ""
    var signingDate = Date()

    func blockingIssues(in language: AppLanguage) -> [ValidationMessage] {
        var messages: [ValidationMessage] = []

        if principalName.trimmed.isEmpty || principalAddress.trimmed.isEmpty {
            messages.append(.init(severity: .blocking, message: language.powerOfAttorneyText(.blockingPrincipal)))
        }

        if agentName.trimmed.isEmpty || agentAddress.trimmed.isEmpty {
            messages.append(.init(severity: .blocking, message: language.powerOfAttorneyText(.blockingAgent)))
        }

        if mandateScope.trimmed.isEmpty {
            messages.append(.init(severity: .blocking, message: language.powerOfAttorneyText(.blockingScope)))
        }

        if authorizationPurpose.trimmed.isEmpty {
            messages.append(.init(severity: .blocking, message: language.powerOfAttorneyText(.blockingPurpose)))
        }

        if signingPlace.trimmed.isEmpty {
            messages.append(.init(severity: .blocking, message: language.powerOfAttorneyText(.blockingPlace)))
        }

        return messages
    }

    func warnings(in language: AppLanguage) -> [ValidationMessage] {
        var messages: [ValidationMessage] = []

        if validUntil.trimmed.isEmpty {
            messages.append(.init(severity: .warning, message: language.powerOfAttorneyText(.warningDuration)))
        }

        if restrictions.trimmed.isEmpty {
            messages.append(.init(severity: .warning, message: language.powerOfAttorneyText(.warningRestrictions)))
        }

        if revocationTerms.trimmed.isEmpty {
            messages.append(.init(severity: .warning, message: language.powerOfAttorneyText(.warningRevocation)))
        }

        return messages
    }

    var document: PowerOfAttorneyDocument {
        PowerOfAttorneyDocument(
            principalName: principalName.trimmed,
            principalAddress: principalAddress.trimmed,
            principalPhone: principalPhone.trimmed,
            principalEmail: principalEmail.trimmed,
            agentName: agentName.trimmed,
            agentAddress: agentAddress.trimmed,
            mandateScope: mandateScope.trimmed,
            authorizationPurpose: authorizationPurpose.trimmed,
            restrictions: restrictions.trimmed,
            validFrom: validFrom.trimmed,
            validUntil: validUntil.trimmed,
            revocationTerms: revocationTerms.trimmed,
            signingPlace: signingPlace.trimmed,
            signingDate: signingDate
        )
    }
}

struct PowerOfAttorneyDocument {
    let principalName: String
    let principalAddress: String
    let principalPhone: String
    let principalEmail: String
    let agentName: String
    let agentAddress: String
    let mandateScope: String
    let authorizationPurpose: String
    let restrictions: String
    let validFrom: String
    let validUntil: String
    let revocationTerms: String
    let signingPlace: String
    let signingDate: Date

    var formattedDate: String {
        signingDate.formatted(date: .long, time: .omitted)
    }

    func bodyText(in language: AppLanguage) -> String {
        let restrictionsText = restrictions.isEmpty ? language.powerOfAttorneyText(.defaultRestrictions) : restrictions
        let validityText = [validFrom, validUntil].filter { $0.isEmpty == false }.joined(separator: " - ")
        let formattedValidity = validityText.isEmpty ? language.powerOfAttorneyText(.defaultValidity) : validityText
        let revocationText = revocationTerms.isEmpty ? language.powerOfAttorneyText(.defaultRevocation) : revocationTerms

        var sections = [
            "\(language.powerOfAttorneyText(.clauseOneTitle))\n\(language.powerOfAttorneyText(.bodyIntroPrefix)) \(principalName), \(principalAddress), \(language.powerOfAttorneyText(.bodyIntroMiddle)) \(agentName), \(agentAddress), \(language.powerOfAttorneyText(.bodyIntroSuffix))",
            "\(language.powerOfAttorneyText(.clauseTwoTitle))\n\(language.powerOfAttorneyText(.bodyPurposePrefix)) \(authorizationPurpose).",
            "\(language.powerOfAttorneyText(.clauseThreeTitle))\n\(language.powerOfAttorneyText(.bodyScopePrefix)) \(mandateScope).",
            "\(language.powerOfAttorneyText(.clauseFourTitle))\n\(language.powerOfAttorneyText(.bodyRestrictionsPrefix)) \(restrictionsText)",
            "\(language.powerOfAttorneyText(.clauseFiveTitle))\n\(language.powerOfAttorneyText(.bodyValidityPrefix)) \(formattedValidity).",
            "\(language.powerOfAttorneyText(.clauseSixTitle))\n\(language.powerOfAttorneyText(.bodyRevocationPrefix)) \(revocationText)",
            language.powerOfAttorneyText(.bodyThirdPartyNotice)
        ]

        if principalPhone.isEmpty == false || principalEmail.isEmpty == false {
            var contact = [language.powerOfAttorneyText(.contactHeader)]
            if principalPhone.isEmpty == false { contact.append(language.text(.phone) + ": \(principalPhone)") }
            if principalEmail.isEmpty == false { contact.append(language.text(.email) + ": \(principalEmail)") }
            sections.append(contact.joined(separator: "\n"))
        }

        return sections.joined(separator: "\n\n")
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
        <h1>\(language.text(.powerOfAttorneyTitle).htmlEscaped)</h1>
        <p>\(bodyText(in: language).htmlEscaped.replacingOccurrences(of: "\n", with: "<br><br>"))</p>
        <div class="signature">
        <p>\(signingPlace.htmlEscaped), \(formattedDate.htmlEscaped)</p>
        <div class="line">\(principalName.htmlEscaped)</div>
        <div class="line">\(agentName.htmlEscaped)</div>
        </div>
        </div>
        </body>
        </html>
        """
    }
}
