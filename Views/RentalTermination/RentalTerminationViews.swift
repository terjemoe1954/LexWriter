//
//  RentalTerminationViews.swift
//  LexWriter
//
//  Created by Codex on 03/09/2026.
//

import SwiftUI

struct RentalTerminationEditorView: View {
    let language: AppLanguage

    @State private var formData = RentalTerminationFormData()
    @State private var showingPreview = false
    @State private var showingWarningsAlert = false

    var body: some View {
        Form {
            Section(language.rentalTerminationText(.legalChecklistTitle)) {
                ForEach(language.rentalTerminationChecklist, id: \.self) { item in
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

            Section(language.rentalTerminationText(.landlordTitle)) {
                RentalTerminationPartyEditor(language: language, party: $formData.landlord)
            }

            Section(language.rentalTerminationText(.tenantTitle)) {
                RentalTerminationPartyEditor(language: language, party: $formData.tenant)
            }

            Section(language.rentalTerminationText(.terminationTermsTitle)) {
                TextField(language.rentalTerminationText(.propertyField), text: $formData.propertyAddress, axis: .vertical)
                    .lineLimit(2...4)
                TextField(language.rentalTerminationText(.terminationDateField), text: $formData.terminationDateText)
                TextField(language.rentalTerminationText(.moveOutDateField), text: $formData.moveOutDateText)
                TextField(language.rentalTerminationText(.noticeBasisField), text: $formData.noticeBasis, axis: .vertical)
                    .lineLimit(2...4)
                TextField(language.rentalTerminationText(.depositSettlementField), text: $formData.depositSettlement, axis: .vertical)
                    .lineLimit(2...4)
                TextField(language.rentalTerminationText(.keyReturnField), text: $formData.keyReturn, axis: .vertical)
                    .lineLimit(2...4)
            }

            Section(language.text(.dateAndPlace)) {
                TextField(language.text(.place), text: $formData.signingPlace)
                DatePicker(language.text(.date), selection: $formData.signingDate, displayedComponents: .date)
            }

            Section(language.text(.print)) {
                Button(language.rentalTerminationText(.previewButton)) {
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
        .navigationTitle(language.rentalTerminationText(.title))
        .sheet(isPresented: $showingPreview) {
            NavigationStack {
                RentalTerminationPreviewView(
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
        PrintCoordinator.present(markupText: formData.document.htmlDocument(in: language), jobName: "RentalTermination")
        #endif
    }

    private func saveDocumentAsPDF() {
        #if canImport(UIKit)
        PrintCoordinator.exportPDF(markupText: formData.document.htmlDocument(in: language), jobName: "RentalTermination")
        #endif
    }
}

private struct RentalTerminationPreviewView: View {
    let language: AppLanguage
    let document: RentalTerminationDocument
    let printAction: () -> Void
    let savePDFAction: () -> Void

    @Environment(\.dismiss) private var dismiss

    var body: some View {
        LegalPaperView(
            title: language.rentalTerminationText(.title),
            bodyText: document.bodyText(in: language),
            signingPlaceAndDate: "\(document.signingPlace), \(document.formattedDate)",
            firstSignature: document.landlord.name,
            secondSignature: document.tenant.name,
            language: language,
            printAction: printAction,
            savePDFAction: savePDFAction,
            dismissAction: { dismiss() }
        )
    }
}

private struct RentalTerminationPartyEditor: View {
    let language: AppLanguage
    @Binding var party: RentalParty

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
