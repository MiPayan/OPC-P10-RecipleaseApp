//
//  RecipeService.swift
//  Reciplease
//
//  Created by Mickael PAYAN on 25/11/2021.
//

import Foundation
import Alamofire

final class RecipeService: RecipeServiceProtocol {
    
    // MARK: - Propperties
    
    private let session: NetworkProtocol
    private let endpoint = "https://api.edamam.com/api/recipes/v2?type=public"
    private let appId = "0b523699"
    private let appKey = "474128c0954d443d6caa1baa02198c93"
    
    // MARK: - Init
    
    init(session: NetworkProtocol = NetworkSession()) {
        self.session = session
    }
    
    // MARK: - Method
    
    func getRecipe(_ query: String, completionHandler: @escaping (Result<EdamamResponse, AFError>) -> Void) {
        session.request(urlString: "\(endpoint)&q=\(query)&app_id=\(appId)&app_key=\(appKey)") { response in
            switch response.result {
            case .success(let sucess):
                completionHandler(.success(sucess))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
}
