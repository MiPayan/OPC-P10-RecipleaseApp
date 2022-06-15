//
//  Networking.swift
//  Reciplease
//
//  Created by Mickael PAYAN on 05/08/2021.
//

import UIKit

final class Networking {

    enum APIError: Error {
        case error(String)
    }

    func getJSON<T: Decodable>(urlString: String,
                               dataDecodingStrategy: JSONDecoder.DataDecodingStrategy = .deferredToData,
                               keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys,
                               completion handler: @escaping ((Result<T, APIError>) -> Void)) {
        guard let string = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: string) else {
            handler(.failure(.error(NSLocalizedString("Error: Invalid URL", comment: ""))))
            return
        }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                handler(.failure(.error(NSLocalizedString(error.localizedDescription, comment: ""))))
            }
            guard let data = data else {
                handler(.failure(.error(NSLocalizedString("Error: Data is corrupted", comment: ""))))
                return
            }
            let decoder = JSONDecoder()
            decoder.dataDecodingStrategy = dataDecodingStrategy
            decoder.keyDecodingStrategy = keyDecodingStrategy
            do {
                let decodedData = try decoder.decode(T.self, from: data)
                handler(.success(decodedData))
                return
            } catch let decodingError {
                handler(.failure(APIError.error("Error: \(decodingError.localizedDescription)")))
                return
            }
        }.resume()
    }
}
