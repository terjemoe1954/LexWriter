//
//  LoanAgreementViews.swift
//  LexWriter
//
//  Created by Codex on 03/09/2026.
//

import SwiftUI

struct LoanAgreementEditorView: View {
    let language: AppLanguage

    @State private var formData = LoanAgreementFormData()
    @State private var showingPreview = false
    @State private var showingWarningsAlert = false

    var body: some View {
        Form {
            Section(language.loanAgreementText(.legalChecklistTitle)) {
                ForEach(language.loanAgreementChecklist, id: \.self) { item in
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

            Section(language.loanAgreementText(.lenderTitle)) {
                LoanPartyEditor(language: language, party: $formData.lender)
            }

            Section(language.loanAgreementText(.borrowerTitle)) {
                LoanPartyEditor(language: language, party: $formData.borrower)
            }

            Section(language.loanAgreementText(.loanTermsTitle)) {
                TextField(language.loanAgreementText(.amountField), text: $formData.amount)
                TextField(language.loanAgreementText(.disbursementDateField), text: $formData.disbursementDate)
                TextField(language.loanAgreementText(.dueDateField), text: $formData.dueDate)
                TextField(language.loanAgreementText(.repaymentField), text: $formData.repaymentTerms, axis: .vertical)
                    .lineLimit(2...4)
                TextField(language.loanAgreementText(.interestField), text: $formData.interestTerms, axis: .vertical)
                    .lineLimit(2...4)
                TextField(language.loanAgreementText(.latePaymentField), text: $formData.latePaymentTerms, axis: .vertical)
                    .lineLimit(2...4)
                TextField(language.loanAgreementText(.securityField), text: $formData.security, axis: .vertical)
                    .lineLimit(2...4)
                TextField(language.loanAgreementText(.purposeField), text: $formData.purpose, axis: .vertical)
                    .lineLimit(2...4)
            }

            Section(language.text(.dateAndPlace)) {
                TextField(language.text(.place), text: $formData.signingPlace)
                DatePicker(language.text(.date), selection: $formData.signingDate, displayedComponents: .date)
            }

            Section(language.text(.print)) {
                Button(language.loanAgreementText(.previewButton)) {
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
        .navigationTitle(language.loanAgreementText(.title))
        .sheet(isPresented: $showingPreview) {
            NavigationStack {
                LoanAgreementPreviewView(
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
        PrintCoordinator.present(markupText: formData.document.htmlDocument(in: language), jobName: "LoanAgreement")
        #endif
    }

    private func saveDocumentAsPDF() {
        #if canImport(UIKit)
        PrintCoordinator.exportPDF(markupText: formData.document.htmlDocument(in: language), jobName: "LoanAgreement")
        #endif
    }
}

private struct LoanAgreementPreviewView: View {
    let language: AppLanguage
    let document: LoanAgreementDocument
    let printAction: () -> Void
    let savePDFAction: () -> Void

    @Environment(\.dismiss) private var dismiss

    var body: some View {
        LegalPaperView(
            title: language.loanAgreementText(.title),
            bodyText: document.bodyText(in: language),
            signingPlaceAndDate: "\(document.signingPlace), \(document.formattedDate)",
            firstSignature: document.lender.name,
            secondSignature: document.borrower.name,
            language: language,
            printAction: printAction,
            savePDFAction: savePDFAction,
            dismissAction: { dismiss() }
        )
    }
}

private struct LoanPartyEditor: View {
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
