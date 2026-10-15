//
//  ReceiptViews.swift
//  LexWriter
//
//  Created by Codex on 03/09/2026.
//

import SwiftUI

struct ReceiptEditorView: View {
    let language: AppLanguage
    private let draftStore: ReceiptDraftStore

    @State private var formData: ReceiptFormData
    @State private var showingPreview = false
    @State private var showingWarningsAlert = false
    @State private var showingClearDraftConfirmation = false
    @State private var showingPDFExportError = false
    @State private var restoredDraft: Bool
    @FocusState private var signingPlaceIsFocused: Bool

    init(language: AppLanguage, draftStore: ReceiptDraftStore = ReceiptDraftStore()) {
        self.language = language
        self.draftStore = draftStore
        let savedDraft = draftStore.load()
        _formData = State(initialValue: savedDraft ?? ReceiptFormData())
        _restoredDraft = State(initialValue: savedDraft != nil)
    }

    var body: some View {
        Form {
            Section(language.receiptText(.guideTitle)) {
                Label(language.receiptText(.guidePurpose), systemImage: "checkmark.seal")
                Label(language.receiptText(.guidePreparation), systemImage: "list.clipboard")
                Label(language.receiptText(.guideResult), systemImage: "doc.text")
                Label(language.receiptText(.businessScopeWarning), systemImage: "building.2.crop.circle")
                Label(
                    restoredDraft
                        ? language.receiptText(.draftRestoredMessage)
                        : language.receiptText(.draftSavedMessage),
                    systemImage: restoredDraft ? "arrow.counterclockwise.circle" : "internaldrive"
                )

                if formData.hasDraftContent {
                    Button(language.receiptText(.clearDraftButton), role: .destructive) {
                        showingClearDraftConfirmation = true
                    }
                }
            }

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

            Section {
                ReceiptPartyEditor(language: language, party: $formData.issuer)
            } header: {
                Text(language.receiptText(.issuerTitle))
            } footer: {
                Text(language.receiptText(.issuerHelp))
            }

            Section {
                ReceiptPartyEditor(language: language, party: $formData.payer)
            } header: {
                Text(language.receiptText(.payerTitle))
            } footer: {
                Text(language.receiptText(.payerHelp))
            }

            Section(language.receiptText(.receiptTermsTitle)) {
                ReceiptGuidedField(
                    label: language.receiptText(.receiptForField),
                    requirement: language.receiptText(.requiredMarker),
                    example: language.receiptText(.receiptForExample),
                    text: $formData.receiptFor,
                    axis: .vertical
                )
                ReceiptGuidedField(
                    label: language.receiptText(.amountField),
                    requirement: language.receiptText(.requiredMarker),
                    example: language.receiptText(.amountExample),
                    text: $formData.amount
                )
                .keyboardType(.numbersAndPunctuation)
                ReceiptGuidedField(
                    label: language.receiptText(.paymentDateField),
                    requirement: language.receiptText(.requiredMarker),
                    example: language.receiptText(.paymentDateExample),
                    text: $formData.paymentDateText
                )
                ReceiptGuidedField(
                    label: language.receiptText(.paymentMethodField),
                    requirement: language.receiptText(.optionalMarker),
                    example: language.receiptText(.paymentMethodExample),
                    text: $formData.paymentMethod
                )
                ReceiptGuidedField(
                    label: language.receiptText(.notesField),
                    requirement: language.receiptText(.optionalMarker),
                    example: language.receiptText(.notesExample),
                    text: $formData.notes,
                    axis: .vertical,
                    onTab: { signingPlaceIsFocused = true }
                )
            }

            Section(language.text(.dateAndPlace)) {
                ReceiptGuidedField(
                    label: language.text(.place),
                    requirement: language.receiptText(.requiredMarker),
                    example: language.receiptText(.signingPlaceExample),
                    text: $formData.signingPlace,
                    focus: $signingPlaceIsFocused
                )
                VStack(alignment: .leading, spacing: 6) {
                    DatePicker(language.text(.date), selection: $formData.signingDate, displayedComponents: .date)
                    Text(language.receiptText(.signingDateHelp))
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
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
        .onChange(of: formData) { _, updatedFormData in
            draftStore.save(updatedFormData)
            restoredDraft = false
        }
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
        .confirmationDialog(
            language.receiptText(.clearDraftTitle),
            isPresented: $showingClearDraftConfirmation,
            titleVisibility: .visible
        ) {
            Button(language.receiptText(.clearDraftConfirm), role: .destructive) {
                draftStore.clear()
                formData = ReceiptFormData()
                restoredDraft = false
            }
            Button(language.text(.cancel), role: .cancel) {}
        } message: {
            Text(language.receiptText(.clearDraftMessage))
        }
        .alert(language.receiptText(.pdfExportErrorTitle), isPresented: $showingPDFExportError) {
            Button(language.text(.close), role: .cancel) {}
        } message: {
            Text(language.receiptText(.pdfExportErrorMessage))
        }
    }

    private func presentPreview() {
        if formData.warnings(in: language).isEmpty {
            showingPreview = true
        } else {
            showingWarningsAlert = true
        }
    }

    private func printDocument(option: DocumentOutputOption) {
        #if canImport(UIKit)
        let markup = PrintCoordinator.markup(for: option) { outputLanguage in
            formData.document.htmlDocument(in: outputLanguage)
        }
        PrintCoordinator.present(markupText: markup, jobName: "Receipt")
        #endif
    }

    private func saveDocumentAsPDF(option: DocumentOutputOption) {
        #if canImport(UIKit)
        let markup = PrintCoordinator.markup(for: option) { outputLanguage in
            formData.document.htmlDocument(in: outputLanguage)
        }
        let jobName = option.previewLanguage.receiptText(.title)
        if PrintCoordinator.exportPDF(markupText: markup, jobName: jobName) == false {
            showingPDFExportError = true
        }
        #endif
    }
}

private struct ReceiptPreviewView: View {
    let language: AppLanguage
    let document: ReceiptDocument
    let printAction: (DocumentOutputOption) -> Void
    let savePDFAction: (DocumentOutputOption) -> Void

    @Environment(\.dismiss) private var dismiss

    var body: some View {
        LegalPaperView(
            title: { outputLanguage in outputLanguage.receiptText(.title) },
            bodyText: { outputLanguage in document.bodyText(in: outputLanguage) },
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
        ReceiptGuidedField(
            label: language.text(.name),
            requirement: language.receiptText(.requiredMarker),
            example: language.receiptText(.nameExample),
            text: $party.name
        )
        ReceiptGuidedField(
            label: language.text(.address),
            requirement: language.receiptText(.requiredMarker),
            example: language.receiptText(.addressExample),
            text: $party.address,
            axis: .vertical
        )
        ReceiptGuidedField(
            label: language.text(.phone),
            requirement: language.receiptText(.optionalMarker),
            example: language.receiptText(.phoneExample),
            text: $party.phone
        )
            .keyboardType(.phonePad)
        ReceiptGuidedField(
            label: language.text(.email),
            requirement: language.receiptText(.optionalMarker),
            example: language.receiptText(.emailExample),
            text: $party.email
        )
            .keyboardType(.emailAddress)
            .textInputAutocapitalization(.never)
    }
}

private struct ReceiptGuidedField: View {
    let label: String
    let requirement: String
    let example: String
    @Binding var text: String
    var axis: Axis = .horizontal
    var focus: FocusState<Bool>.Binding?
    var onTab: (() -> Void)?

    init(
        label: String,
        requirement: String,
        example: String,
        text: Binding<String>,
        axis: Axis = .horizontal,
        focus: FocusState<Bool>.Binding? = nil,
        onTab: (() -> Void)? = nil
    ) {
        self.label = label
        self.requirement = requirement
        self.example = example
        _text = text
        self.axis = axis
        self.focus = focus
        self.onTab = onTab
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            ViewThatFits(in: .horizontal) {
                HStack(alignment: .firstTextBaseline) {
                    fieldLabel
                    Spacer()
                    requirementLabel
                }

                VStack(alignment: .leading, spacing: 2) {
                    fieldLabel
                    requirementLabel
                }
            }
            .accessibilityHidden(true)

            textField
            .lineLimit(axis == .vertical ? 2...4 : 1...1)
            .accessibilityLabel(label)
            .accessibilityHint("\(requirement). \(example)")
            .onKeyPress("\t") {
                guard let onTab else { return .ignored }
                onTab()
                return .handled
            }
        }
    }

    @ViewBuilder
    private var textField: some View {
        if let focus {
            baseTextField
                .focused(focus)
        } else {
            baseTextField
        }
    }

    private var baseTextField: some View {
        TextField(text: $text, prompt: Text(example), axis: axis) {
            Text(label)
        }
    }

    private var fieldLabel: some View {
        Text(label)
            .font(.subheadline.weight(.semibold))
    }

    private var requirementLabel: some View {
        Text(requirement)
            .font(.caption)
            .foregroundStyle(.secondary)
    }
}
