//
//  HealthInformationCollectionViewCell.swift
//  Reciplease
//
//  Created by Mickael PAYAN on 01/09/2021.
//
//    swiftlint:disable trailing_whitespace

import UIKit

final class HealthInformationCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var healthTextField: TextFieldSettingsRecipeDetailsView!
    
    func configureText(with text: String) {
        healthTextField.text = text
    }
}
