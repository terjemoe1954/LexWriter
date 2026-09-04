//
//  PowerOfAttorneyViews.swift
//  LexWriter
//
//  Created by Terje Moe on 29/08/2026.
//

import SwiftUI

struct PowerOfAttorneyEditorView: View {
    let language: AppLanguage

    @State private var formData = PowerOfAttorneyFormData()
    @State private var showingPreview = false
    @State private var showingWarningsAlert = false

    var body: some View {
        Form {
            Section(language.powerOfAttorneyText(.legalChecklistTitle)) {
                ForEach(language.powerOfAttorneyChecklist, id: \.self) { item in
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

            Section(language.powerOfAttorneyText(.principalTitle)) {
                TextField(language.text(.fullName), text: $formData.principalName)
                TextField(language.text(.address), text: $formData.principalAddress)
                TextField(language.text(.phone), text: $formData.principalPhone)
                    .keyboardType(.phonePad)
                TextField(language.text(.email), text: $formData.principalEmail)
                    .keyboardType(.emailAddress)
                    .textInputAutocapitalization(.never)
            }

            Section(language.powerOfAttorneyText(.agentTitle)) {
                TextField(language.text(.fullName), text: $formData.agentName)
                TextField(language.text(.address), text: $formData.agentAddress)
            }

            Section(language.powerOfAttorneyText(.mandateTitle)) {
                TextField(language.powerOfAttorneyText(.purposeField), text: $formData.authorizationPurpose, axis: .vertical)
                    .lineLimit(2...4)
                TextField(language.powerOfAttorneyText(.scopeField), text: $formData.mandateScope, axis: .vertical)
                    .lineLimit(3...6)
                TextField(language.powerOfAttorneyText(.restrictionsField), text: $formData.restrictions, axis: .vertical)
                    .lineLimit(2...5)
                TextField(language.powerOfAttorneyText(.validFromField), text: $formData.validFrom)
                TextField(language.powerOfAttorneyText(.validUntilField), text: $formData.validUntil)
                TextField(language.powerOfAttorneyText(.revocationField), text: $formData.revocationTerms, axis: .vertical)
                    .lineLimit(2...4)
            }

            Section(language.text(.dateAndPlace)) {
                TextField(language.text(.place), text: $formData.signingPlace)
                DatePicker(language.text(.date), selection: $formData.signingDate, displayedComponents: .date)
            }

            Section(language.text(.print)) {
                Button(language.powerOfAttorneyText(.previewButton)) {
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
        .navigationTitle(language.text(.powerOfAttorneyTitle))
        .sheet(isPresented: $showingPreview) {
            NavigationStack {
                PowerOfAttorneyPreviewView(
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
        PrintCoordinator.present(markupText: formData.document.htmlDocument(in: language), jobName: "PowerOfAttorney")
        #endif
    }

    private func saveDocumentAsPDF() {
        #if canImport(UIKit)
        PrintCoordinator.exportPDF(markupText: formData.document.htmlDocument(in: language), jobName: "PowerOfAttorney")
        #endif
    }
}

private struct PowerOfAttorneyPreviewView: View {
    let language: AppLanguage
    let document: PowerOfAttorneyDocument
    let printAction: () -> Void
    let savePDFAction: () -> Void

    @Environment(\.dismiss) private var dismiss

    var body: some View {
        LegalPaperView(
            title: language.text(.powerOfAttorneyTitle),
            bodyText: document.bodyText(in: language),
            signingPlaceAndDate: "\(document.signingPlace), \(document.formattedDate)",
            firstSignature: document.principalName,
            secondSignature: document.agentName,
            language: language,
            printAction: printAction,
            savePDFAction: savePDFAction,
            dismissAction: { dismiss() }
        )
    }
}
