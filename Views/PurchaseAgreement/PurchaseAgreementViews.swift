//
//  PurchaseAgreementViews.swift
//  LexWriter
//
//  Created by Codex on 03/09/2026.
//

import SwiftUI

struct PurchaseAgreementEditorView: View {
    let language: AppLanguage

    @State private var formData = PurchaseAgreementFormData()
    @State private var showingPreview = false
    @State private var showingWarningsAlert = false

    var body: some View {
        Form {
            Section(language.purchaseText(.legalChecklistTitle)) {
                ForEach(language.purchaseChecklist, id: \.self) { item in
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

            Section(language.purchaseText(.sellerTitle)) {
                PurchasePartyEditor(language: language, party: $formData.seller)
            }

            Section(language.purchaseText(.buyerTitle)) {
                PurchasePartyEditor(language: language, party: $formData.buyer)
            }

            Section(language.purchaseText(.agreementTermsTitle)) {
                TextField(language.purchaseText(.itemField), text: $formData.itemDescription, axis: .vertical)
                    .lineLimit(2...4)
                TextField(language.purchaseText(.purchasePriceField), text: $formData.purchasePrice)
                TextField(language.purchaseText(.handoverDateField), text: $formData.handoverDate)
                TextField(language.purchaseText(.conditionField), text: $formData.conditionDescription, axis: .vertical)
                    .lineLimit(2...5)
                TextField(language.purchaseText(.paymentTermsField), text: $formData.paymentTerms, axis: .vertical)
                    .lineLimit(2...4)
                TextField(language.purchaseText(.defectsField), text: $formData.defectsAndClaims, axis: .vertical)
                    .lineLimit(2...5)
            }

            Section(language.text(.dateAndPlace)) {
                TextField(language.text(.place), text: $formData.signingPlace)
                DatePicker(language.text(.date), selection: $formData.signingDate, displayedComponents: .date)
            }

            Section(language.text(.print)) {
                Button(language.purchaseText(.previewButton)) {
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
        .navigationTitle(language.purchaseText(.title))
        .sheet(isPresented: $showingPreview) {
            NavigationStack {
                PurchaseAgreementPreviewView(
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
        PrintCoordinator.present(markupText: formData.document.htmlDocument(in: language), jobName: "PurchaseAgreement")
        #endif
    }

    private func saveDocumentAsPDF() {
        #if canImport(UIKit)
        PrintCoordinator.exportPDF(markupText: formData.document.htmlDocument(in: language), jobName: "PurchaseAgreement")
        #endif
    }
}

private struct PurchaseAgreementPreviewView: View {
    let language: AppLanguage
    let document: PurchaseAgreementDocument
    let printAction: () -> Void
    let savePDFAction: () -> Void

    @Environment(\.dismiss) private var dismiss

    var body: some View {
        LegalPaperView(
            title: language.purchaseText(.title),
            bodyText: document.bodyText(in: language),
            signingPlaceAndDate: "\(document.signingPlace), \(document.formattedDate)",
            firstSignature: document.seller.name,
            secondSignature: document.buyer.name,
            language: language,
            printAction: printAction,
            savePDFAction: savePDFAction,
            dismissAction: { dismiss() }
        )
    }
}

private struct PurchasePartyEditor: View {
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
