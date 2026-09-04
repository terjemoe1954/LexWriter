//
//  TestamentViews.swift
//  LexWriter
//
//  Created by Terje Moe on 29/08/2026.
//

import SwiftUI

struct TestamentEditorView: View {
    let language: AppLanguage

    @State private var formData = TestamentFormData()
    @State private var showingPreview = false
    @State private var showingWarningsAlert = false

    var body: some View {
        Form {
            Section(language.text(.signingRequirements)) {
                ForEach(TestamentFormData.signingRequirements(in: language)) { item in
                    RequirementRow(title: item.title, isSatisfied: item.isSatisfied)
                }
            }

            Section(language.text(.mustFillIn)) {
                ForEach(formData.completionRequirements(in: language)) { item in
                    RequirementRow(title: item.title, isSatisfied: item.isSatisfied)
                }
            }

            if formData.warnings(in: language).isEmpty == false {
                Section(language.text(.legalWarnings)) {
                    ForEach(formData.warnings(in: language)) { warning in
                        ValidationRow(message: warning)
                    }
                }
            }

            Section(language.text(.aboutYou)) {
                TextField(language.text(.fullName), text: $formData.testatorName)
                TextField(language.text(.address), text: $formData.testatorAddress)
                TextField(language.text(.phone), text: $formData.testatorPhone)
                    .keyboardType(.phonePad)
                TextField(language.text(.email), text: $formData.testatorEmail)
                    .keyboardType(.emailAddress)
                    .textInputAutocapitalization(.never)
            }

            Section(language.text(.familySituation)) {
                Toggle(language.text(.childrenToggle), isOn: $formData.hasChildren)
                Toggle(language.text(.spouseToggle), isOn: $formData.hasSpouseOrRegisteredPartner)
                Toggle(language.text(.cohabitantToggle), isOn: $formData.hasCohabitantWithInheritanceRights)
            }

            Section(language.text(.beneficiaries)) {
                ForEach($formData.beneficiaries) { $beneficiary in
                    BeneficiaryEditor(
                        language: language,
                        beneficiary: $beneficiary,
                        canDelete: formData.beneficiaries.count > 1
                    ) {
                        removeBeneficiary(id: beneficiary.id)
                    }
                }

                Button(language.text(.addBeneficiary)) {
                    formData.beneficiaries.append(BeneficiaryEntry())
                }
            }

            Section(language.text(.residueAndProvisions)) {
                TextField(language.text(.residuePlaceholder), text: $formData.residueClause, axis: .vertical)
                    .lineLimit(2...4)
                TextField(language.text(.specialProvisionsPlaceholder), text: $formData.specialProvisions, axis: .vertical)
                    .lineLimit(4...8)
            }

            Section(language.text(.dateAndPlace)) {
                TextField(language.text(.place), text: $formData.testamentPlace)
                DatePicker(language.text(.date), selection: $formData.testamentDate, displayedComponents: .date)
            }

            Section(language.text(.beforeSigning)) {
                Toggle(language.text(.signingNoticeOne), isOn: $formData.witnessesPresentTogetherConfirmed)
                Toggle(language.text(.signingNoticeTwo), isOn: $formData.witnessesKnowItsATestamentConfirmed)
                Toggle(language.text(.signingNoticeThree), isOn: $formData.witnessesAreEligibleConfirmed)
            }

            Section(language.text(.witnesses)) {
                Text(language.text(.witnessesPaperNotice))
                    .font(.footnote)
                    .foregroundStyle(.secondary)

                WitnessEditor(title: language.text(.witnessOne), language: language, witness: $formData.witnessOne)
                WitnessEditor(title: language.text(.witnessTwo), language: language, witness: $formData.witnessTwo)
            }

            Section(language.text(.print)) {
                Button(language.text(.showWill)) {
                    presentPreview()
                }
                .disabled(formData.blockingIssues(in: language).isEmpty == false)

                if formData.blockingIssues(in: language).isEmpty == false {
                    Text(language.text(.fillAllRequired))
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                }
            }

            Section(language.text(.important)) {
                Text(language.text(.importantNotice))
                    .font(.footnote)
                    .foregroundStyle(.secondary)
            }
        }
        .navigationTitle(language.text(.testamentTitle))
        .sheet(isPresented: $showingPreview) {
            NavigationStack {
                TestamentPreviewView(
                    language: language,
                    document: formData.generatedDocument,
                    printAction: printDocument,
                    savePDFAction: saveDocumentAsPDF
                )
            }
        }
        .alert(language.text(.legalWarningsTitle), isPresented: $showingWarningsAlert) {
            Button(language.text(.showAnyway)) {
                showingPreview = true
            }
            Button(language.text(.cancel), role: .cancel) {
            }
        } message: {
            Text(formData.warnings(in: language).map(\.message).joined(separator: "\n\n"))
        }
    }

