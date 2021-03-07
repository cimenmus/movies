//
//  NetworkRequest.swift
//  Movies
//
//  Created by mustafa içmen on 7.03.2021.
//

import Foundation

struct NetworkRequest<ApiResponseType: Decodable> {
    let url: URL
    let parameters: [String: AnyObject]
    var request: URLRequest? {
        guard var components = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            return nil
        }
        components.queryItems = parameters.keys.map { key in
            URLQueryItem(name: key, value: parameters[key]?.description)
        }
        guard let url = components.url else {
            return nil
        }
        return URLRequest(url: url)
    }

    init(url: URL, parameters: [String: AnyObject] = [:]) {
        self.url = url
        self.parameters = parameters
    }
}
