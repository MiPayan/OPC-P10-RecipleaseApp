//
//  EdamamResponse.swift
//  Reciplease
//
//  Created by Mickael PAYAN on 08/08/2021.
//

import Foundation

struct EdamamResponse: Decodable {
    let hits: [HitResponse]
}
