//
//  Double+String.swift
//  Reciplease
//
//  Created by Mickael PAYAN on 01/09/2021.
//

import Foundation

extension Double {
    
    //    To reduce the size of the number after the comma.
    func toTruncatedString() -> String {
        let numberFormatter = NumberFormatter()
        let number = NSNumber(value: self)
        numberFormatter.minimumFractionDigits = 0
        numberFormatter.maximumFractionDigits = 0
        return String(numberFormatter.string(from: number) ?? "\(self)")
    }
}
