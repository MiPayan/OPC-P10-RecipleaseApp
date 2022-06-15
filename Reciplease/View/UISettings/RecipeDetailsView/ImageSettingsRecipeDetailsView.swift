//
//  ImageSettingsRecipeDetailsView.swift
//  Reciplease
//
//  Created by Mickael PAYAN on 08/09/2021.
//

import UIKit

@IBDesignable final class ImageSettingsRecipeDetailsView: UIImageView {
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 10
        layer.masksToBounds = true
    }
}
