//
//  RecipeResponse.swift
//  Reciplease
//
//  Created by Mickael PAYAN on 11/08/2021.
//

import Foundation

struct RecipeResponse: Decodable {
    let label: String
    let image: String?
    let url: String
    let yield: Int
    let healthLabels: [String]
    let ingredients: [IngredientResponse]
    let calories: Double
    let totalTime: Int
}
