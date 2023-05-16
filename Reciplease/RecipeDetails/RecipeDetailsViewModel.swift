//
//  RecipeDetailsViewModel.swift
//  Reciplease
//
//  Created by Mickael PAYAN on 16/05/2023.
//

import Foundation

final class RecipeDetailsViewModel {
    
    var recipeResponse: RecipeResponse?
    let numberOfSections = 1
        
    var ingredientsCount: Int {
        recipeResponse?.ingredients.count ?? 0
    }
}
