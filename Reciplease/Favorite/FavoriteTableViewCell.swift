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
    private var viewModel: FavoriteTableViewCellViewModel?
    var deleteHandler: (() -> Void) = {}
    
    // MARK: - Method
    
    func configureCell(with viewModel: FavoriteTableViewCellViewModel) {
        self.viewModel = viewModel
        if let url = viewModel.recipeImage {
            recipeImageView.loadImage(url: url)
        }
        recipeImageView.clipsToBounds = true
        recipeImageView.layer.cornerRadius = 10
        recipeLabel.text = viewModel.recipeText
        ingredientLabel.text = viewModel.ingredientText
        detailsLabel.text = viewModel.detailsText
    }
    
    // MARK: - IBAction Method
    
    @IBAction func didTapFavoriteButton(_ sender: Any) {
        deleteHandler()
    }
}
