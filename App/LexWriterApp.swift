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

    var body: some Scene {
        WindowGroup {
            HomeView()
                .environment(purchaseManager)
                .task {
                    purchaseManager.start()
                }
        }
    }
}
