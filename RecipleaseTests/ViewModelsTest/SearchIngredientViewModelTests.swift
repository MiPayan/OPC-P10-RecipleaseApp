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
    
    func testIngredientArrayIsEmpty_WhenAddIngredientWhitoutWhiteSpace_ThenIngredientArrayContainsIngredient() {
        if searchIngredientViewModel.formatIngredientArray(ingredient: "Apple") {
            XCTAssertTrue(searchIngredientViewModel.ingredientArray.contains("Apple"))
        }
    }
        
    func testArrayIsEmpty_WhenNoIngredientAdded_ThenArrayRemainingEmpty() {
        if !searchIngredientViewModel.formatIngredientArray(ingredient: "") {
            XCTAssertTrue(searchIngredientViewModel.ingredientArray.isEmpty)
        }
    }
    
    func testArrayContainsAnIngredient_WhenAllIngredientsAreRemoved_ThenIngredientArrayIsEmpty() {
        if searchIngredientViewModel.formatIngredientArray(ingredient: "Banana") {
            XCTAssertTrue(searchIngredientViewModel.ingredientArray.contains("Banana"))
        }
        searchIngredientViewModel.removeAllIngredients()
        XCTAssertTrue(searchIngredientViewModel.ingredientArray.isEmpty)
    }
    
    func testArrayContainsAnIngredient_WhenIsRemoveAtAnIndex_ThenIngredientArrayIsEmpty() {
        if searchIngredientViewModel.formatIngredientArray(ingredient: "Pear") {
            XCTAssertTrue(searchIngredientViewModel.ingredientArray.contains("Pear"))
        }
        searchIngredientViewModel.removeIngredient(at: 0)
        XCTAssertTrue(searchIngredientViewModel.ingredientArray.isEmpty)
    }
}
