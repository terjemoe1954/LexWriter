//
//  ContractModels.swift
//  LexWriter
//
//  Created by Terje Moe on 29/08/2026.
//

import Foundation

struct ContractParty: Equatable {
    var name = ""
    var address = ""
    var phone = ""
    var email = ""
}

struct ContractFormData {
    var partyOne = ContractParty()
    var partyTwo = ContractParty()
    var agreementTitle = ""
    var subject = ""
    var servicesOrGoods = ""
    var payment = ""
    var duration = ""
    var breachConsequences = ""
    var termination = ""
    var disputeResolution = ""
    var specialTerms = ""
    var signingPlace = ""
    var signingDate = Date()

    func blockingIssues(in language: AppLanguage) -> [ValidationMessage] {
        var messages: [ValidationMessage] = []

        if partyOne.name.trimmed.isEmpty || partyOne.address.trimmed.isEmpty {
            messages.append(.init(severity: .blocking, message: language.contractText(.blockingPartyOne)))
        }

        if partyTwo.name.trimmed.isEmpty || partyTwo.address.trimmed.isEmpty {
            messages.append(.init(severity: .blocking, message: language.contractText(.blockingPartyTwo)))
        }

        if agreementTitle.trimmed.isEmpty {
            messages.append(.init(severity: .blocking, message: language.contractText(.blockingTitle)))
        }

        if subject.trimmed.isEmpty || servicesOrGoods.trimmed.isEmpty {
            messages.append(.init(severity: .blocking, message: language.contractText(.blockingSubject)))
        }

        if payment.trimmed.isEmpty {
            messages.append(.init(severity: .blocking, message: language.contractText(.blockingPayment)))
        }

        if breachConsequences.trimmed.isEmpty {
            messages.append(.init(severity: .blocking, message: language.contractText(.blockingBreach)))
        }

        if signingPlace.trimmed.isEmpty {
            messages.append(.init(severity: .blocking, message: language.contractText(.blockingPlace)))
        }

        return messages
    }

    func warnings(in language: AppLanguage) -> [ValidationMessage] {
        var messages: [ValidationMessage] = []

        if duration.trimmed.isEmpty {
            messages.append(.init(severity: .warning, message: language.contractText(.warningDuration)))
        }

        if termination.trimmed.isEmpty {
            messages.append(.init(severity: .warning, message: language.contractText(.warningTermination)))
        }

        if disputeResolution.trimmed.isEmpty {
            messages.append(.init(severity: .warning, message: language.contractText(.warningDisputeResolution)))
        }

        if specialTerms.trimmed.isEmpty {
            messages.append(.init(severity: .warning, message: language.contractText(.warningSpecialTerms)))
        }

        return messages
    }

    var document: ContractDocument {
        ContractDocument(
            partyOne: partyOne,
            partyTwo: partyTwo,
            agreementTitle: agreementTitle.trimmed,
            subject: subject.trimmed,
            servicesOrGoods: servicesOrGoods.trimmed,
            payment: payment.trimmed,
            duration: duration.trimmed,
            breachConsequences: breachConsequences.trimmed,
            termination: termination.trimmed,
            disputeResolution: disputeResolution.trimmed,
            specialTerms: specialTerms.trimmed,
            signingPlace: signingPlace.trimmed,
            signingDate: signingDate
        )
    }
}

struct ContractDocument {
    let partyOne: ContractParty
    let partyTwo: ContractParty
    let agreementTitle: String
    let subject: String
    let servicesOrGoods: String
    let payment: String
    let duration: String
    let breachConsequences: String
    let termination: String
    let disputeResolution: String
    let specialTerms: String
    let signingPlace: String
    let signingDate: Date

    var formattedDate: String {
        signingDate.formatted(date: .long, time: .omitted)
    }

    func bodyText(in language: AppLanguage) -> String {
        let durationText = duration.isEmpty ? language.contractText(.defaultDuration) : duration
        let terminationText = termination.isEmpty ? language.contractText(.defaultTermination) : termination
        let disputeResolutionText = disputeResolution.isEmpty ? language.contractText(.defaultDisputeResolution) : disputeResolution
        let specialTermsText = specialTerms.isEmpty ? language.contractText(.defaultSpecialTerms) : specialTerms

        return [
            "\(language.contractText(.clauseOneTitle))\n\(language.contractText(.bodyIntroPrefix)) \(partyOne.name.trimmed), \(partyOne.address.trimmed), \(language.contractText(.bodyIntroMiddle)) \(partyTwo.name.trimmed), \(partyTwo.address.trimmed).",
            "\(language.contractText(.clauseTwoTitle))\n\(language.contractText(.bodySubjectPrefix)) \(subject).\n\(language.contractText(.bodyDeliveryPrefix)) \(servicesOrGoods).",
            "\(language.contractText(.clauseThreeTitle))\n\(language.contractText(.bodyPaymentPrefix)) \(payment).",
            "\(language.contractText(.clauseFourTitle))\n\(language.contractText(.bodyDurationPrefix)) \(durationText).",
            "\(language.contractText(.clauseFiveTitle))\n\(language.contractText(.bodyBreachPrefix)) \(breachConsequences).",
            "\(language.contractText(.clauseSixTitle))\n\(language.contractText(.bodyTerminationPrefix)) \(terminationText).",
            "\(language.contractText(.clauseSevenTitle))\n\(language.contractText(.bodyDisputePrefix)) \(disputeResolutionText).",
            "\(language.contractText(.clauseEightTitle))\n\(language.contractText(.bodySpecialTermsPrefix)) \(specialTermsText)",
            language.contractText(.bodyGoodFaith)
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
        <h1>\(agreementTitle.htmlEscaped)</h1>
        <p>\(bodyText(in: language).htmlEscaped.replacingOccurrences(of: "\n", with: "<br><br>"))</p>
        <div class="signature">
        <p>\(signingPlace.htmlEscaped), \(formattedDate.htmlEscaped)</p>
        <div class="line">\(partyOne.name.htmlEscaped)</div>
        <div class="line">\(partyTwo.name.htmlEscaped)</div>
        </div>
        </div>
        </body>
        </html>
        """
    }
}
