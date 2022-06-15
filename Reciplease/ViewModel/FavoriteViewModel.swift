//
//  FavoriteViewModel.swift
//  Reciplease
//
//  Created by Mickael PAYAN on 18/03/2022.
//

import Foundation

final class FavoriteViewModel {
    
    private(set) var recipes = Recipes()
    private(set) var selectedRecipe: RecipeResponse?
    
    func transformStringToIngredientArray(text: String, image: String) -> [IngredientResponse] {
        let textArray = text.components(separatedBy: " - ")
        let imageArray = image.components(separatedBy: " - ")
        var ingredients: [IngredientResponse] = []
        
        for (index, text) in textArray.enumerated() {
            var image: String?
            if imageArray.indices.contains(index) {
                image = imageArray[index]
            }
            let ingredient = IngredientResponse(text: text, image: image)
            ingredients.append(ingredient)
        }
        return ingredients
    }
    
    func countRecipes() -> Int {
        return recipes.recipes.count
    }

    func configureTableView(with index: Int) {
        let recipe = recipes.recipes[index]
        guard let recipeText = recipe.label,
              let image = recipe.image,
              let url = recipe.url,
              let yield = recipe.yield,
              let intYield = Int(yield),
              let healthLabel = recipe.healthLabel,
              let ingredientsString = recipe.ingredient,
              let ingredientsImageString = recipe.ingredientImage,
              let calorie = recipe.calorie,
              let doubleCalories = Double(calorie),
              let totalTime = recipe.totalTime,
              let intTotalTime = Int(totalTime) else { return }
        
        selectedRecipe = RecipeResponse(
            label: recipeText,
            image: image,
            url: url,
            yield: intYield,
            healthLabels: healthLabel.components(separatedBy: ","),
            ingredients: transformStringToIngredientArray(
                text: ingredientsString,
                image: ingredientsImageString
            ),
            calories: doubleCalories,
            totalTime: intTotalTime
        )
    }
}
