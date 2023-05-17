//
//  IngredientTableViewCellViewModel.swift
//  Reciplease
//
//  Created by Mickael PAYAN on 17/05/2023.
//

import Foundation

final class IngredientTableViewCellViewModel {
    
    private var ingredientResponse: IngredientResponse
    
    init(ingredientResponse: IngredientResponse) {
        self.ingredientResponse = ingredientResponse
    }
    
    var ingredientImageURL: URL? {
        URL(string: ingredientResponse.image ?? "")
    }
    
    var ingredientText: String {
        ingredientResponse.text
    }
}
