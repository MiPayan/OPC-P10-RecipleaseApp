//
//  RandomBorderColor+CGColor.swift
//  Reciplease
//
//  Created by Mickael PAYAN on 02/09/2021.
//

import UIKit

extension CGColor {
    
    static var randomBorderColor: CGColor {
        return CGColor(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1),
            alpha: 1.0
        )
    }
}
