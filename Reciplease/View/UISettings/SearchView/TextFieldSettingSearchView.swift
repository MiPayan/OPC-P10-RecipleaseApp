//
//  TextFieldSettingSearchView.swift
//  Reciplease
//
//  Created by Mickael PAYAN on 25/08/2021.
//

import UIKit

@IBDesignable final class TextFieldSettingSearchView: UITextField {
    override func layoutSubviews() {
        super.layoutSubviews()
        clipsToBounds = true
        layer.cornerRadius = 10
        layer.masksToBounds = true
        
//  To make border color when the UITextField isn't enabled.
//  You can see it apply when an ingredient is added to the ingredient array (SearchIngredientViewController), or for recipe health information (RecipeDetailsViewController).
        if !isEnabled {
            layer.borderWidth = 1
            layer.borderColor = .randomBorderColor
        }
    }
}
