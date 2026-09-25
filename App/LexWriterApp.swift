//
//  LexWriterApp.swift
//  LexWriter
//   
//  Created by Terje Moe on 28/08/2026.
//

import SwiftUI

@main
struct LexWriterApp: App {
    @State private var purchaseManager = PurchaseManager()

    init() {
        if ProcessInfo.processInfo.arguments.contains("-resetUITestState") {
            UserDefaults.standard.removeObject(forKey: "selectedLanguage")
            UserDefaults.standard.removeObject(forKey: "preferredAppearance")
        }
    }

    var body: some Scene {
        WindowGroup {
            if opensPremiumPreviewForUITest {
                PremiumView(language: .norwegian, highlightedDocument: nil)
                    .environment(purchaseManager)
            } else {
                HomeView()
                    .environment(purchaseManager)
                    .task {
                        if MonetizationPlan.isPremiumStoreEnabled {
                            purchaseManager.start()
                        }
                    }
            }
        }
    }

    private var opensPremiumPreviewForUITest: Bool {
        ProcessInfo.processInfo.arguments.contains("-openPremiumPreviewUITest")
    }
}
