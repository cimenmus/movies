//
//  ApiError.swift
//  Movies
//
//  Created by mustafa içmen on 28.02.2021.
//

import Foundation

struct ApiError: Codable {
    
    var message: String
    var statusCode: Int
    var success: Bool?
    
    enum CodingKeys: String, CodingKey {
        case message = "status_message"
        case statusCode = "status_code"
        case success = "success"
    }
    
}
