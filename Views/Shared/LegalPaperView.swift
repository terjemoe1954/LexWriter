//
//  LegalPaperView.swift
//  LexWriter
//
//  Created by Terje Moe on 29/08/2026.
//

import SwiftUI

struct LegalPaperView: View {
    let title: String
    let bodyText: String
    let signingPlaceAndDate: String
    let firstSignature: String
    let secondSignature: String
    let language: AppLanguage
    let printAction: () -> Void
    let savePDFAction: () -> Void
    let dismissAction: () -> Void

    private let paperColor = Color(red: 0.96, green: 0.92, blue: 0.84)
    private let paperBorderColor = Color(red: 0.55, green: 0.43, blue: 0.28)
    private let inkColor = Color(red: 0.16, green: 0.13, blue: 0.10)
    private let secondaryInkColor = Color(red: 0.38, green: 0.31, blue: 0.24)
    private let deskColor = Color(red: 0.82, green: 0.76, blue: 0.68)

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                Text(title.uppercased())
                    .font(.system(size: 30, weight: .bold, design: .serif))
                    .tracking(3)

                Text(bodyText)
                    .font(.system(size: 18, design: .serif))
                    .lineSpacing(8)

                VStack(alignment: .leading, spacing: 14) {
                    Text(language.text(.signatureAndDate))
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
        .navigationTitle(language.text(.previewTitle))
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button(language.text(.close)) {
                    dismissAction()
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
