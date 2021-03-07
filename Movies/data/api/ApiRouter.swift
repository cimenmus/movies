//
//  ApiRouter.swift
//  Movies
//
//  Created by mustafa içmen on 28.02.2021.
//

import Foundation

enum ApiRouter {
    
    //The endpoint name we'll call later
    case getPopularMovies(page: Int)
    case getCastOfAMovie(movieId: Int)
    case getPersonDetail(personId: Int)
    
    //MARK: - URLRequest
    func asUrlRequest() -> URLRequest? {
        let baseURL = URL(string: Constants.baseUrl)!
        let requestURL = baseURL.appendingPathComponent(path)
        guard var components = URLComponents(url: requestURL, resolvingAgainstBaseURL: false) else {
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
    
    //MARK: - Path
    //The path is the part following the base url
    private var path: String {
        switch self {
            case .getPopularMovies:
                return "movie/popular"
            case .getCastOfAMovie(movieId: let movieId):
                return "movie/\(movieId)/credits"
            case .getPersonDetail(personId: let personId):
                return "person/\(personId)"
        }
    }
    
    //MARK: - Parameters
    //This is the queries part, it's optional because an endpoint can be without parameters
    private var parameters: [String: AnyObject] {
        var params = [String: AnyObject]()
        params[Constants.Parameters.ApiKey.KEY] = Constants.Parameters.ApiKey.VALUE as AnyObject
        switch self {
            case .getPopularMovies(page: let page):
                params[Constants.Parameters.Page.KEY] = page as AnyObject
            default:
                print("")
        }
        return params
    }
}
