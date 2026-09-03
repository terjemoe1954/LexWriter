//
//  ReceiptViews.swift
//  LexWriter
//
//  Created by Codex on 03/09/2026.
//

import SwiftUI

struct ReceiptEditorView: View {
    let language: AppLanguage

    @State private var formData = ReceiptFormData()
    @State private var showingPreview = false
    @State private var showingWarningsAlert = false

    var body: some View {
        Form {
            Section(language.receiptText(.legalChecklistTitle)) {
                ForEach(language.receiptChecklist, id: \.self) { item in
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

            Section(language.receiptText(.issuerTitle)) {
                ReceiptPartyEditor(language: language, party: $formData.issuer)
            }

            Section(language.receiptText(.payerTitle)) {
                ReceiptPartyEditor(language: language, party: $formData.payer)
            }

            Section(language.receiptText(.receiptTermsTitle)) {
                TextField(language.receiptText(.receiptForField), text: $formData.receiptFor, axis: .vertical)
                    .lineLimit(2...4)
                TextField(language.receiptText(.amountField), text: $formData.amount)
                TextField(language.receiptText(.paymentDateField), text: $formData.paymentDateText)
                TextField(language.receiptText(.paymentMethodField), text: $formData.paymentMethod)
                TextField(language.receiptText(.notesField), text: $formData.notes, axis: .vertical)
                    .lineLimit(2...4)
            }

            Section(language.text(.dateAndPlace)) {
                TextField(language.text(.place), text: $formData.signingPlace)
                DatePicker(language.text(.date), selection: $formData.signingDate, displayedComponents: .date)
            }

            Section(language.text(.print)) {
                Button(language.receiptText(.previewButton)) {
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
        .navigationTitle(language.receiptText(.title))
        .sheet(isPresented: $showingPreview) {
            NavigationStack {
                ReceiptPreviewView(
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
        PrintCoordinator.present(markupText: formData.document.htmlDocument(in: language), jobName: "Receipt")
        #endif
    }

    private func saveDocumentAsPDF() {
        #if canImport(UIKit)
        PrintCoordinator.exportPDF(markupText: formData.document.htmlDocument(in: language), jobName: "Receipt")
        #endif
    }
}

private struct ReceiptPreviewView: View {
    let language: AppLanguage
    let document: ReceiptDocument
    let printAction: () -> Void
    let savePDFAction: () -> Void

    @Environment(\.dismiss) private var dismiss

    var body: some View {
        LegalPaperView(
            title: language.receiptText(.title),
            bodyText: document.bodyText(in: language),
            signingPlaceAndDate: "\(document.signingPlace), \(document.formattedDate)",
            firstSignature: document.issuer.name,
            secondSignature: document.payer.name,
            language: language,
            printAction: printAction,
            savePDFAction: savePDFAction,
            dismissAction: { dismiss() }
        )
    }
}

private struct ReceiptPartyEditor: View {
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
