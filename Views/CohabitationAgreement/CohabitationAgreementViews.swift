//
//  CohabitationAgreementViews.swift
//  LexWriter
//
//  Created by Codex on 29/08/2026.
//

import SwiftUI

struct CohabitationAgreementEditorView: View {
    let language: AppLanguage

    @State private var formData = CohabitationAgreementFormData()
    @State private var showingPreview = false
    @State private var showingWarningsAlert = false

    var body: some View {
        Form {
            Section(language.cohabitationText(.legalChecklistTitle)) {
                ForEach(language.cohabitationChecklist, id: \.self) { item in
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

            Section(language.cohabitationText(.partnerOneTitle)) {
                CohabitationPartyEditor(language: language, party: $formData.partnerOne)
            }

            Section(language.cohabitationText(.partnerTwoTitle)) {
                CohabitationPartyEditor(language: language, party: $formData.partnerTwo)
            }

            Section(language.cohabitationText(.agreementTermsTitle)) {
                TextField(language.cohabitationText(.sharedHomeField), text: $formData.sharedHomeAddress)
                TextField(language.cohabitationText(.ownershipField), text: $formData.ownershipDistribution, axis: .vertical)
                    .lineLimit(2...4)
                TextField(language.cohabitationText(.separateAssetsField), text: $formData.separateAssets, axis: .vertical)
                    .lineLimit(2...4)
                TextField(language.cohabitationText(.sharedExpensesField), text: $formData.sharedExpenses, axis: .vertical)
                    .lineLimit(2...4)
                TextField(language.cohabitationText(.debtResponsibilityField), text: $formData.debtResponsibility, axis: .vertical)
                    .lineLimit(2...4)
                TextField(language.cohabitationText(.breakupField), text: $formData.breakupHandling, axis: .vertical)
                    .lineLimit(3...5)
                TextField(language.cohabitationText(.specialTermsField), text: $formData.specialTerms, axis: .vertical)
                    .lineLimit(2...5)
            }

            Section(language.text(.dateAndPlace)) {
                TextField(language.text(.place), text: $formData.signingPlace)
                DatePicker(language.text(.date), selection: $formData.signingDate, displayedComponents: .date)
            }

            Section(language.text(.print)) {
                Button(language.cohabitationText(.previewButton)) {
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
        .navigationTitle(language.cohabitationText(.title))
        .sheet(isPresented: $showingPreview) {
            NavigationStack {
                CohabitationAgreementPreviewView(
                    language: language,
                    document: formData.document,
                    printAction: printDocument,
                    savePDFAction: saveDocumentAsPDF
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
        PrintCoordinator.present(markupText: formData.document.htmlDocument(in: language), jobName: "CohabitationAgreement")
        #endif
    }

    private func saveDocumentAsPDF() {
        #if canImport(UIKit)
        PrintCoordinator.exportPDF(markupText: formData.document.htmlDocument(in: language), jobName: "CohabitationAgreement")
        #endif
    }
}

private struct CohabitationAgreementPreviewView: View {
    let language: AppLanguage
    let document: CohabitationAgreementDocument
    let printAction: () -> Void
    let savePDFAction: () -> Void

    @Environment(\.dismiss) private var dismiss

    var body: some View {
        LegalPaperView(
            title: language.cohabitationText(.title),
            bodyText: document.bodyText(in: language),
            signingPlaceAndDate: "\(document.signingPlace), \(document.formattedDate)",
            firstSignature: document.partnerOne.name,
            secondSignature: document.partnerTwo.name,
            language: language,
            printAction: printAction,
            savePDFAction: savePDFAction,
            dismissAction: { dismiss() }
        )
    }
}

private struct CohabitationPartyEditor: View {
    let language: AppLanguage
    @Binding var party: CohabitationParty

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
