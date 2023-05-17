//
//  RecipeDetailsViewModelTests.swift
//  RecipleaseTests
//
//  Created by Mickael PAYAN on 12/07/2022.
//

import XCTest
@testable import Reciplease

final class RecipeDetailsViewModelTests: XCTestCase {
//    
//    // MARK: - Properties
//    
//    private var edamamResponseMock: EdamamResponseMock!
//    private var recipeDetailsViewModel: RecipeDetailsViewModel!
//    private var recipePeeckerMock: RecipePeeckingMock!
//    private var recipeWriterMock: RecipeWritingMock!
//    
//    // MARK: - Test Life Cycle
//    
//    override func setUpWithError() throws {
//        edamamResponseMock = EdamamResponseMock()
//        recipeWriterMock = RecipeWritingMock()
//        recipePeeckerMock = RecipePeeckingMock()
//        recipeDetailsViewModel = RecipeDetailsViewModel(recipePeecker: recipePeeckerMock, recipeWriter: recipeWriterMock)
//    }
//    
//    override func tearDownWithError() throws {
//        edamamResponseMock = nil
//        recipeDetailsViewModel = nil
//        recipeWriterMock = nil
//        recipePeeckerMock = nil
//    }
//    
//    // MARK: - Methods
//    
//    func testSaveRecipe() {
//        let response = edamamResponseMock.make()
//        guard let recipe = response?.hits.first?.recipe else {
//            XCTFail("Fail to get edamam respose mock.")
//            return
//        }
//        
//        recipeDetailsViewModel.saveRecipe(with: recipe)
//        
//        XCTAssertEqual(recipeWriterMock.invokedSaveRecipeCount, 1)
//    }
//    
//    func testDeleteRecipe() {
//        let recipeLabel = "Test"
//        
//        recipeDetailsViewModel.deleteRecipe(with: recipeLabel)
//        XCTAssertEqual(recipeWriterMock.invokedDeleteRecipeCount, 1)
//        XCTAssertEqual(recipeWriterMock.invokedDeleteRecipeParameter, "Test")
//    }
//    
//    func testCheckIfRecipeIsSaved() {
//        recipePeeckerMock.stubbedIsRecipeAlreadySaved = true
//        
//        let isRecipeSaved = recipeDetailsViewModel.checkIfRecipeIsAlreadySaved(with: "Test")
//        
//        XCTAssertEqual(recipePeeckerMock.checkIfRecipeIsAlreadySavedCount, 1)
//        XCTAssertEqual(recipePeeckerMock.invokedCheckIfRecipeIsAlreadySavedParameter, "Test")
//        XCTAssertEqual(isRecipeSaved, true)
//    }
//    
//    func testCheckIfRecipeIsNotSaved() {
//        recipePeeckerMock.stubbedIsRecipeAlreadySaved = false
//        
//        let isRecipeSaved = recipeDetailsViewModel.checkIfRecipeIsAlreadySaved(with: "Test")
//        
//        XCTAssertEqual(recipePeeckerMock.checkIfRecipeIsAlreadySavedCount, 1)
//        XCTAssertEqual(recipePeeckerMock.invokedCheckIfRecipeIsAlreadySavedParameter, "Test")
//        XCTAssertEqual(isRecipeSaved, false)
//    }
}
