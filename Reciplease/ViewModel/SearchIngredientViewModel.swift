//
//  SearchIngredientViewModel.swift
//  Reciplease
//
//  Created by Mickael PAYAN on 03/01/2022.
//
// swiftlint:disable empty_enum_arguments

import Foundation

final class SearchIngredientViewModel {
    
    // MARK: - Properties
    
    var edamamData: EdamamResponse?
    var successHandler: (() -> Void) = { }
    var failureHandler: (() -> Void) = { }
    private let recipeService: RecipeServiceProtocol
    private(set) var ingredientArray = [String]()
    
    // MARK: - Init
    
    init(recipeService: RecipeServiceProtocol) {
        self.recipeService = recipeService
    }
    
    // MARK: - Methods
    
    //    The ingredient must be formatted and cannot contain the same ingredient twice before being added to the array.
    func formatIngredientArray(ingredient: String) -> Bool {
        if !ingredient.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty,
           !ingredientArray.contains(ingredient) {
            ingredientArray.append(ingredient.trimmingCharacters(in: .whitespacesAndNewlines))
            return true
        }
        return false
    }
    
    func countIngredient() -> Int {
        return ingredientArray.count
    }
    
    func removeIngredient(at index: Int) {
        ingredientArray.remove(at: index)
    }
    
    func removeAllIngredients() {
        ingredientArray.removeAll()
    }
    
    //    Use the service to get recipe data.
    func getRecipe() {
        recipeService.getRecipe(ingredientArray.joined(separator: "+")) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let recipe):
                self.edamamData = recipe
                self.successHandler()
            case .failure(_):
                self.failureHandler()
            }
        }
    }
}
