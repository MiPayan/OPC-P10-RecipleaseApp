//
//  NetworkManager.swift
//  Reciplease
//
//  Created by Mickael PAYAN on 15/06/2022.
//

import Foundation
import Alamofire

final class NetworkSession: NetworkProtocol {
    func request(urlString: String, completionHandler: @escaping (AFDataResponse<EdamamResponse>) -> Void) {
        guard let urlString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: urlString) else { return }
        AF.request(url).responseDecodable(of: EdamamResponse.self) { dataResponse in
            completionHandler(dataResponse)
        }
    }
}
