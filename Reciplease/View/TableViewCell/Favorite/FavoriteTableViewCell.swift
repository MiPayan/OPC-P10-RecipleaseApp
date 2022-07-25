//
//  FavoriteTableViewCell.swift
//  Reciplease
//
//  Created by Mickael PAYAN on 21/10/2021.
//

import Foundation
import UIKit

final class FavoriteTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    @IBOutlet private weak var recipeImageView: UIImageView!
    @IBOutlet private weak var recipeLabel: UILabel!
    @IBOutlet private weak var ingredientLabel: UILabel!
    @IBOutlet private weak var detailsLabel: UILabel!
    var deleteHandler: (() -> Void) = {}
    
    // MARK: - Method
    
    func configureCell(_ recipe: Recipes) {
        guard let imageString = recipe.image,
              let urlString = URL(string: imageString),
              let totalTime = recipe.totalTime,
              let calorie = recipe.calorie,
              let yield = recipe.yield else { return }
        let detailsText = totalTime + " min " + " • " + calorie + " kcal " + " • " + yield + " pers. "
        recipeImageView.loadImage(url: urlString)
        recipeImageView.clipsToBounds = true
        recipeImageView.layer.cornerRadius = 10
        recipeLabel.text = recipe.label
        ingredientLabel.text = recipe.ingredient
        detailsLabel.text = detailsText
    }
    
    // MARK: - IBAction Method
    
    @IBAction func didTapFavoriteButton(_ sender: Any) {
        deleteHandler()
    }
}
