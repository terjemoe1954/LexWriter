//
//  LegalPaperView.swift
//  LexWriter
//
//  Created by Terje Moe on 29/08/2026.
//

import SwiftUI

enum DocumentOutputOption: String, CaseIterable, Identifiable {
    case norwegian
    case english
    case thai
    case norwegianAndEnglish
    case norwegianAndThai

    var id: String { rawValue }

    var displayName: String {
        switch self {
        case .norwegian:
            return "Norsk"
        case .english:
            return "English"
        case .thai:
            return "ไทย"
        case .norwegianAndEnglish:
            return "Norsk + English"
        case .norwegianAndThai:
            return "Norsk + ไทย"
        }
    }

    var languages: [AppLanguage] {
        switch self {
        case .norwegian:
            return [.norwegian]
        case .english:
            return [.english]
        case .thai:
            return [.thai]
        case .norwegianAndEnglish:
            return [.norwegian, .english]
        case .norwegianAndThai:
            return [.norwegian, .thai]
        }
    }

    var previewLanguage: AppLanguage {
        languages.first ?? .norwegian
    }

    static func defaultOption(for language: AppLanguage) -> DocumentOutputOption {
        switch language {
        case .norwegian:
            return .norwegian
        case .english:
            return .english
        case .thai:
            return .thai
        }
    }
}

struct LegalPaperView: View {
    let title: (AppLanguage) -> String
    let bodyText: (AppLanguage) -> String
    let signingPlaceAndDate: String
    let firstSignature: String
    let secondSignature: String
    let language: AppLanguage
    let printAction: (DocumentOutputOption) -> Void
    let savePDFAction: (DocumentOutputOption) -> Void
    let dismissAction: () -> Void

    @State private var outputOption: DocumentOutputOption

    private let paperColor = Color(red: 0.96, green: 0.92, blue: 0.84)
    private let paperBorderColor = Color(red: 0.55, green: 0.43, blue: 0.28)
    private let inkColor = Color(red: 0.16, green: 0.13, blue: 0.10)
    private let secondaryInkColor = Color(red: 0.38, green: 0.31, blue: 0.24)
    private let deskColor = Color(red: 0.82, green: 0.76, blue: 0.68)

    init(
        title: @escaping (AppLanguage) -> String,
        bodyText: @escaping (AppLanguage) -> String,
        signingPlaceAndDate: String,
        firstSignature: String,
        secondSignature: String,
        language: AppLanguage,
        printAction: @escaping (DocumentOutputOption) -> Void,
        savePDFAction: @escaping (DocumentOutputOption) -> Void,
        dismissAction: @escaping () -> Void
    ) {
        self.title = title
        self.bodyText = bodyText
        self.signingPlaceAndDate = signingPlaceAndDate
        self.firstSignature = firstSignature
        self.secondSignature = secondSignature
        self.language = language
        self.printAction = printAction
        self.savePDFAction = savePDFAction
        self.dismissAction = dismissAction
        _outputOption = State(initialValue: .defaultOption(for: language))
    }

    private var previewLanguage: AppLanguage {
        outputOption.previewLanguage
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                Text(title(previewLanguage).uppercased())
                    .font(.system(.largeTitle, design: .serif, weight: .bold))
                    .tracking(3)
                    .accessibilityAddTraits(.isHeader)

                Text(bodyText(previewLanguage))
                    .font(.system(.body, design: .serif))
                    .lineSpacing(8)

                VStack(alignment: .leading, spacing: 14) {
                    Text(previewLanguage.text(.signatureAndDate))
                        .font(.headline)
                    LegalSignatureLine(label: signingPlaceAndDate)
                    LegalSignatureLine(label: firstSignature)
                    LegalSignatureLine(label: secondSignature)
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
        .navigationTitle(previewLanguage.text(.previewTitle))
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button(language.text(.close)) {
                    dismissAction()
                }
                .accessibilityIdentifier("closePreviewButton")
            }

            ToolbarItem(placement: .automatic) {
                Menu {
                    Picker(language.documentLanguageLabel, selection: $outputOption) {
                        ForEach(DocumentOutputOption.allCases) { option in
                            Text(option.displayName).tag(option)
                        }
                    }
                } label: {
                    Label(outputOption.displayName, systemImage: "globe")
                }
                .accessibilityIdentifier("documentLanguageMenu")
            }

            ToolbarItem(placement: .automatic) {
                Button(language.text(.savePDFButton)) {
                    savePDFAction(outputOption)
                }
                .accessibilityIdentifier("savePDFButton")
            }

            ToolbarItem(placement: .primaryAction) {
                Button(language.text(.printButton)) {
                    printAction(outputOption)
                }
                .accessibilityIdentifier("printButton")
            }
        }
    }
}

extension AppLanguage {
    var documentLanguageLabel: String {
        switch self {
        case .norwegian:
            return "Dokumentspråk"
        case .english:
            return "Document language"
        case .thai:
            return "ภาษาของเอกสาร"
        }
    }
}

private struct LegalSignatureLine: View {
    let label: String

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

    private let secondaryInkColor = Color(red: 0.38, green: 0.31, blue: 0.24)
}
