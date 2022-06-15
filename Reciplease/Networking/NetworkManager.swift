//
//  NetworkManager.swift
//  Reciplease
//
//  Created by Mickael PAYAN on 15/06/2022.
//

import Foundation
import Alamofire

protocol NetworkProtocol {
    func request(url: URL, completionHandler: @escaping(AFDataResponse<EdamamResponse>) -> Void)
}

final class NetworkSession: NetworkProtocol {
    func request(url: URL, completionHandler: @escaping (AFDataResponse<EdamamResponse>) -> Void) {
        AF.request(url).responseDecodable(of: EdamamResponse.self) { dataResponse in
            completionHandler(dataResponse)
        }
    }
}
