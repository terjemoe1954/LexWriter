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
    func testSettingsShowsLanguageAppearanceHelpAndAppInfo() throws {
        let app = XCUIApplication()
        app.launch()

        app.buttons["settingsButton"].tap()

        XCTAssertTrue(app.staticTexts["Språk"].waitForExistence(timeout: 2))
        XCTAssertTrue(app.staticTexts["Utseende"].exists)
        XCTAssertTrue(app.staticTexts["Hjelp"].exists)
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
        XCTAssertTrue(app.staticTexts["Help"].exists)
        XCTAssertTrue(app.staticTexts["App information"].exists)
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
