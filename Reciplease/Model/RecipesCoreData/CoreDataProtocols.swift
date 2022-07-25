//
//  CoreDataProtocols.swift
//  Reciplease
//
//  Created by Mickael PAYAN on 28/06/2022.
//

import Foundation

protocol RecipePeecking {
    var recipes: [Recipes] { get }
    func checkIfRecipeIsAlreadySaved(_ label: String) -> Bool
}

protocol RecipeWriting {
    func saveRecipe(_ recipe: RecipeResponse)
    func deleteRecipeFromFavorite(_ recipe: String)
}
