//
//  SearchIngredientViewModelTests.swift
//  RecipleaseTests
//
//  Created by Mickael PAYAN on 05/04/2022.
//

import XCTest
@testable import Reciplease

enum APIError: Error {
    case badRequest
}

final class SearchIngredientViewModelTests: XCTestCase {
    
    // MARK: - Properties
    
    private var searchIngredientViewModel: SearchIngredientViewModel!
    private var recipeServiceMock: RecipeServiceMock!
    
    // MARK: - Test Life Cycle
    
    override func setUpWithError() throws {
        recipeServiceMock = RecipeServiceMock()
        searchIngredientViewModel = SearchIngredientViewModel(recipeService: recipeServiceMock)
    }
    
    override func tearDownWithError() throws {
        searchIngredientViewModel = nil
    }
    
    // MARK: - Methods
    
    func testFailureGetRecipe() {
        let expectation = expectation(description: "Failure to get recipe.")
        
        if searchIngredientViewModel.formatIngredientArray(ingredient: "Salmon") {
            XCTAssertTrue(searchIngredientViewModel.ingredientArray.contains("Salmon"))
        }
        
        recipeServiceMock.stubbedResult = (
            .failure(.sessionTaskFailed(error: APIError.badRequest))
        )
        
        searchIngredientViewModel.failureHandler = {
            XCTAssertEqual("Salmon", self.recipeServiceMock.invokedGetRecipeQueryParameter)
            XCTAssertEqual(1, self.recipeServiceMock.invokedGetRecipeCount)
            expectation.fulfill()
        }
        searchIngredientViewModel.getRecipe()
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testSucessGetRecipe() {
        let expectation = expectation(description: "Success to get recipe.")
        let edamamResponseMock = EdamamResponseMock()
        
        if searchIngredientViewModel.formatIngredientArray(ingredient: "Cheese") {
            XCTAssertTrue(searchIngredientViewModel.ingredientArray.contains("Cheese"))
        }
        
        guard let edamamResponse = edamamResponseMock.make() else { return }
        recipeServiceMock.stubbedResult = (
            .success(edamamResponse)
        )
        
        searchIngredientViewModel.successHandler = {
            XCTAssertEqual("Cheese", self.recipeServiceMock.invokedGetRecipeQueryParameter)
            XCTAssertEqual(1, self.recipeServiceMock.invokedGetRecipeCount)
            expectation.fulfill()
        }
        searchIngredientViewModel.getRecipe()
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testFormatAnIngredientWithoutSpaceWhenItIsAddedWithSpace() {
        let ingredient = " Apple "
        let containsAnIngredient = searchIngredientViewModel.formatIngredientArray(ingredient: ingredient)
        let ingredientArray = searchIngredientViewModel.ingredientArray
        XCTAssertEqual(containsAnIngredient, true)
        XCTAssertEqual(ingredient, " Apple ")
        XCTAssertEqual(ingredientArray, ["Apple"])
    }
    
    func testRemoveAllIngredient() {
        let ingredient = "Chocolate"
        let containsAnIngredient = searchIngredientViewModel.formatIngredientArray(ingredient: ingredient)
        searchIngredientViewModel.removeAllIngredients()
        XCTAssertEqual(ingredient, "Chocolate")
        XCTAssertEqual(containsAnIngredient, true)
        XCTAssertEqual(searchIngredientViewModel.ingredientArray, [])
    }
    
    func testRemoveIngredientAtIndex() {
        let index = 0
        let ingredient = "Banana"
        let containsAnIngredient = searchIngredientViewModel.formatIngredientArray(ingredient: ingredient)
        searchIngredientViewModel.removeIngredient(at: index)
        XCTAssertEqual(ingredient, "Banana")
        XCTAssertEqual(containsAnIngredient, true)
        XCTAssertEqual(searchIngredientViewModel.ingredientArray, [])
    }
    
    func testArrayAlreadyContainsThisIngredient() {
        let ingredient = "Mango"
        let containsAnIngredient = searchIngredientViewModel.formatIngredientArray(ingredient: ingredient)
        let containsTheSameIngredient = searchIngredientViewModel.formatIngredientArray(ingredient: ingredient)
        XCTAssertEqual(ingredient, "Mango")
        XCTAssertEqual(containsAnIngredient, true)
        XCTAssertEqual(containsTheSameIngredient, false)
        XCTAssertEqual(searchIngredientViewModel.ingredientArray, ["Mango"])
    }
}
