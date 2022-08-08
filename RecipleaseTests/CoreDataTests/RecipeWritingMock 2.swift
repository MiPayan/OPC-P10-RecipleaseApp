//
//  RecipeWritingMock.swift
//  RecipleaseTests
//
//  Created by Mickael PAYAN on 05/07/2022.
//

import Foundation
@testable import Reciplease

final class RecipeWritingMock: RecipeWriting {
    
    var invokedSaveRecipeParameter: RecipeResponse?
    var invokedSaveRecipeCount = 0
    
    func saveRecipe(_ recipe: RecipeResponse) {
        invokedSaveRecipeCount += 1
        invokedSaveRecipeParameter = recipe
    }
    
    var invokedDeleteRecipeParameter: String?
    var invokedDeleteRecipeCount = 0
    
    func deleteRecipeFromFavorite(_ recipe: String) {
        invokedDeleteRecipeCount += 1
        invokedDeleteRecipeParameter = recipe
    }
}
