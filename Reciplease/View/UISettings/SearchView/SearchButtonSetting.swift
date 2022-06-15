//
//  SearchButtonSetting.swift
//  Reciplease
//
//  Created by Mickael PAYAN on 17/08/2021.
//

import UIKit

@IBDesignable final class SearchButtonSetting: UIButton {
    override func layoutSubviews() {
        super.layoutSubviews()
        clipsToBounds = true
        layer.cornerRadius = 10
        layer.borderWidth = 0.1
        layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }
}
