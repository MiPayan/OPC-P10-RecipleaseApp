//
//  IngredientCellCollectionViewCell.swift
//  Reciplease
//
//  Created by Mickael PAYAN on 17/08/2021.
//

import UIKit

final class IngredientCollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var ingredientsTextField: UITextField!

    func displayText(_ text: String) {
        ingredientsTextField.text = text
    }
}
