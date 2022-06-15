//
//  RecipeTableViewCell.swift
//  Reciplease
//
//  Created by Mickael PAYAN on 23/08/2021.
//

import UIKit

final class RecipeSearchResultTableViewCell: UITableViewCell {
    @IBOutlet private weak var recipeImageView: UIImageView!
    @IBOutlet private weak var recipeLabel: UILabel!
    @IBOutlet private weak var ingredientLabel: UILabel!
    @IBOutlet private weak var favoriteButton: RoundedButtonSetting!
    @IBOutlet private weak var detailsLabel: UILabel!
    private let recipes = Recipes()
    private var recipe: RecipeResponse?
    
    func configureCell(recipe: RecipeResponse) {
        guard let recipeImage = recipe.image,
              let urlString = URL(string: recipeImage) else { return }
        let recipeText = recipe.label
        let ingredientText = recipe.ingredients.compactMap({ $0.text }).joined(separator: " • ")
        let totalTime = String(recipe.totalTime) + " min "
        let calories = String(recipe.calories.toTruncatedString()) + " kcal "
        let yield = String(recipe.yield) + " pers. "
        let detailsText = totalTime + " • " + calories + " • " + yield
        recipeLabel.text = recipeText
        ingredientLabel.text = ingredientText
        detailsLabel.text = detailsText
        recipeImageView.loadImage(url: urlString)
        recipeImageView.clipsToBounds = true
        recipeImageView.layer.cornerRadius = 10
        self.recipe = recipe
        configureFavoriteButton()
    }
    
    @IBAction private func didTapFavoriteButton(_ sender: Any) {
        if let recipe = recipe {
            if recipes.checkIfRecipeIsAlreadySaved(recipe.label) == true {
                recipes.deleteRecipeFromFavorite(recipe.label)
            } else {
                recipes.saveRecipe(recipe)
            }
            configureFavoriteButton()
        }
    }
    
    private func configureFavoriteButton() {
        if let recipe = recipe {
            let isRecipeAlreadySaved = recipes.checkIfRecipeIsAlreadySaved(recipe.label)
            let imageString = isRecipeAlreadySaved ? "heart.fill" : "heart"
            favoriteButton.setImage(UIImage(systemName: imageString), for: .normal)
        }
    }
}
