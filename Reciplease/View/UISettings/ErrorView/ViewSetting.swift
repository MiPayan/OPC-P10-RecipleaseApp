//
//  ViewSetting.swift
//  Reciplease
//
//  Created by Mickael PAYAN on 08/06/2022.
//

import UIKit

@IBDesignable final class ViewSetting: UIView {
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 13
        layer.masksToBounds = true
    }
}
