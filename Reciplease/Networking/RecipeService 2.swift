//
//  SearchRecipeAPI.swift
//  Reciplease
//
//  Created by Mickael PAYAN on 05/08/2021.
//
//    swiftlint:disable line_length

import Foundation

final class RecipeService {
    private let apiService: Networking
    private let endpoint = "https://api.edamam.com/search?"
    private let searchRecipeId = "0b523699"
    private let seachRecipeKey = "474128c0954d443d6caa1baa02198c93"

    init(apiService: Networking = .init()) {
        self.apiService = apiService
    }

    func getRecipe(_ query: String, _ completion: @escaping (Result<RecipesData, Networking.APIError>) -> Void) {
        apiService.getJSON(urlString: "\(endpoint)&q=\(query)&app_id=\(searchRecipeId)&app_key=\(seachRecipeKey)") { (result: Result<RecipesData, Networking.APIError>) in
            switch result {
            case .success(let search):
                completion(.success(search))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
