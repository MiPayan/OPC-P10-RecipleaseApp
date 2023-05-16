//
//  RecipeDetailsTableViewCellViewModel.swift
//  Reciplease
//
//  Created by Mickael PAYAN on 16/05/2023.
//

import Foundation

final class RecipeDetailsTableViewCellViewModel {
    
    var recipeResponse: RecipeResponse
    private let recipePeecker: RecipePeecking
    private let recipeWriter: RecipeWriting
    
    init(
        recipeResponse: RecipeResponse,
        recipePeecker: RecipePeecking = CoreDataManager.shared,
        recipeWriter: RecipeWriting = CoreDataManager.shared
    ) {
        self.recipeResponse = recipeResponse
        self.recipePeecker = recipePeecker
        self.recipeWriter = recipeWriter
    }
    
    var recipeText: String {
        recipeResponse.label
    }
    
    var recipeImageURL: URL? {
        URL(string: recipeResponse.image ?? "")
    }
    
    var totalTimeText: String {
        String(recipeResponse.totalTime) + " min"
    }
    
    var caloriesText: String {
        String(recipeResponse.calories.toTruncatedString()) + " kcal"
    }
    
    var yieldText: String {
        String(recipeResponse.yield) + " pers."
    }
    
    var urlToRecipePreparation: URL? {
        URL(string: recipeResponse.url)
    }
    
    var healthLabelsCount: Int {
        recipeResponse.healthLabels.count
    }
    
    func makeHealthText(at index: Int) -> String {
        recipeResponse.healthLabels[index]
    }
}

extension RecipeDetailsTableViewCellViewModel {
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
