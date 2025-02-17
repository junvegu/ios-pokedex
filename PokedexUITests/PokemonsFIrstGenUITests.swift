//
//  TESTUI.swift
//  PokedexUITests
//
//  Created by Junior Quevedo Gutiérrez  on 16/02/25.
//

import Foundation
import XCTest

final class PokemonsFIrstGenUITests: XCTestCase {
    
    let app = XCUIApplication()

    override func setUp() {
        continueAfterFailure = false
        app.launchArguments.append("--disableIdleWaiting")
        app.launchArguments.append("-UITests")
        app.launchEnvironment["animationsDisabled"] = "YES"

        app.launch()
    }

    func test_tapPokemonOpensDetail() {
        let collectionView = app.collectionViews.firstMatch
        XCTAssertTrue(collectionView.waitForExistence(timeout: 5))

        let firstRecipe = collectionView.cells.element(boundBy: 0)
        XCTAssertTrue(firstRecipe.waitForExistence(timeout: 3))
        firstRecipe.tap()

        let detailView = app.staticTexts["Bulbasaur"]
        XCTAssertTrue(detailView.waitForExistence(timeout: 3))
    }

    func test_searchPokemon() {
        let searchField = app.searchFields["searchBar"]
        XCTAssertTrue(searchField.waitForExistence(timeout: 5))

        searchField.tap()
        searchField.typeText("Charizard")

        let recipeCell = app.cells["6"]
        XCTAssertTrue(recipeCell.waitForExistence(timeout: 5))
    }

    func test_toggleLayout() {
        let layoutButton = app.navigationBars.buttons["Change View"]
        XCTAssertTrue(layoutButton.waitForExistence(timeout: 5))

        layoutButton.tap() // Switch to 4 columns
        layoutButton.tap() // Switch back to 2 columns
    }

}
