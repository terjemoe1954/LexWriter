//
//  DebtInstrumentViews.swift
//  LexWriter
//
//  Created by Codex on 29/08/2026.
//

import SwiftUI

struct DebtInstrumentEditorView: View {
    let language: AppLanguage

    @State private var formData = DebtInstrumentFormData()
    @State private var showingPreview = false
    @State private var showingWarningsAlert = false

    var body: some View {
        Form {
            Section(language.debtText(.legalChecklistTitle)) {
                ForEach(language.debtChecklist, id: \.self) { item in
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

            Section(language.debtText(.creditorTitle)) {
                DebtPartyEditor(language: language, party: $formData.creditor)
            }

            Section(language.debtText(.debtorTitle)) {
                DebtPartyEditor(language: language, party: $formData.debtor)
            }

            Section(language.debtText(.debtTermsTitle)) {
                TextField(language.debtText(.principalAmountField), text: $formData.principalAmount)
                TextField(language.debtText(.issueDateField), text: $formData.issueDateText)
                TextField(language.debtText(.dueDateField), text: $formData.dueDateText)
                TextField(language.debtText(.interestField), text: $formData.interestTerms, axis: .vertical)
                    .lineLimit(2...4)
                TextField(language.debtText(.repaymentField), text: $formData.repaymentTerms, axis: .vertical)
                    .lineLimit(2...4)
                TextField(language.debtText(.defaultField), text: $formData.defaultConsequences, axis: .vertical)
                    .lineLimit(2...4)
                TextField(language.debtText(.collateralField), text: $formData.collateral, axis: .vertical)
                    .lineLimit(2...4)
            }

            Section(language.text(.dateAndPlace)) {
                TextField(language.text(.place), text: $formData.signingPlace)
                DatePicker(language.text(.date), selection: $formData.signingDate, displayedComponents: .date)
            }

            Section(language.text(.print)) {
                Button(language.debtText(.previewButton)) {
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
        .navigationTitle(language.debtText(.title))
        .sheet(isPresented: $showingPreview) {
            NavigationStack {
                DebtInstrumentPreviewView(
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
        PrintCoordinator.present(markupText: formData.document.htmlDocument(in: language), jobName: "DebtInstrument")
        #endif
    }

    private func saveDocumentAsPDF() {
        #if canImport(UIKit)
        PrintCoordinator.exportPDF(markupText: formData.document.htmlDocument(in: language), jobName: "DebtInstrument")
        #endif
    }
}

private struct DebtInstrumentPreviewView: View {
    let language: AppLanguage
    let document: DebtInstrumentDocument
    let printAction: () -> Void
    let savePDFAction: () -> Void

    @Environment(\.dismiss) private var dismiss

    var body: some View {
        LegalPaperView(
            title: language.debtText(.title),
            bodyText: document.bodyText(in: language),
            signingPlaceAndDate: "\(document.signingPlace), \(document.formattedDate)",
            firstSignature: document.creditor.name,
            secondSignature: document.debtor.name,
            language: language,
            printAction: printAction,
            savePDFAction: savePDFAction,
            dismissAction: { dismiss() }
        )
    }
}

private struct DebtPartyEditor: View {
    let language: AppLanguage
    @Binding var party: DebtParty

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
