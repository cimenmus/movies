//
//  MovieCastApiResponse.swift
//  Movies
//
//  Created by mustafa içmen on 28.02.2021.
//

import Foundation

struct MovieCastApiResponse: Codable {
    
    let id: Int?
    let cast: [MovieCastModel]?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case cast = "cast"
    }
}
