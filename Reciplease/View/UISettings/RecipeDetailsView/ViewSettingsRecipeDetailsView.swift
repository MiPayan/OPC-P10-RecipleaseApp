//
//  ViewSettingsRecipeDetailsView.swift
//  Reciplease
//
//  Created by Mickael PAYAN on 29/11/2021.
//

import UIKit

// To make a rounding only on the upper corners.
@IBDesignable final class ViewSettingsRecipeDetailsView: UIView {
    override func layoutSubviews() {
        super.layoutSubviews()
        clipsToBounds = true
        let path = UIBezierPath(
            roundedRect: self.bounds,
            byRoundingCorners: [.topLeft, .topRight],
            cornerRadii: CGSize(width: 10, height: 10)
        )
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        layer.mask = maskLayer
        layer.masksToBounds = true
    }
}
