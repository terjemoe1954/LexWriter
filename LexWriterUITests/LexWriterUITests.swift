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
    private func launchApp() -> XCUIApplication {
        let app = XCUIApplication()
        app.launchArguments = ["-resetUITestState"]
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

        XCTAssertTrue(app.staticTexts["Språk"].waitForExistence(timeout: 2))
        XCTAssertTrue(app.staticTexts["Utseende"].exists)
        XCTAssertTrue(app.staticTexts["Tilgang"].exists)
        XCTAssertTrue(app.staticTexts["settings.accessPlanSummary"].exists)
        XCTAssertTrue(app.buttons["Se planlagt premium"].exists)
        XCTAssertTrue(app.buttons["settings.userGuideLink"].exists)
        XCTAssertTrue(scrollUntilVisible(app.staticTexts["settings.privacySummary"], in: app).exists)
        XCTAssertTrue(scrollUntilVisible(app.staticTexts["settings.version"], in: app).exists)
        XCTAssertTrue(app.staticTexts["settings.build"].exists)
    }

    @MainActor
    func testLanguageChangeUpdatesSettingsLabels() throws {
        let app = launchApp()

        app.buttons["settingsButton"].tap()
        app.buttons["English"].tap()

        XCTAssertTrue(app.navigationBars["Settings"].waitForExistence(timeout: 2))
        XCTAssertTrue(app.staticTexts["Language"].exists)
        XCTAssertTrue(app.staticTexts["Appearance"].exists)
        XCTAssertTrue(app.staticTexts["Access"].exists)
        XCTAssertTrue(app.staticTexts["settings.accessPlanSummary"].exists)
        XCTAssertTrue(app.buttons["View planned premium"].exists)
        XCTAssertTrue(app.buttons["settings.userGuideLink"].exists)
        XCTAssertTrue(scrollUntilVisible(app.staticTexts["settings.privacySummary"], in: app).exists)
    }

    @MainActor
    func testSettingsCanOpenPremiumPreview() throws {
        let app = launchApp()

        app.buttons["settingsButton"].tap()
        app.buttons["openPremiumPreviewButton"].tap()

        XCTAssertTrue(app.navigationBars["LexWriter Premium"].waitForExistence(timeout: 2))
        XCTAssertTrue(app.staticTexts["Premium er planlagt"].exists)
        XCTAssertTrue(app.staticTexts["Planlagt premiumsamling"].exists)
        XCTAssertTrue(app.staticTexts["Kjøp er ikke tilgjengelig i denne versjonen"].exists)
        XCTAssertTrue(app.buttons["closePremiumButton"].exists)
    }

    @MainActor
    func testUserGuideExplainsAccessBadges() throws {
        let app = launchApp()

        app.buttons["settingsButton"].tap()
        app.buttons["Brukerveiledning"].tap()

        XCTAssertTrue(app.navigationBars["Brukerveiledning"].waitForExistence(timeout: 2))
        XCTAssertTrue(app.staticTexts["Gratis og premium"].exists)
        let accessText = app.staticTexts.matching(NSPredicate(format: "label CONTAINS %@", "Dokumenter kan være merket som gratis eller premium")).firstMatch
        XCTAssertTrue(accessText.exists)
    }

    @MainActor
    func testTestamentEditorShowsPreviewValidationGate() throws {
        let app = launchApp()

        app.buttons["documentCard.testament"].tap()
        let previewButton = scrollUntilVisible(app.buttons["Vis testament"], in: app, maxSwipes: 8)

        XCTAssertTrue(previewButton.exists)
        XCTAssertFalse(previewButton.isEnabled)
        XCTAssertTrue(app.staticTexts["Fyll inn alle påkrevde data og vitneopplysninger før testamentet kan vises."].exists)
    }
}
