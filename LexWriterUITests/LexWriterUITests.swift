//
//  LexWriterUITests.swift
//  LexWriterUITests
//
//  Created by Terje Moe on 28/08/2026.
//

import XCTest

final class LexWriterUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    @MainActor
    private func launchApp(extraArguments: [String] = []) -> XCUIApplication {
        let app = XCUIApplication()
        app.launchArguments = ["-resetUITestState"] + extraArguments
        app.launch()
        return app
    }

    @MainActor
    private func scrollUntilVisible(_ element: XCUIElement, in app: XCUIApplication, maxSwipes: Int = 5) -> XCUIElement {
        for _ in 0..<maxSwipes where !element.exists {
            app.swipeUp()
        }
        return element
    }

    @MainActor
    private func scrollToTop(in app: XCUIApplication, maxSwipes: Int = 3) {
        for _ in 0..<maxSwipes {
            app.swipeDown()
        }
    }

    @MainActor
    private func element(containing labelText: String, in app: XCUIApplication) -> XCUIElement {
        app.descendants(matching: .any)
            .matching(NSPredicate(format: "label CONTAINS %@", labelText))
            .firstMatch
    }

    @MainActor
    func testHomeShowsLegalTemplateNotice() throws {
        let app = launchApp()

        XCTAssertTrue(app.staticTexts["Dokumentene er maler og utkast, ikke juridisk rådgivning."].waitForExistence(timeout: 2))
    }

    @MainActor
    func testHomeShowsFreeAndPremiumBadges() throws {
        let app = launchApp()

        XCTAssertTrue(app.staticTexts["Gratis"].waitForExistence(timeout: 2))
        if !app.staticTexts["Premium"].exists {
            app.swipeUp()
        }
        XCTAssertTrue(app.staticTexts["Planlagte premium-maler"].waitForExistence(timeout: 2))
        XCTAssertTrue(app.staticTexts["Premium"].waitForExistence(timeout: 2))
    }

    @MainActor
    func testSettingsShowsLanguageAppearanceHelpAndAppInfo() throws {
        let app = launchApp()

        app.buttons["settingsButton"].tap()
        scrollToTop(in: app)

        XCTAssertTrue(app.staticTexts["Språk"].waitForExistence(timeout: 2))
        XCTAssertTrue(app.staticTexts["Utseende"].exists)
        XCTAssertTrue(scrollUntilVisible(app.staticTexts["Tilgang"], in: app).exists)
        XCTAssertTrue(scrollUntilVisible(app.buttons["openPremiumPreviewButton"], in: app).exists)
        XCTAssertTrue(scrollUntilVisible(app.buttons["settings.userGuideLink"], in: app).exists)
        XCTAssertTrue(scrollUntilVisible(app.staticTexts["settings.privacySummary"], in: app).exists)
        XCTAssertTrue(scrollUntilVisible(app.staticTexts["settings.version"], in: app).exists)
        XCTAssertTrue(app.staticTexts["settings.build"].exists)
    }

    @MainActor
    func testLanguageChangeUpdatesSettingsLabels() throws {
        let app = launchApp()

        app.buttons["settingsButton"].tap()
        scrollToTop(in: app)
        app.buttons["English"].tap()

        XCTAssertTrue(app.navigationBars["Settings"].waitForExistence(timeout: 2))
        XCTAssertTrue(app.staticTexts["Language"].exists)
        XCTAssertTrue(app.staticTexts["Appearance"].exists)
        XCTAssertTrue(scrollUntilVisible(app.staticTexts["Access"], in: app).exists)
        XCTAssertTrue(scrollUntilVisible(app.buttons["openPremiumPreviewButton"], in: app).exists)
        XCTAssertTrue(scrollUntilVisible(app.buttons["settings.userGuideLink"], in: app).exists)
        XCTAssertTrue(scrollUntilVisible(app.staticTexts["settings.privacySummary"], in: app).exists)
    }

    @MainActor
    func testSettingsCanOpenPremiumPreview() throws {
        let app = launchApp(extraArguments: ["-openPremiumPreviewUITest"])

        XCTAssertTrue(app.navigationBars["LexWriter Premium"].waitForExistence(timeout: 5))
        XCTAssertTrue(app.staticTexts["premium.previewHeadline"].exists)
        XCTAssertTrue(app.staticTexts["premium.purchasesUnavailable"].exists)
        XCTAssertTrue(scrollUntilVisible(app.staticTexts["premium.previewIncludes"], in: app).exists)
        XCTAssertTrue(app.buttons["closePremiumButton"].exists)
    }

    @MainActor
    func testUserGuideExplainsAccessBadges() throws {
        let app = launchApp()

        app.buttons["settingsButton"].tap()
        scrollToTop(in: app)
        scrollUntilVisible(app.buttons["settings.userGuideLink"], in: app).tap()

        XCTAssertTrue(app.navigationBars["Brukerveiledning"].waitForExistence(timeout: 2))
        let accessText = element(containing: "Dokumenter kan være merket som gratis eller premium", in: app)
        XCTAssertTrue(scrollUntilVisible(accessText, in: app).exists)
    }

    @MainActor
    func testTestamentEditorShowsPreviewValidationGate() throws {
        let app = launchApp()

        app.buttons["documentCard.testament"].tap()
        XCTAssertTrue(app.navigationBars["Testament"].waitForExistence(timeout: 2))
        let previewButton = scrollUntilVisible(
            app.descendants(matching: .any)["testament.previewButton"],
            in: app,
            maxSwipes: 8
        )
        let validationMessage = scrollUntilVisible(
            app.descendants(matching: .any)["testament.previewValidationMessage"],
            in: app,
            maxSwipes: 2
        )

        XCTAssertTrue(previewButton.exists)
        XCTAssertFalse(previewButton.isEnabled)
        XCTAssertTrue(validationMessage.exists)
    }
}
