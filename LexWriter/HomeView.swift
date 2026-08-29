//
//  HomeView.swift
//  LexWriter
//
//  Created by Terje Moe on 28/08/2026.
//

import SwiftUI

struct HomeView: View {
    @State private var selectedLanguage: AppLanguage = .norwegian
    @AppStorage("preferredAppearance") private var preferredAppearance = AppAppearance.system.rawValue

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    languagePicker
                    heroSection
                    documentSection
                }
                .padding(20)
            }
            .background(backgroundView)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink {
                        SettingsView(language: selectedLanguage)
                    } label: {
                        Image(systemName: "gearshape.fill")
                            .foregroundStyle(Color.white.opacity(0.88))
                    }
                    .accessibilityLabel(selectedLanguage.text(.settings))
                }
            }
        }
        .preferredColorScheme(AppAppearance(rawValue: preferredAppearance)?.colorScheme)
    }

    private var languagePicker: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(selectedLanguage.text(.language))
                .font(.caption.weight(.semibold))
                .foregroundStyle(Color.white.opacity(0.88))

            HStack(spacing: 10) {
                ForEach(AppLanguage.allCases) { language in
                    Button {
                        selectedLanguage = language
                    } label: {
                        Text(language.displayName)
                            .font(.subheadline.weight(.semibold))
                            .foregroundStyle(buttonTextColor(for: language))
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 12)
                            .background(
                                RoundedRectangle(cornerRadius: 14)
                                    .fill(buttonBackground(for: language))
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 14)
                                    .stroke(buttonBorder(for: language), lineWidth: 1)
                            )
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(8)
            .background(
                RoundedRectangle(cornerRadius: 18)
                    .fill(Color.white.opacity(0.08))
            )
            .overlay(
                RoundedRectangle(cornerRadius: 18)
                    .stroke(Color.white.opacity(0.12), lineWidth: 1)
            )
        }
    }

    private var heroSection: some View {
        ZStack(alignment: .bottomLeading) {
            RoundedRectangle(cornerRadius: 30)
                .fill(
                    LinearGradient(
                        colors: [
                            Color(red: 0.13, green: 0.16, blue: 0.23),
                            Color(red: 0.29, green: 0.23, blue: 0.15)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .overlay {
                    ZStack {
                        Circle()
                            .stroke(Color.white.opacity(0.08), lineWidth: 1)
                            .frame(width: 220, height: 220)
                            .offset(x: 120, y: -90)

                        Image(systemName: "building.columns.fill")
                            .font(.system(size: 120))
                            .foregroundStyle(Color.white.opacity(0.08))
                            .offset(x: 110, y: -40)
                    }
                }

            VStack(alignment: .leading, spacing: 12) {
                Text(selectedLanguage.text(.appTitle))
                    .font(.system(size: 34, weight: .bold, design: .serif))
                    .foregroundStyle(.white)

                Text(selectedLanguage.text(.heroTitle))
                    .font(.system(size: 28, weight: .semibold, design: .serif))
                    .foregroundStyle(Color(red: 0.95, green: 0.89, blue: 0.75))

                Text(selectedLanguage.text(.heroSubtitle))
                    .font(.body)
                    .foregroundStyle(Color.white.opacity(0.82))
                    .fixedSize(horizontal: false, vertical: true)
            }
            .padding(28)
        }
        .frame(minHeight: 250)
        .shadow(color: Color.black.opacity(0.18), radius: 24, y: 14)
    }

    private var documentSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(selectedLanguage.text(.documents))
                .font(.system(size: 24, weight: .semibold, design: .serif))
                .foregroundStyle(.white)

            NavigationLink {
                TestamentEditorView(language: selectedLanguage)
            } label: {
                DocumentCard(
                    title: selectedLanguage.text(.testamentTitle),
                    subtitle: selectedLanguage.text(.testamentSubtitle),
                    iconName: "scroll.fill",
                    accent: Color(red: 0.78, green: 0.64, blue: 0.39)
                )
            }
            .buttonStyle(.plain)

            NavigationLink {
                ContractEditorView(language: selectedLanguage)
            } label: {
                DocumentCard(
                    title: selectedLanguage.text(.contractTitle),
                    subtitle: selectedLanguage.contractText(.cardSubtitle),
                    iconName: "doc.text.fill",
                    accent: Color(red: 0.42, green: 0.54, blue: 0.60)
                )
            }
            .buttonStyle(.plain)

            NavigationLink {
                PowerOfAttorneyEditorView(language: selectedLanguage)
            } label: {
                DocumentCard(
                    title: selectedLanguage.text(.powerOfAttorneyTitle),
                    subtitle: selectedLanguage.powerOfAttorneyText(.cardSubtitle),
                    iconName: "signature",
                    accent: Color(red: 0.52, green: 0.44, blue: 0.29)
                )
            }
            .buttonStyle(.plain)

            NavigationLink {
                RentalAgreementEditorView(language: selectedLanguage)
            } label: {
                DocumentCard(
                    title: selectedLanguage.rentalText(.title),
                    subtitle: selectedLanguage.rentalText(.cardSubtitle),
                    iconName: "building.2.fill",
                    accent: Color(red: 0.38, green: 0.46, blue: 0.55)
                )
            }
            .buttonStyle(.plain)

            NavigationLink {
                CohabitationAgreementEditorView(language: selectedLanguage)
            } label: {
                DocumentCard(
                    title: selectedLanguage.cohabitationText(.title),
                    subtitle: selectedLanguage.cohabitationText(.cardSubtitle),
                    iconName: "person.2.fill",
                    accent: Color(red: 0.56, green: 0.43, blue: 0.31)
                )
            }
            .buttonStyle(.plain)

            NavigationLink {
                DebtInstrumentEditorView(language: selectedLanguage)
            } label: {
                DocumentCard(
                    title: selectedLanguage.debtText(.title),
                    subtitle: selectedLanguage.debtText(.cardSubtitle),
                    iconName: "banknote.fill",
                    accent: Color(red: 0.30, green: 0.50, blue: 0.39)
                )
            }
            .buttonStyle(.plain)
        }
    }

    private var backgroundView: some View {
        LinearGradient(
            colors: [
                Color(red: 0.08, green: 0.10, blue: 0.14),
                Color(red: 0.17, green: 0.13, blue: 0.10),
                Color(red: 0.32, green: 0.25, blue: 0.18)
            ],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        .ignoresSafeArea()
    }

    private func buttonBackground(for language: AppLanguage) -> Color {
        if selectedLanguage == language {
            return Color(red: 0.92, green: 0.84, blue: 0.63)
        }

        return Color.white.opacity(0.08)
    }

    private func buttonTextColor(for language: AppLanguage) -> Color {
        if selectedLanguage == language {
            return Color(red: 0.17, green: 0.13, blue: 0.10)
        }

        return .white
    }

    private func buttonBorder(for language: AppLanguage) -> Color {
        if selectedLanguage == language {
            return Color(red: 0.64, green: 0.50, blue: 0.28)
        }

        return Color.white.opacity(0.12)
    }
}

private struct DocumentCard: View {
    let title: String
    let subtitle: String
    let iconName: String
    let accent: Color
    var isEnabled = true

    var body: some View {
        HStack(spacing: 16) {
            ZStack {
                RoundedRectangle(cornerRadius: 18)
                    .fill(accent.opacity(isEnabled ? 0.18 : 0.10))
                    .frame(width: 64, height: 64)

                Image(systemName: iconName)
                    .font(.system(size: 28, weight: .medium))
                    .foregroundStyle(isEnabled ? accent : accent.opacity(0.55))
            }

            VStack(alignment: .leading, spacing: 6) {
                Text(title)
                    .font(.system(size: 21, weight: .semibold, design: .serif))
                    .foregroundStyle(.white)
                Text(subtitle)
                    .font(.subheadline)
                    .foregroundStyle(Color.white.opacity(isEnabled ? 0.72 : 0.52))
                    .fixedSize(horizontal: false, vertical: true)
            }

            Spacer()

            if isEnabled {
                Image(systemName: "chevron.right")
                    .foregroundStyle(Color.white.opacity(0.64))
            }
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 24)
                .fill(Color.white.opacity(isEnabled ? 0.10 : 0.06))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 24)
                .stroke(Color.white.opacity(isEnabled ? 0.10 : 0.06), lineWidth: 1)
        )
    }
}

#Preview {
    HomeView()
}
