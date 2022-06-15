//
//  ViewSettingInsideTheCell.swift
//  Reciplease
//
//  Created by Mickael PAYAN on 22/11/2021.
//

import UIKit

@IBDesignable final class ViewSettingInsideTheCell: UIView {
    override func layoutSubviews() {
        super.layoutSubviews()
        clipsToBounds = true
        layer.borderWidth = 0.1
        layer.cornerRadius = 10
    }
}
