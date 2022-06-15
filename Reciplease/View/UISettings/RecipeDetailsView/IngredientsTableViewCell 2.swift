//
//  IngredientsTableViewCell.swift
//  Reciplease
//
//  Created by Mickael PAYAN on 02/09/2021.
//

import UIKit

final class IngredientsTableViewCell: UITableViewCell {

    @IBOutlet weak var ingredientsImageView: UIImageView!
    @IBOutlet weak var ingredientsLabel: UILabel!

    func configureIngredientLabels(with text: String) {
        ingredientsLabel.text = text
    }

    func configureIngredientImages(with URL: URL) {
        ingredientsImageView.loadImage(url: URL)
        ingredientsImageView.layer.cornerRadius = ingredientsImageView.frame.height / 2
        ingredientsImageView.layer.borderWidth = 1
    }
}
