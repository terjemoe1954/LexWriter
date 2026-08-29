//
//  ContractViews.swift
//  LexWriter
//
//  Created by Terje Moe on 29/08/2026.
//

import SwiftUI

struct ContractEditorView: View {
    let language: AppLanguage

    @State private var formData = ContractFormData()
    @State private var showingPreview = false
    @State private var showingWarningsAlert = false

    var body: some View {
        Form {
            Section(language.contractText(.legalChecklistTitle)) {
                ForEach(language.contractChecklist, id: \.self) { item in
                    RequirementRow(title: item, isSatisfied: true)
                }
            }

            if formData.warnings(in: language).isEmpty == false {
                Section(language.text(.legalWarnings)) {
                    ForEach(formData.warnings(in: language)) { warning in
                        ValidationRow(message: warning)
                    }
                }
            }

            Section(language.contractText(.partyOneTitle)) {
                PartyEditor(language: language, party: $formData.partyOne)
            }

            Section(language.contractText(.partyTwoTitle)) {
                PartyEditor(language: language, party: $formData.partyTwo)
            }

            Section(language.contractText(.agreementDetailsTitle)) {
                TextField(language.contractText(.agreementTitleField), text: $formData.agreementTitle)
                TextField(language.contractText(.subjectField), text: $formData.subject, axis: .vertical)
                    .lineLimit(2...4)
                TextField(language.contractText(.deliveryField), text: $formData.servicesOrGoods, axis: .vertical)
                    .lineLimit(3...6)
                TextField(language.contractText(.paymentField), text: $formData.payment, axis: .vertical)
                    .lineLimit(2...4)
                TextField(language.contractText(.durationField), text: $formData.duration, axis: .vertical)
                    .lineLimit(2...4)
                TextField(language.contractText(.breachField), text: $formData.breachConsequences, axis: .vertical)
                    .lineLimit(2...4)
                TextField(language.contractText(.terminationField), text: $formData.termination, axis: .vertical)
                    .lineLimit(2...4)
                TextField(language.contractText(.disputeResolutionField), text: $formData.disputeResolution, axis: .vertical)
                    .lineLimit(2...4)
                TextField(language.contractText(.specialTermsField), text: $formData.specialTerms, axis: .vertical)
                    .lineLimit(3...6)
            }

            Section(language.text(.dateAndPlace)) {
                TextField(language.text(.place), text: $formData.signingPlace)
                DatePicker(language.text(.date), selection: $formData.signingDate, displayedComponents: .date)
            }

            Section(language.text(.print)) {
                Button(language.contractText(.previewButton)) {
                    presentPreview()
                }
                .disabled(formData.blockingIssues(in: language).isEmpty == false)

                if formData.blockingIssues(in: language).isEmpty == false {
                    ForEach(formData.blockingIssues(in: language)) { issue in
                        ValidationRow(message: issue)
                    }
                }
            }
        }
        .navigationTitle(language.text(.contractTitle))
        .sheet(isPresented: $showingPreview) {
            NavigationStack {
                ContractPreviewView(
                    language: language,
                    document: formData.document,
                    printAction: printDocument
                )
            }
        }
        .alert(language.text(.legalWarningsTitle), isPresented: $showingWarningsAlert) {
            Button(language.text(.showAnyway)) { showingPreview = true }
            Button(language.text(.cancel), role: .cancel) {}
        } message: {
            Text(formData.warnings(in: language).map(\.message).joined(separator: "\n\n"))
        }
    }

    private func presentPreview() {
        if formData.warnings(in: language).isEmpty {
            showingPreview = true
        } else {
            showingWarningsAlert = true
        }
    }

    private func printDocument() {
        #if canImport(UIKit)
        PrintCoordinator.present(markupText: formData.document.htmlDocument(in: language), jobName: "Contract")
        #endif
    }
}

private struct ContractPreviewView: View {
    let language: AppLanguage
    let document: ContractDocument
    let printAction: () -> Void

    @Environment(\.dismiss) private var dismiss

    var body: some View {
        LegalPaperView(
            title: document.agreementTitle,
            bodyText: document.bodyText(in: language),
            signingPlaceAndDate: "\(document.signingPlace), \(document.formattedDate)",
            firstSignature: document.partyOne.name,
            secondSignature: document.partyTwo.name,
            language: language,
            printAction: printAction,
            dismissAction: { dismiss() }
        )
    }
}

private struct PartyEditor: View {
    let language: AppLanguage
    @Binding var party: ContractParty

    var body: some View {
        TextField(language.text(.name), text: $party.name)
        TextField(language.text(.address), text: $party.address)
        TextField(language.text(.phone), text: $party.phone)
            .keyboardType(.phonePad)
        TextField(language.text(.email), text: $party.email)
            .keyboardType(.emailAddress)
            .textInputAutocapitalization(.never)
    }
}
