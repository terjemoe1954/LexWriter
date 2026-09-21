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
    func testHomeShowsLegalTemplateNotice() throws {
        let app = XCUIApplication()
        app.launch()

        XCTAssertTrue(app.staticTexts["Dokumentene er maler og utkast, ikke juridisk rådgivning."].waitForExistence(timeout: 2))
    }

    @MainActor
    func testHomeShowsFreeAndPremiumBadges() throws {
        let app = XCUIApplication()
        app.launch()

        XCTAssertTrue(app.staticTexts["Gratis"].waitForExistence(timeout: 2))
        if !app.staticTexts["Premium"].exists {
            app.swipeUp()
        }
        XCTAssertTrue(app.staticTexts["Planlagte premium-maler"].waitForExistence(timeout: 2))
        XCTAssertTrue(app.staticTexts["Premium"].waitForExistence(timeout: 2))
    }

    @MainActor
    func testSettingsShowsLanguageAppearanceHelpAndAppInfo() throws {
        let app = XCUIApplication()
        app.launch()

        app.buttons["settingsButton"].tap()

        XCTAssertTrue(app.staticTexts["Språk"].waitForExistence(timeout: 2))
        XCTAssertTrue(app.staticTexts["Utseende"].exists)
        XCTAssertTrue(app.staticTexts["Tilgang"].exists)
        XCTAssertTrue(app.staticTexts["Alle dokumenter er åpne nå"].exists)
        XCTAssertTrue(app.staticTexts["3 gratis maler og 9 planlagte premium-maler."].exists)
        XCTAssertTrue(app.buttons["Se planlagt premium"].exists)
        XCTAssertTrue(app.staticTexts["Hjelp"].exists)
        XCTAssertTrue(app.staticTexts["Personvern"].exists)
        XCTAssertTrue(app.staticTexts["Appinformasjon"].exists)
        XCTAssertTrue(app.staticTexts["Versjon"].exists)
        XCTAssertTrue(app.staticTexts["Build"].exists)
    }

    @MainActor
    func testLanguageChangeUpdatesSettingsLabels() throws {
        let app = XCUIApplication()
        app.launch()

        app.buttons["settingsButton"].tap()
        app.buttons["English"].tap()

        XCTAssertTrue(app.navigationBars["Settings"].waitForExistence(timeout: 2))
        XCTAssertTrue(app.staticTexts["Language"].exists)
        XCTAssertTrue(app.staticTexts["Appearance"].exists)
        XCTAssertTrue(app.staticTexts["Access"].exists)
        XCTAssertTrue(app.staticTexts["All documents open now"].exists)
        XCTAssertTrue(app.staticTexts["3 free templates and 9 planned premium templates."].exists)
        XCTAssertTrue(app.buttons["View planned premium"].exists)
        XCTAssertTrue(app.staticTexts["Help"].exists)
        XCTAssertTrue(app.staticTexts["Privacy"].exists)
        XCTAssertTrue(app.staticTexts["App information"].exists)
    }

    @MainActor
    func testSettingsCanOpenPremiumPreview() throws {
        let app = XCUIApplication()
        app.launch()

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
        let app = XCUIApplication()
        app.launch()

        app.buttons["settingsButton"].tap()
        app.buttons["Brukerveiledning"].tap()

        XCTAssertTrue(app.navigationBars["Brukerveiledning"].waitForExistence(timeout: 2))
        XCTAssertTrue(app.staticTexts["Gratis og premium"].exists)
        XCTAssertTrue(app.staticTexts["Dokumenter kan være merket som gratis eller premium. I denne utgaven er alle dokumenter fortsatt tilgjengelige, mens premium-inndelingen er forberedt for en senere betalt versjon."].exists)
    }

    @MainActor
    func testPreviewShowsPrintAndSavePDFButtons() throws {
        let app = XCUIApplication()
        app.launch()

        app.staticTexts["Testament"].tap()
        app.buttons["Vis testament"].tap()

        XCTAssertTrue(app.buttons["savePDFButton"].waitForExistence(timeout: 2))
        XCTAssertTrue(app.buttons["printButton"].exists)
        XCTAssertTrue(app.buttons["closePreviewButton"].exists)
    }
}