    private func removeBeneficiary(id: UUID) {
        formData.beneficiaries.removeAll { $0.id == id }
        if formData.beneficiaries.isEmpty {
            formData.beneficiaries = [BeneficiaryEntry()]
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
        PrintCoordinator.present(markupText: formData.generatedDocument.htmlDocument, jobName: "Testament")
        #endif
    }

    private func saveDocumentAsPDF() {
        #if canImport(UIKit)
        PrintCoordinator.exportPDF(markupText: formData.generatedDocument.htmlDocument, jobName: "Testament")
        #endif
    }
}

struct TestamentPreviewView: View {
    let language: AppLanguage
    let document: TestamentDocument
    let printAction: () -> Void
    let savePDFAction: () -> Void

    @Environment(\.dismiss) private var dismiss

    private let paperColor = Color(red: 0.96, green: 0.92, blue: 0.84)
    private let paperBorderColor = Color(red: 0.55, green: 0.43, blue: 0.28)
    private let inkColor = Color(red: 0.16, green: 0.13, blue: 0.10)
    private let deskColor = Color(red: 0.82, green: 0.76, blue: 0.68)

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                Text("TESTAMENT")
                    .font(.system(size: 30, weight: .bold, design: .serif))
                    .tracking(3)

                Text(document.formattedBody)
                    .font(.system(size: 18, design: .serif))
                    .lineSpacing(8)

                VStack(alignment: .leading, spacing: 14) {
                    Text(language.text(.signatureAndDate))
                        .font(.headline)
                    SignatureLine(label: "\(document.testamentPlace), \(document.formattedDate)")
                    SignatureLine(label: language.text(.testatorSignature))
                }

                VStack(alignment: .leading, spacing: 14) {
                    Text(language.text(.witnessStatementTitle))
                        .font(.headline)
                    Text(document.witnessStatement)
                        .font(.system(size: 16, design: .serif))
                        .lineSpacing(6)
                    WitnessSignatureBlock(title: language.text(.witnessOne), witness: document.witnessOne)
                    WitnessSignatureBlock(title: language.text(.witnessTwo), witness: document.witnessTwo)
                }
            }
            .foregroundStyle(inkColor)
            .padding(28)
            .frame(maxWidth: 760, alignment: .leading)
            .background(
                RoundedRectangle(cornerRadius: 18)
                    .fill(paperColor)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 18)
                    .stroke(paperBorderColor, lineWidth: 1)
            )
            .padding()
        }
        .background(deskColor.ignoresSafeArea())
        .navigationTitle(language.text(.previewTitle))
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button(language.text(.close)) {
                    dismiss()
                }
                .accessibilityIdentifier("closePreviewButton")
            }

            ToolbarItem(placement: .automatic) {
                Button(language.text(.savePDFButton)) {
                    savePDFAction()
                }
                .accessibilityIdentifier("savePDFButton")
            }

            ToolbarItem(placement: .primaryAction) {
                Button(language.text(.printButton)) {
                    printAction()
                }
                .accessibilityIdentifier("printButton")
            }
        }
    }
}

struct BeneficiaryEditor: View {
    let language: AppLanguage
    @Binding var beneficiary: BeneficiaryEntry
    let canDelete: Bool
    let onDelete: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            TextField(language.text(.beneficiaryName), text: $beneficiary.name)
            TextField(language.text(.beneficiaryDisposition), text: $beneficiary.disposition, axis: .vertical)
                .lineLimit(2...4)

            if canDelete {
                Button(language.text(.removeBeneficiary), role: .destructive) {
                    onDelete()
                }
                .font(.footnote)
            }
        }
        .padding(.vertical, 4)
    }
}

struct WitnessEditor: View {
    let title: String
    let language: AppLanguage
    @Binding var witness: WitnessInfo

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.headline)
            TextField(language.text(.name), text: $witness.name)
            TextField(language.text(.address), text: $witness.address)
        }
        .padding(.vertical, 4)
    }
}

struct RequirementRow: View {
    let title: String
    let isSatisfied: Bool

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: isSatisfied ? "checkmark.seal.fill" : "exclamationmark.circle.fill")
                .foregroundStyle(isSatisfied ? .green : .orange)
            Text(title)
        }
    }
}

struct ValidationRow: View {
    let message: ValidationMessage

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: iconName)
                .foregroundStyle(iconColor)
            Text(message.message)
        }
    }

    private var iconName: String {
        switch message.severity {
        case .blocking:
            return "xmark.octagon.fill"
        case .warning:
            return "exclamationmark.triangle.fill"
        }
    }

    private var iconColor: Color {
        switch message.severity {
        case .blocking:
            return .red
        case .warning:
            return .orange
        }
    }
}

private struct SignatureLine: View {
    let label: String

    private let secondaryInkColor = Color(red: 0.38, green: 0.31, blue: 0.24)

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(label)
                .font(.subheadline)
                .foregroundStyle(secondaryInkColor)
            Rectangle()
                .fill(secondaryInkColor.opacity(0.45))
                .frame(height: 1)
        }
    }
}

private struct WitnessSignatureBlock: View {
    let title: String
    let witness: WitnessInfo

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.subheadline.weight(.semibold))
            SignatureLine(label: witness.name.trimmed.isEmpty ? "Navn" : witness.name)
            SignatureLine(label: witness.address.trimmed.isEmpty ? "Adresse" : witness.address)
            SignatureLine(label: "Underskrift")
        }
    }
}
