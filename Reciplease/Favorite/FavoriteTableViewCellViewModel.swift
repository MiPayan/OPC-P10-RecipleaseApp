//
//  FavoriteTableViewCellViewModel.swift
//  Reciplease
//
//  Created by Mickael PAYAN on 17/05/2023.
//

import Foundation

final class FavoriteTableViewCellViewModel {
    
    private var recipe: Recipes
    
    init(recipe: Recipes) {
        self.recipe = recipe
    }
    
    var recipeImage: URL? {
        URL(string: recipe.image ?? "")
    }
    
    var recipeText: String {
        recipe.label ?? ""
    }
    
    var ingredientText: String {
        recipe.ingredient ?? ""
    }
        
    var detailsText: String {
        totalTimeText + " • " + caloriesText + " • " + yieldText
    }
    
    private var totalTimeText: String {
        recipe.totalTime ?? ""
    }
    
    private var caloriesText: String {
        recipe.calorie ?? ""
    }
    
    private var yieldText: String {
        recipe.yield ?? ""
    }
}
