//
//  HomeView.swift
//  LexWriter
//
//  Created by Terje Moe on 28/08/2026.
//

import SwiftUI

struct HomeView: View {
    @Environment(PurchaseManager.self) private var purchaseManager
    @AppStorage("selectedLanguage") private var selectedLanguageRawValue = AppLanguage.norwegian.rawValue
    @AppStorage("preferredAppearance") private var preferredAppearance = AppAppearance.system.rawValue
    @AppStorage(MonetizationPlan.premiumLockingDefaultsKey) private var premiumLockingEnabled = false
    @State private var premiumDocument: AppDocument?

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
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
                        SettingsView()
                    } label: {
                        Image(systemName: "gearshape.fill")
                            .foregroundStyle(Color.white.opacity(0.88))
                    }
                    .accessibilityLabel(selectedLanguage.text(.settings))
                    .accessibilityIdentifier("settingsButton")
                }
            }
        }
        .sheet(item: $premiumDocument) { document in
            PremiumView(language: selectedLanguage, highlightedDocument: document)
        }
        .preferredColorScheme(AppAppearance(rawValue: preferredAppearance)?.colorScheme)
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

            ForEach(AppDocument.allCases) { document in
                if isDocumentUnlocked(document) {
                    NavigationLink {
                        document.destinationView(language: selectedLanguage)
                    } label: {
                        DocumentCard(
                            title: document.title(for: selectedLanguage),
                            subtitle: document.subtitle(for: selectedLanguage),
                            iconName: document.iconName,
                            accent: document.accent,
                            badgeText: badgeText(for: document)
                        )
                    }
                    .buttonStyle(.plain)
                } else {
                    Button {
                        premiumDocument = document
                    } label: {
                        DocumentCard(
                            title: document.title(for: selectedLanguage),
                            subtitle: document.subtitle(for: selectedLanguage),
                            iconName: document.iconName,
                            accent: document.accent,
                            badgeText: badgeText(for: document),
                            lockedMessage: selectedLanguage.text(.premiumRequiredShort),
                            isEnabled: false
                        )
                    }
                    .buttonStyle(.plain)
                }
            }
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

    private var selectedLanguage: AppLanguage {
        AppLanguage(rawValue: selectedLanguageRawValue) ?? .norwegian
    }

    private func isDocumentUnlocked(_ document: AppDocument) -> Bool {
        guard premiumLockingEnabled else { return true }
        return purchaseManager.isDocumentUnlocked(document)
    }

    private func badgeText(for document: AppDocument) -> String? {
        let text = MonetizationPlan.badgeText(for: document, language: selectedLanguage)
        return text.isEmpty ? nil : text
    }
}

private struct DocumentCard: View {
    let title: String
    let subtitle: String
    let iconName: String
    let accent: Color
    var badgeText: String? = nil
    var lockedMessage: String? = nil
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
                HStack(alignment: .firstTextBaseline, spacing: 8) {
                    Text(title)
                        .font(.system(size: 21, weight: .semibold, design: .serif))
                        .foregroundStyle(.white)

                    if let badgeText {
                        Text(badgeText)
                            .font(.caption.weight(.semibold))
                            .foregroundStyle(accent)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(
                                Capsule()
                                    .fill(accent.opacity(0.18))
                            )
                    }
                }

                Text(subtitle)
                    .font(.subheadline)
                    .foregroundStyle(Color.white.opacity(isEnabled ? 0.72 : 0.52))
                    .fixedSize(horizontal: false, vertical: true)

                if let lockedMessage, !isEnabled {
                    Text(lockedMessage)
                        .font(.caption.weight(.semibold))
                        .foregroundStyle(accent.opacity(0.95))
                }
            }

            Spacer()

            if isEnabled {
                Image(systemName: "chevron.right")
                    .foregroundStyle(Color.white.opacity(0.64))
            } else {
                Image(systemName: "lock.fill")
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
        .opacity(isEnabled ? 1.0 : 0.82)
        .accessibilityElement(children: .combine)
        .accessibilityIdentifier("documentCard.\(title)")
    }
}

#Preview {
    HomeView()
}
