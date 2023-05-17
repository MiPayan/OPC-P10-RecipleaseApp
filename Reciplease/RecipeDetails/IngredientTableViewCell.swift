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
    private var viewModel: IngredientTableViewCellViewModel?
    
    func configureCell(with viewModel: IngredientTableViewCellViewModel) {
        self.viewModel = viewModel
        if let url = viewModel.ingredientImageURL {
            ingredientImageView.loadImage(url: url)
        }
        ingredientImageView.layer.cornerRadius = ingredientImageView.frame.height / 2
        ingredientLabel.text = viewModel.ingredientText
    }
}
