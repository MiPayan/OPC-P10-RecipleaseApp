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
    private var coreDataStackMock: CoreDataStackMock!
    private var edamamResponseMock: EdamamResponseMock!
    
    // MARK: - Test Life Cycle
    
    override func setUpWithError() throws {
        recipePeeckerMock = RecipePeeckingMock()
        recipeWriterMock = RecipeWritingMock()
        favoriteViewModel = FavoriteViewModel(recipePeecker: recipePeeckerMock, recipeWriter: recipeWriterMock)
        coreDataStackMock = CoreDataStackMock(modelName: "Reciplease")
        edamamResponseMock = EdamamResponseMock()
    }
    
    override func tearDownWithError() throws {
        favoriteViewModel = nil
        recipePeeckerMock = nil
        recipeWriterMock = nil
        coreDataStackMock = nil
        edamamResponseMock = nil
    }
    
    // MARK: - Methods
    
    func testRecipes() {
        recipePeeckerMock.stubbedRecipes = [Recipes(), Recipes()]
        
        let recipesTwo = favoriteViewModel.recipes
        XCTAssertEqual(recipePeeckerMock.invokedRecipesCount, 1)
        XCTAssertEqual(recipesTwo.count, 2)
    }
    
    func testRecipesCount() {
        recipePeeckerMock.stubbedRecipes = [Recipes(), Recipes()]
        
        let recipesCount = favoriteViewModel.recipesCount
        XCTAssertEqual(recipePeeckerMock.invokedRecipesCount, 1)
        XCTAssertEqual(recipesCount, 2)
    }
    
    func testTransformStringToIngredientArray() {
        // Given
        // When
        // Then
    }
    
    func testDeleteRecipe() {
        let recipeLabel = "Test"
        
        favoriteViewModel.deleteRecipe(recipeLabel: recipeLabel)
        XCTAssertEqual(recipeWriterMock.invokedDeleteRecipeCount, 1)
        XCTAssertEqual(recipeWriterMock.invokedDeleteRecipeParameter, "Test")
    }
    
    func testConfigureTableView() {
        // Given
        let managedContext = coreDataStackMock.persistentContainer.viewContext
        let index = 0
        let recipes = Recipes(context: managedContext)
        recipes.label = "label"
        recipes.image = "image"
        recipes.url = "url"
        recipes.yield = "0"
        recipes.healthLabel = "healthLabel"
        recipes.ingredient = "ingredient"
        recipes.ingredientImage = "ingredientImage"
        recipes.calorie = "0"
        recipes.totalTime = "0"
        
        recipePeeckerMock.stubbedRecipes = [recipes]
        
        // When
        favoriteViewModel.configureTableView(with: index)
        
        // Then
        XCTAssertEqual(recipePeeckerMock.invokedRecipesCount, 1)
        XCTAssertEqual(favoriteViewModel.selectedRecipe!.label, "label")
        XCTAssertEqual(favoriteViewModel.selectedRecipe!.image, "image")
        XCTAssertEqual(favoriteViewModel.selectedRecipe!.url, "url")
        XCTAssertEqual(favoriteViewModel.selectedRecipe!.yield, Int("0"))
        XCTAssertEqual(favoriteViewModel.selectedRecipe!.healthLabels, ["healthLabel"])
        XCTAssertEqual(favoriteViewModel.selectedRecipe!.ingredients.first!.text, "ingredient")
        XCTAssertEqual(favoriteViewModel.selectedRecipe!.ingredients.first!.image, "ingredientImage")
        XCTAssertEqual(favoriteViewModel.selectedRecipe!.calories, Double("0"))
        XCTAssertEqual(favoriteViewModel.selectedRecipe!.totalTime, Int("0"))
    }
}
