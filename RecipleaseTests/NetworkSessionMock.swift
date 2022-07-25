//
//  NetworkSessionMock.swift
//  RecipleaseTests
//
//  Created by Mickael PAYAN on 14/06/2022.
//

import Foundation
import Alamofire
@testable import Reciplease

final class NetworkSessionMock: NetworkProtocol {
    
    // MARK: - Property
    
    let responseMock: EdamamResponseMock
    
    // MARK: - Init
    
    init(responseMock: EdamamResponseMock) {
        self.responseMock = responseMock
    }
    
    // MARK: - Method
    
    func request(url: URL, completionHandler: @escaping (AFDataResponse<EdamamResponse>) -> Void) {
        let dataResponse = AFDataResponse<EdamamResponse>(
            request: nil,
            response: responseMock.response,
            data: nil,
            metrics: nil,
            serializationDuration: 0.0,
            result: responseMock.result
        )
        completionHandler(dataResponse)
    }
}
