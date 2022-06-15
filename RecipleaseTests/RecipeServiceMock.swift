//
//  RecipeServiceMock.swift
//  RecipleaseTests
//
//  Created by Mickael PAYAN on 28/04/2022.
//

import Alamofire
@testable import Reciplease

final class RecipeServiceMock: RecipeServiceProtocol {
    
    var invokedGetRecipeCount = 0
    var stubbedResult: Result<EdamamResponse, AFError>!
    var invokedGetRecipeQueryParameter: String?
    
    func getRecipe(_ query: String, completionHandler: @escaping (Result<EdamamResponse, AFError>) -> Void) {
        invokedGetRecipeCount += 1
        invokedGetRecipeQueryParameter = query
        completionHandler(stubbedResult)
    }
}
