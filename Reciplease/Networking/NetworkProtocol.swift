//
//  NetworkProtocol.swift
//  Reciplease
//
//  Created by Mickael PAYAN on 28/06/2022.
//

import Foundation
import Alamofire

protocol NetworkProtocol {
    func request(urlString: String, completionHandler: @escaping(AFDataResponse<EdamamResponse>) -> Void)
}
