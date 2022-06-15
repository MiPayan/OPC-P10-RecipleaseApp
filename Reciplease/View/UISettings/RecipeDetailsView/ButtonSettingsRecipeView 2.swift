//
//  SettingButtonRecipeView.swift
//  Reciplease
//
//  Created by Mickael PAYAN on 27/08/2021.
//

import UIKit

@IBDesignable final class ButtonSettingsRecipeView: UIButton {
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = frame.height / 2
    }
}
