//
//  AstronomyUITests.swift
//  AstronomyUITests
//
//  Created by Kevin Stewart on 5/28/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import XCTest

class AstronomyUITests: XCTestCase {
    
    private var app: XCUIApplication {
        XCUIApplication()
    }

    override func setUpWithError() throws {
        app.launchArguments = ["UITesting"]
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
    
    // Astronomy UI Tests
    
    private func getCellFor(_ index: Int) -> XCUIElement {
        app.collectionViews.cells["Cell \(index)"]
    }
    func testPictureTapped() {
        app.launch()

        for _ in 0...5 {
            nextSol.tap()
        }
        fetchNavTitleForSelectedSol(16).waitForExistence(timeout: 5)
        XCTAssertEqual(fetchNavTitleForSelectedSol(16).label, "Sol 16")

        getCellFor(0).tap()

        XCTAssert(app.staticTexts["Title"].exists)
    }
    
    // Properties for testing a saved picture
    
    
    func testPictureSavedToCameraRoll() {
        
        let app = XCUIApplication()
        app.launch()
        app.collectionViews
            .children(matching: .cell).element(boundBy: 0)
            .children(matching: .other).element.tap()
        app/*@START_MENU_TOKEN@*/.staticTexts["Save to Photo Library"]/*[[".buttons[\"Save to Photo Library\"].staticTexts[\"Save to Photo Library\"]",".buttons[\"PhotoDetailViewController.SaveButton\"].staticTexts[\"Save to Photo Library\"]",".staticTexts[\"Save to Photo Library\"]"],[[[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.alerts["Photo Saved!"].scrollViews.otherElements.buttons["Okay"].tap()
        
        
    }
    
    func testPicturesLoad() {
        
    }
    
    // Properties for function below
    private var nextSol: XCUIElement {
        app.buttons["PhotosCollectionViewController.NextSolButton"]
    }
    private func fetchNavTitleForSelectedSol(_ sol: Int) -> XCUIElement {
        app.staticTexts["Sol \(sol)"]
    }
    
    
    
        func testViewingAnotherSol() {
            app.launch()

            nextSol.tap()


        guard fetchNavTitleForSelectedSol(2).waitForExistence(timeout: 3) else {
            XCTFail()
            return
        }

        XCTAssertEqual(fetchNavTitleForSelectedSol(2).label, "Sol 15")
    }
}

