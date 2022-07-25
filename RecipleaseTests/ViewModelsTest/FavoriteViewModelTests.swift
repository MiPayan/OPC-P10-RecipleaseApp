//
//  FavoriteViewModelTests.swift
//  RecipleaseTests
//
//  Created by Mickael PAYAN on 05/04/2022.
//

import XCTest
import CoreData
@testable import Reciplease

final class FavoriteViewModelTests: XCTestCase {
    
    // MARK: - Properties
    
    private var favoriteViewModel: FavoriteViewModel!
    private var recipePeeckerMock: RecipePeeckingMock!
    private var recipeWriterMock: RecipeWritingMock!
    private var edamamResponseMock: EdamamResponseMock!
    
    // MARK: - Test Life Cycle
    
    override func setUpWithError() throws {
        recipePeeckerMock = RecipePeeckingMock()
        recipeWriterMock = RecipeWritingMock()
        favoriteViewModel = FavoriteViewModel(recipePeecker: recipePeeckerMock, recipeWriter: recipeWriterMock)
        edamamResponseMock = EdamamResponseMock()
    }
    
    override func tearDownWithError() throws {
        favoriteViewModel = nil
        recipePeeckerMock = nil
        recipeWriterMock = nil
        edamamResponseMock = nil
    }
    
    // MARK: - Methods
    
    func testRecipes() {
        //        Given
        recipePeeckerMock.stubbedRecipes = [Recipes(), Recipes()]
        
        //        When
        let recipesTwo = favoriteViewModel.recipes
        
        //        Then
        XCTAssertEqual(recipePeeckerMock.invokedRecipesCount, 1)
        XCTAssertEqual(recipesTwo.count, 2)
    }
    
    func testRecipesCount() {
        //        Given
        recipePeeckerMock.stubbedRecipes = [Recipes(), Recipes()]
        
        //        When
        let recipesCount = favoriteViewModel.recipesCount
        
        //        Then
        XCTAssertEqual(recipePeeckerMock.invokedRecipesCount, 1)
        XCTAssertEqual(recipesCount, 2)
    }
    
    func testTransformStringToIngredientArray() {
        
    }
    
    func testDeleteRecipe() {
        let recipeLabel = "Test"
        
        favoriteViewModel.deleteRecipe(recipeLabel: recipeLabel)
        XCTAssertEqual(recipeWriterMock.invokedDeleteRecipeCount, 1)
        XCTAssertEqual(recipeWriterMock.invokedDeleteRecipeParameter, "Test")
    }
    
    func testConfigureTableView() {
        
    }
}
