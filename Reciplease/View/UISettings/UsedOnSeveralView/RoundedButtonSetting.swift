//
//  RoundKnobSetting.swift
//  Reciplease
//
//  Created by Mickael PAYAN on 27/08/2021.
//

import UIKit

@IBDesignable final class RoundedButtonSetting: UIButton {
    override func layoutSubviews() {
        super.layoutSubviews()
        clipsToBounds = true
        layer.cornerRadius = frame.height / 2
    }
}
