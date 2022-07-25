//
//  NetworkProtocol.swift
//  Reciplease
//
//  Created by Mickael PAYAN on 28/06/2022.
//

import Foundation
import Alamofire

protocol NetworkProtocol {
    func request(url: URL, completionHandler: @escaping(AFDataResponse<EdamamResponse>) -> Void)
}
