//
//  IngredientTableViewCell.swift
//  Reciplease
//
//  Created by Mickael PAYAN on 29/09/2021.
//

import UIKit

final class IngredientTableViewCell: UITableViewCell {
    @IBOutlet private weak var ingredientImageView: UIImageView!
    @IBOutlet private weak var ingredientLabel: UILabel!
    
    func configureCell(with url: URL?, ingredientText: String) {
        if let url = url {
            ingredientImageView.loadImage(url: url)
        }
        ingredientImageView.layer.cornerRadius = ingredientImageView.frame.height / 2
        ingredientLabel.text = ingredientText
    }
}
