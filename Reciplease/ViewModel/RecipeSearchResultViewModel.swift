//
//  RecipeSearchResultViewModel.swift
//  Reciplease
//
//  Created by Mickael PAYAN on 28/06/2022.
//

import Foundation

final class RecipeSearchResultViewModel {
    
    // MARK: - Properties
    
    private let recipeWriter: RecipeWriting
    private let recipePeecker: RecipePeecking
    
    // MARK: - Init
    
    init(
        recipeWriter: RecipeWriting = CoreDataManager.shared,
        recipePeecker: RecipePeecking = CoreDataManager.shared
    ) {
        self.recipeWriter = recipeWriter
        self.recipePeecker = recipePeecker
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
