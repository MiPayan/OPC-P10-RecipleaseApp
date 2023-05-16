//
//  RecipeSearchResultTableViewCellViewModel.swift
//  Reciplease
//
//  Created by Mickael PAYAN on 16/05/2023.
//

import Foundation

final class RecipeSearchResultTableViewCellViewModel {
    
    // MARK: - Properties
    
    var recipeResponse: RecipeResponse
    private let recipeWriter: RecipeWriting
    private let recipePeecker: RecipePeecking
    
    // MARK: - Init
    
    init(
        recipeResponse: RecipeResponse,
        recipeWriter: RecipeWriting = CoreDataManager.shared,
        recipePeecker: RecipePeecking = CoreDataManager.shared
    ) {
        self.recipeResponse = recipeResponse
        self.recipeWriter = recipeWriter
        self.recipePeecker = recipePeecker
    }
    
    // MARK: - Methods
    
    var recipeImageURL: URL? {
        URL(string: recipeResponse.image ?? "")
    }
    
    var recipeText: String {
        recipeResponse.label
    }
    
    var ingredientText: String {
        recipeResponse.ingredients.compactMap({ $0.text }).joined(separator: " • ")
    }
    
    var detailsRecipeText: String {
        totalTimeText + " • " + caloriesText + " • " + yieldText
    }
    
    private var totalTimeText: String {
        String(recipeResponse.totalTime) + " min "
    }
    
    private var caloriesText: String {
        String(recipeResponse.calories.toTruncatedString()) + " kcal "
    }
    
    private var yieldText: String {
        String(recipeResponse.yield) + " pers. "
    }
}

extension RecipeSearchResultTableViewCellViewModel {    
    var checkIfRecipeIsAlreadySaved: Bool {
        recipePeecker.checkIfRecipeIsAlreadySaved(recipeText) ? true : false
    }
    
    var saveRecipe: () {
        recipeWriter.saveRecipe(recipeResponse)
    }
    
    var deleteRecipe: () {
        recipeWriter.deleteRecipeFromFavorite(recipeText)
    }
}
