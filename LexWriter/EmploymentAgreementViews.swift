//
//  EmploymentAgreementViews.swift
//  LexWriter
//
//  Created by Codex on 03/09/2026.
//

import SwiftUI

struct EmploymentAgreementEditorView: View {
    let language: AppLanguage

    @State private var formData = EmploymentAgreementFormData()
    @State private var showingPreview = false
    @State private var showingWarningsAlert = false

    var body: some View {
        Form {
            Section(language.employmentAgreementText(.legalChecklistTitle)) {
                ForEach(language.employmentAgreementChecklist, id: \.self) { item in
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

            Section(language.employmentAgreementText(.employerTitle)) {
                EmploymentPartyEditor(language: language, party: $formData.employer)
            }

            Section(language.employmentAgreementText(.employeeTitle)) {
                EmploymentPartyEditor(language: language, party: $formData.employee)
            }

            Section(language.employmentAgreementText(.employmentTermsTitle)) {
                TextField(language.employmentAgreementText(.positionField), text: $formData.positionTitle)
                TextField(language.employmentAgreementText(.dutiesField), text: $formData.duties, axis: .vertical)
                    .lineLimit(2...4)
                TextField(language.employmentAgreementText(.startDateField), text: $formData.startDate)
                TextField(language.employmentAgreementText(.workplaceField), text: $formData.workplace)
                TextField(language.employmentAgreementText(.salaryField), text: $formData.salary)
                TextField(language.employmentAgreementText(.workingHoursField), text: $formData.workingHours, axis: .vertical)
                    .lineLimit(2...4)
                TextField(language.employmentAgreementText(.probationField), text: $formData.probationPeriod)
                TextField(language.employmentAgreementText(.terminationField), text: $formData.terminationNotice, axis: .vertical)
                    .lineLimit(2...4)
                TextField(language.employmentAgreementText(.confidentialityField), text: $formData.confidentialityTerms, axis: .vertical)
                    .lineLimit(2...4)
            }

            Section(language.text(.dateAndPlace)) {
                TextField(language.text(.place), text: $formData.signingPlace)
                DatePicker(language.text(.date), selection: $formData.signingDate, displayedComponents: .date)
            }

            Section(language.text(.print)) {
                Button(language.employmentAgreementText(.previewButton)) {
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
        .navigationTitle(language.employmentAgreementText(.title))
        .sheet(isPresented: $showingPreview) {
            NavigationStack {
                EmploymentAgreementPreviewView(
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
        PrintCoordinator.present(markupText: formData.document.htmlDocument(in: language), jobName: "EmploymentAgreement")
        #endif
    }

    private func saveDocumentAsPDF() {
        #if canImport(UIKit)
        PrintCoordinator.exportPDF(markupText: formData.document.htmlDocument(in: language), jobName: "EmploymentAgreement")
        #endif
    }
}

private struct EmploymentAgreementPreviewView: View {
    let language: AppLanguage
    let document: EmploymentAgreementDocument
    let printAction: () -> Void
    let savePDFAction: () -> Void

    @Environment(\.dismiss) private var dismiss

    var body: some View {
        LegalPaperView(
            title: language.employmentAgreementText(.title),
            bodyText: document.bodyText(in: language),
            signingPlaceAndDate: "\(document.signingPlace), \(document.formattedDate)",
            firstSignature: document.employer.name,
            secondSignature: document.employee.name,
            language: language,
            printAction: printAction,
            savePDFAction: savePDFAction,
            dismissAction: { dismiss() }
        )
    }
}

private struct EmploymentPartyEditor: View {
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
