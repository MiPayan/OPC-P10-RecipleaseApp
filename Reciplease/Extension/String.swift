//
//  String.swift
//  Reciplease
//
//  Created by Mickael PAYAN on 05/08/2022.
//

import Foundation

extension String {
    func condenseWhitespace() -> Self {
        let components = self.components(separatedBy: .whitespacesAndNewlines)
        return components.filter { !$0.isEmpty }.joined(separator: " ")
    }
    
    func withCapitalizeFirstLetter() -> Self {
      prefix(1).uppercased() + self.lowercased().dropFirst()
    }
}
