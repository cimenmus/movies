//
//  MovieCastModel.swift
//  Movies
//
//  Created by mustafa içmen on 28.02.2021.
//

import Foundation

struct MovieCastModel: Codable {
    
    let id : Int?
    let name : String?
    let character : String?
    let order : Int?
    let movieId : Int?
    let imagePath : String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case character = "character"
        case order = "order"
        case movieId = "movieId"
        case imagePath = "profile_path"
    }
}
