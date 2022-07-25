//
//  EdamamResponseMock.swift
//  RecipleaseTests
//
//  Created by Mickael PAYAN on 02/06/2022.
//

import XCTest
import Alamofire
@testable import Reciplease

final class EdamamResponseMock {
    
    // MARK: - Properties
    
    var response: HTTPURLResponse?
    var result: Result<EdamamResponse, AFError>!
    static let validResponse = HTTPURLResponse(url: URL(string: "https://www.apple.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
    static let invalidResponse = HTTPURLResponse(url: URL(string: "https://www.apple.com")!, statusCode: 500, httpVersion: nil, headerFields: nil)!
    
    // MARK: - Method
    
    func make() -> EdamamResponse? {
        let bundle = Bundle(for: type(of: self))
        guard let url = bundle.url(forResource: "EdamamResponse", withExtension: "json") else {
            fatalError("Missing file: EdamamResponse.json")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load EdamamResponse.json from bundle.")
        }
        
        let decoder = JSONDecoder()
        guard let response = try? decoder.decode(EdamamResponse.self, from: data) else {
            fatalError("Failed to decode EdamamResponse.json from bundle ")
        }
        
        return response
    }
}
