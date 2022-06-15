//
//  IngredientCellCollectionViewCell.swift
//  Reciplease
//
//  Created by Mickael PAYAN on 17/08/2021.
//

import UIKit

final class IngredientCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var ingredientTextField: TextFieldSettingSearchView!

    func configureIngredientLabel(_ text: String) {
        ingredientTextField.text = text
    }
}
