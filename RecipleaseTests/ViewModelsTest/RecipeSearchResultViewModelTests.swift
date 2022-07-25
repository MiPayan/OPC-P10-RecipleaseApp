//
//  RecipeSearchResultViewModelTests.swift
//  RecipleaseTests
//
//  Created by Mickael PAYAN on 04/07/2022.
//

import XCTest
@testable import Reciplease

final class RecipeSearchResultViewModelTests: XCTestCase {
    
    // MARK: - Properties

    private var edamamResponseMock: EdamamResponseMock!
    private var recipeSearchResultViewModel: RecipeSearchResultViewModel!
    private var recipePeeckerMock: RecipePeeckingMock!
    private var recipeWriterMock: RecipeWritingMock!
    
    // MARK: - Test Life Cycle
    
    override func setUpWithError() throws {
        edamamResponseMock = EdamamResponseMock()
        recipeWriterMock = RecipeWritingMock()
        recipePeeckerMock = RecipePeeckingMock()
        recipeSearchResultViewModel = RecipeSearchResultViewModel(recipeWriter: recipeWriterMock, recipePeecker: recipePeeckerMock)
    }
    
    override func tearDownWithError() throws {
        edamamResponseMock = nil
        recipeSearchResultViewModel = nil
        recipeWriterMock = nil
        recipePeeckerMock = nil
    }
    
    // MARK: - Methods
    
    func testSaveRecipe() {
        let response = edamamResponseMock.make()
        guard let recipe = response?.hits.first?.recipe else {
            XCTFail("Fail to get edamam respose mock.")
            return
        }
        
        recipeSearchResultViewModel.saveRecipe(with: recipe)
        
        XCTAssertEqual(recipeWriterMock.invokedSaveRecipeCount, 1)
    }
        
    func testDeleteRecipe() {
        let recipeLabel = "Test"
        
        recipeSearchResultViewModel.deleteRecipe(with: recipeLabel)
        XCTAssertEqual(recipeWriterMock.invokedDeleteRecipeCount, 1)
        XCTAssertEqual(recipeWriterMock.invokedDeleteRecipeParameter, "Test")
    }
    
    func testCheckIfRecipeIsSaved() {
        recipePeeckerMock.stubbedIsRecipeAlreadySaved = true
        
        let isRecipeSaved = recipeSearchResultViewModel.checkIfRecipeIsAlreadySaved(with: "Test")
        
        XCTAssertEqual(recipePeeckerMock.checkIfRecipeIsAlreadySavedCount, 1)
        XCTAssertEqual(recipePeeckerMock.invokedCheckIfRecipeIsAlreadySavedParameter, "Test")
        XCTAssertEqual(isRecipeSaved, true)
    }
    
    func testCheckIfRecipeIsNotSaved() {
        recipePeeckerMock.stubbedIsRecipeAlreadySaved = false
        
        let isRecipeSaved = recipeSearchResultViewModel.checkIfRecipeIsAlreadySaved(with: "Test")
        
        XCTAssertEqual(recipePeeckerMock.checkIfRecipeIsAlreadySavedCount, 1)
        XCTAssertEqual(recipePeeckerMock.invokedCheckIfRecipeIsAlreadySavedParameter, "Test")
        XCTAssertEqual(isRecipeSaved, false)
    }
}
