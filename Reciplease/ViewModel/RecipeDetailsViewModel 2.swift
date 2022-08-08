//
//  RecipeDetailsViewModel.swift
//  Reciplease
//
//  Created by Mickael PAYAN on 28/06/2022.
//

import Foundation

final class RecipeDetailsViewModel {
    
    // MARK: - Properties
    
    private let recipePeecker: RecipePeecking
    private let recipeWriter: RecipeWriting
    
    // MARK: - Init
    
    init(
        recipePeecker: RecipePeecking = CoreDataManager.shared,
        recipeWriter: RecipeWriting = CoreDataManager.shared
    ) {
        self.recipePeecker = recipePeecker
        self.recipeWriter = recipeWriter
    }
    
    // MARK: - Methods
    
    func saveRecipe(with recipe: RecipeResponse) {
        recipeWriter.saveRecipe(recipe)
    }
    
    func deleteRecipe(with recipeLabel: String) {
        recipeWriter.deleteRecipeFromFavorite(recipeLabel)
    }
    
    func checkIfRecipeIsAlreadySaved(with recipeLabel: String) -> Bool {
        if recipePeecker.checkIfRecipeIsAlreadySaved(recipeLabel) {
            return true
        } else {
            return false
        }
    }
}
