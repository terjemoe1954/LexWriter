//
//  NDAViews.swift
//  LexWriter
//
//  Created by Codex on 03/09/2026.
//

import SwiftUI

struct NDAEditorView: View {
    let language: AppLanguage

    @State private var formData = NDAFormData()
    @State private var showingPreview = false
    @State private var showingWarningsAlert = false

    var body: some View {
        Form {
            Section(language.ndaText(.legalChecklistTitle)) {
                ForEach(language.ndaChecklist, id: \.self) { item in
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

            Section(language.ndaText(.disclosingPartyTitle)) {
                NDAPartyEditor(language: language, party: $formData.disclosingParty)
            }

            Section(language.ndaText(.receivingPartyTitle)) {
                NDAPartyEditor(language: language, party: $formData.receivingParty)
            }

            Section(language.ndaText(.ndaTermsTitle)) {
                TextField(language.ndaText(.confidentialInfoField), text: $formData.confidentialInfo, axis: .vertical)
                    .lineLimit(2...5)
                TextField(language.ndaText(.purposeField), text: $formData.purpose, axis: .vertical)
                    .lineLimit(2...4)
                TextField(language.ndaText(.obligationsField), text: $formData.obligations, axis: .vertical)
                    .lineLimit(2...5)
                TextField(language.ndaText(.durationField), text: $formData.duration)
                TextField(language.ndaText(.exclusionsField), text: $formData.exclusions, axis: .vertical)
                    .lineLimit(2...4)
                TextField(language.ndaText(.returnField), text: $formData.returnMaterials, axis: .vertical)
                    .lineLimit(2...4)
                TextField(language.ndaText(.governingLawField), text: $formData.governingLaw, axis: .vertical)
                    .lineLimit(2...4)
            }

            Section(language.text(.dateAndPlace)) {
                TextField(language.text(.place), text: $formData.signingPlace)
                DatePicker(language.text(.date), selection: $formData.signingDate, displayedComponents: .date)
            }

            Section(language.text(.print)) {
                Button(language.ndaText(.previewButton)) {
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
        .navigationTitle(language.ndaText(.title))
        .sheet(isPresented: $showingPreview) {
            NavigationStack {
                NDAPreviewView(
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
        PrintCoordinator.present(markupText: formData.document.htmlDocument(in: language), jobName: "NDA")
        #endif
    }

    private func saveDocumentAsPDF() {
        #if canImport(UIKit)
        PrintCoordinator.exportPDF(markupText: formData.document.htmlDocument(in: language), jobName: "NDA")
        #endif
    }
}

private struct NDAPreviewView: View {
    let language: AppLanguage
    let document: NDADocument
    let printAction: () -> Void
    let savePDFAction: () -> Void

    @Environment(\.dismiss) private var dismiss

    var body: some View {
        LegalPaperView(
            title: language.ndaText(.title),
            bodyText: document.bodyText(in: language),
            signingPlaceAndDate: "\(document.signingPlace), \(document.formattedDate)",
            firstSignature: document.disclosingParty.name,
            secondSignature: document.receivingParty.name,
            language: language,
            printAction: printAction,
            savePDFAction: savePDFAction,
            dismissAction: { dismiss() }
        )
    }
}

private struct NDAPartyEditor: View {
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
