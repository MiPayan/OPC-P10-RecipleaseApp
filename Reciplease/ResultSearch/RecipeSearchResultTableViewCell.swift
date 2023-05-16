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
    private var viewModel: RecipeSearchResultTableViewCellViewModel?
    
    // MARK: - Methods
    
    func configureCell(with viewModel: RecipeSearchResultTableViewCellViewModel) {
        self.viewModel = viewModel
        recipeLabel.text = viewModel.recipeText
        ingredientLabel.text = viewModel.ingredientText
        detailsLabel.text = viewModel.detailsRecipeText
        if let url = viewModel.recipeImageURL {
            recipeImageView.loadImage(url: url)
        }
        recipeImageView.clipsToBounds = true
        recipeImageView.layer.cornerRadius = 10
        configureFavoriteButton()
    }
    
    @IBAction private func didTapFavoriteButton(_ sender: Any) {
        guard let viewModel = viewModel else { return }
        viewModel.checkIfRecipeIsAlreadySaved ? viewModel.deleteRecipe : viewModel.saveRecipe
        configureFavoriteButton()
    }
    
    private func configureFavoriteButton() {
        guard let viewModel = viewModel else { return }
        let imageString = viewModel.checkIfRecipeIsAlreadySaved ? "heart.fill" : "heart"
        favoriteButton.setImage(UIImage(systemName: imageString), for: .normal)
    }
}
