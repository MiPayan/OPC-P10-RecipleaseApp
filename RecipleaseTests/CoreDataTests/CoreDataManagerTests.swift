//
//  CoreDataManagerTests.swift
//  RecipleaseTests
//
//  Created by Mickael PAYAN on 29/06/2022.
//

import XCTest
@testable import Reciplease

final class CoreDataManagerTests: XCTestCase {
    
    // MARK: - Properties
    
    private var edamamResponseMock: EdamamResponseMock!
    private var coreDataStackMock: CoreDataStackMock!
    private var coreDataManager: CoreDataManager!
    
    // MARK: - Test Life Cycle

    override func setUpWithError() throws {
        edamamResponseMock = EdamamResponseMock()
        coreDataStackMock = CoreDataStackMock(modelName: "Reciplease")
        coreDataManager = CoreDataManager(coreDataStack: coreDataStackMock)
    }
    
    override func tearDownWithError() throws {
        edamamResponseMock = nil
        coreDataManager = nil
        coreDataStackMock = nil
    }
    
    // MARK: - Methods
    
    func testSaveRecipe() {
        let response = edamamResponseMock.make()
        guard let recipe = response?.hits.first?.recipe else {
            XCTFail("Fail to get edamam response mock.")
            return
        }
        coreDataManager.saveRecipe(recipe)
        XCTAssertEqual(coreDataManager.recipes.first!.label, recipe.label)
    }
    
    func testDeleteRecipe() {
        let response = edamamResponseMock.make()
        guard let recipe = response?.hits.first?.recipe else {
            XCTFail("Fail to get edamam response mock.")
            return
        }
        coreDataManager.saveRecipe(recipe)
        coreDataManager.deleteRecipeFromFavorite(recipe.label)
        XCTAssertTrue(coreDataManager.recipes.isEmpty)
    }
    
    func testIsNotAlreadySaved() {
        let response = edamamResponseMock.make()
        guard let recipe = response?.hits.first?.recipe else {
            XCTFail("Fail to get edamam response mock.")
            return
        }
        
        let isRecipeAlreadySaved = coreDataManager.checkIfRecipeIsAlreadySaved(recipe.label)
        XCTAssertFalse(isRecipeAlreadySaved)
    }
    
    func testIsAlreadySaved() {
        let response = edamamResponseMock.make()
        guard let recipe = response?.hits.first?.recipe else {
            XCTFail("Fail to get edamam response mock.")
            return
        }
        
        coreDataManager.saveRecipe(recipe)
        let isRecipeAlreadySaved = coreDataManager.checkIfRecipeIsAlreadySaved(recipe.label)
        XCTAssertTrue(isRecipeAlreadySaved)
    }
}
