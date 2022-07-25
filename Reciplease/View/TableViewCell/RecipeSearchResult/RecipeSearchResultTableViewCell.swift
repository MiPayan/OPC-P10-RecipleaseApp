//
//  RecipeTableViewCell.swift
//  Reciplease
//
//  Created by Mickael PAYAN on 23/08/2021.
//

import UIKit

final class RecipeSearchResultTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    @IBOutlet private weak var recipeImageView: UIImageView!
    @IBOutlet private weak var recipeLabel: UILabel!
    @IBOutlet private weak var ingredientLabel: UILabel!
    @IBOutlet private weak var favoriteButton: RoundedButtonSetting!
    @IBOutlet private weak var detailsLabel: UILabel!
    private let recipeSearchResultViewModel = RecipeSearchResultViewModel()
    private var recipe: RecipeResponse?
    
    // MARK: - Methods
    
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
        guard let recipe = recipe else { return }
        if recipeSearchResultViewModel.checkIfRecipeIsAlreadySaved(with: recipe.label) {
            recipeSearchResultViewModel.deleteRecipe(with: recipe.label)
        } else {
            recipeSearchResultViewModel.saveRecipe(with: recipe)
        }
        configureFavoriteButton()
    }
    
    private func configureFavoriteButton() {
        guard let recipe = recipe else { return }
        let isRecipeAlreadySaved = recipeSearchResultViewModel.checkIfRecipeIsAlreadySaved(with: recipe.label)
        let imageString = isRecipeAlreadySaved ? "heart.fill" : "heart"
        favoriteButton.setImage(UIImage(systemName: imageString), for: .normal)
    }
}
