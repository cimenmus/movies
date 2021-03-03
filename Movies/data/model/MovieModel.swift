//
//  MovieModel.swift
//  Movies
//
//  Created by mustafa içmen on 28.02.2021.
//

import Foundation

struct MovieModel: Codable {
    
    var id : Int?
    var adult : Bool?
    var posterImagePath : String?
    var backdropImagePath : String?
    var title : String?
    var overview : String?
    var average : Double?
    var voteCount : Int?
    var releaseDate : String?
    var popularity : Double?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case adult = "adult"
        case posterImagePath = "poster_path"
        case backdropImagePath = "backdrop_path"
        case title = "title"
        case overview = "overview"
        case average = "vote_average"
        case voteCount = "vote_count"
        case releaseDate = "release_date"
        case popularity = "popularity"
    }
}
