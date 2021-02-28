//
//  PopularMoviesApiResponse.swift
//  Movies
//
//  Created by mustafa içmen on 28.02.2021.
//

import Foundation

struct PopularMoviesApiResponse: Codable {
    
    let page: Int?
    let results: [MovieModel]?
    let totalResults : Int?
    let totalPages : Int?

    enum CodingKeys: String, CodingKey {
        case page = "page"
        case results = "results"
        case totalResults = "total_results"
        case totalPages = "total_pages"
    }
}
