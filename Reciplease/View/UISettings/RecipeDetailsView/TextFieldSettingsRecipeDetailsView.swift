//
//  TextFieldSettingsRecipeDetailsView.swift
//  Reciplease
//
//  Created by Mickael PAYAN on 28/10/2021.
//

import UIKit

@IBDesignable final class TextFieldSettingsRecipeDetailsView: UITextField {
    override func layoutSubviews() {
        super.layoutSubviews()
        clipsToBounds = true
        layer.cornerRadius = frame.height / 2
        layer.borderWidth = 1
        layer.borderColor = .randomBorderColor
        layer.masksToBounds = true
    }
}
