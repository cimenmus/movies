//
//  Constants.swift
//  Movies
//
//  Created by mustafa içmen on 28.02.2021.
//

import Foundation

struct Constants {
    
    //The API's base URL
    static let baseUrl = "https://api.themoviedb.org/3"
    static let TMDB_IMAGEURL_PREFIX = "https://image.tmdb.org/t/p/w500/" // image url prefix for tmdb images
    
    // Api parameters like api version and query parameters and their values
    struct Parameters {
        
        struct ApiKey {
            static let KEY = "api_key"
            static let VALUE = "21c871b9be27c7f1afbe105ca1dc3f76"
        }
                
        struct Page {
            static let KEY = "page"
        }
    }
    
    struct Database {
        struct Movie {
            static let PAGE_LIMIT = 20
        }
    }
}
