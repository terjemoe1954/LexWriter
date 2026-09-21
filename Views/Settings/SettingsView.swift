//
//  SettingsView.swift
//  LexWriter
//
//  Created by Terje Moe on 29/08/2026.
//

import SwiftUI

struct SettingsView: View {
    @Environment(PurchaseManager.self) private var purchaseManager
    @AppStorage("selectedLanguage") private var selectedLanguageRawValue = AppLanguage.norwegian.rawValue
    @AppStorage("preferredAppearance") private var preferredAppearance = AppAppearance.system.rawValue
    @State private var showsPremiumPreview = false

    var body: some View {
        Form {
            Section(currentLanguage.text(.language)) {
                Picker(currentLanguage.text(.language), selection: selectedLanguageBinding) {
                    ForEach(AppLanguage.allCases) { language in
                        Text(language.displayName).tag(language)
                    }
                }
                .pickerStyle(.segmented)
                .accessibilityIdentifier("languagePicker")
            }

            Section(language.text(.appearance)) {
                Picker(language.text(.appearance), selection: $preferredAppearance) {
                    ForEach(AppAppearance.allCases) { appearance in
                        Text(language.text(appearance.localizedKey)).tag(appearance.rawValue)
                    }
                }
                .pickerStyle(.segmented)
                .accessibilityIdentifier("appearancePicker")
            }

            Section(language.text(.accessPlan)) {
                LabeledContent(language.text(.currentEdition)) {
                    Text(currentEditionText)
                }

                Text(language.text(.accessPlanSummary))
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .fixedSize(horizontal: false, vertical: true)

                Text(language.text(.futurePricingNote))
                    .font(.footnote)
                    .foregroundStyle(.secondary)
                    .fixedSize(horizontal: false, vertical: true)

                Button {
                    showsPremiumPreview = true
                } label: {
                    Label(premiumButtonTitle, systemImage: "crown.fill")
                }
                .accessibilityIdentifier("openPremiumPreviewButton")
            }

            Section(language.text(.help)) {
                NavigationLink {
                    UserGuideView(language: language)
                } label: {
                    Label(language.text(.userGuide), systemImage: "book.pages.fill")
                }
            }

            Section(language.text(.privacy)) {
                Text(language.text(.privacySummary))
                    .font(.footnote)
                    .foregroundStyle(.secondary)
                    .fixedSize(horizontal: false, vertical: true)
            }

            Section(language.text(.appInfo)) {
                LabeledContent(language.text(.version)) {
                    Text(AppMetadata.versionString)
                }
                LabeledContent(language.text(.build)) {
                    Text(AppMetadata.buildString)
                }
                LabeledContent(language.text(.versionAndBuild)) {
                    Text(AppMetadata.combinedVersionString)
                }
            }
        }
        .navigationTitle(language.text(.settings))
        .sheet(isPresented: $showsPremiumPreview) {
            PremiumView(language: language, highlightedDocument: nil)
        }
    }

    private var language: AppLanguage {
        AppLanguage(rawValue: selectedLanguageRawValue) ?? .norwegian
    }

    private var currentLanguage: AppLanguage {
        language
    }

    private var currentEditionText: String {
        guard MonetizationPlan.isPremiumEnforced else {
            return language.text(.allDocumentsOpenNow)
        }

        return purchaseManager.hasPremiumAccess ? language.text(.fullEdition) : language.text(.freeTier)
    }

    private var premiumButtonTitle: String {
        if MonetizationPlan.isPremiumStoreEnabled {
            return language.text(.openPremiumPreview)
        }

        return language.text(.openPremiumPlan)
    }

    private var selectedLanguageBinding: Binding<AppLanguage> {
        Binding(
            get: { language },
            set: { selectedLanguageRawValue = $0.rawValue }
        )
    }
}

enum AppAppearance: String, CaseIterable, Identifiable {
    case system
    case light
    case dark

    var id: String { rawValue }

    var colorScheme: ColorScheme? {
        switch self {
        case .system:
            return nil
        case .light:
            return .light
        case .dark:
            return .dark
        }
    }

    var localizedKey: LocalizedKey {
        switch self {
        case .system:
            return .systemMode
        case .light:
            return .lightMode
        case .dark:
            return .darkMode
        }
    }
}

private enum AppMetadata {
    static let versionString: String = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? "1.0"
    static let buildString: String = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String ?? "1"
    static let combinedVersionString: String = "\(versionString) (\(buildString))"
}

#Preview {
    NavigationStack {
        SettingsView()
    }
    .environment(PurchaseManager())
}
