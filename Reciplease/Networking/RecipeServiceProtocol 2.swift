//
//  RecipeServiceProtocol.swift
//  Reciplease
//
//  Created by Mickael PAYAN on 28/06/2022.
//

import Foundation
import Alamofire

protocol RecipeServiceProtocol {
    func getRecipe(
        _ query: String,
        completionHandler: @escaping (Result<EdamamResponse, AFError>) -> Void
    )
}
