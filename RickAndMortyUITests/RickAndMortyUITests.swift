//
//  RickAndMortyUITests.swift
//  RickAndMortyUITests
//
//  Created by Balla Tamás on 2022. 10. 14..
//

import XCTest

class RickAndMortyUITests: XCTestCase {
    
    var app: XCUIApplication!

    override func setUpWithError() throws {
        try super.setUpWithError()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()

    }
    
    func testAddToFavourites() {
        let app = XCUIApplication()
        let rick = app.tables.cells.containing(.staticText, identifier:"Rick Sanchez").element
        rick.tap()
        
        let characterDetailsNavigationBar = app.navigationBars["Character details"]
        let favouriteButton = characterDetailsNavigationBar.buttons["love"]
        let backButton = characterDetailsNavigationBar.buttons["Back"]
        
        if favouriteButton.isSelected {
            backButton.tap()
            rick.tap()
            
            XCTAssertTrue(favouriteButton.isSelected)
        } else {
            backButton.tap()
            rick.tap()
            
            XCTAssertFalse(favouriteButton.isSelected)
        }
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
