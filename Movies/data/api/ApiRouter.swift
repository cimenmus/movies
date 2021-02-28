//
//  ApiRouter.swift
//  Movies
//
//  Created by mustafa içmen on 28.02.2021.
//

import Foundation
import Alamofire

enum ApiRouter: URLRequestConvertible {
    
    //The endpoint name we'll call later
    case getPopularMovies(page: Int)
    case getCastOfAMovie(movieId: Int)
    case getPersonDetail(personId: Int)
    
    //MARK: - URLRequestConvertible
    // creates and executest URL request
    func asURLRequest() throws -> URLRequest {
        let url = try Constants.baseUrl.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        
        //Http method
        urlRequest.httpMethod = method.rawValue
        // Otherwise, it returns latest success response when network is not available
        urlRequest.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
        
        //Encoding
        let encoding: ParameterEncoding = {
            switch method {
            case .get:
                return URLEncoding.default
            default:
                return JSONEncoding.default
            }
        }()
        
        return try encoding.encode(urlRequest, with: parameters)
    }
    
    //MARK: - HttpMethod
    //This returns the HttpMethod type. It's used to determine the type if several endpoints are peresent
    private var method: HTTPMethod {
        switch self {
        case .getPopularMovies,
             .getCastOfAMovie,
             .getPersonDetail:
            return .get
        }
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
    private var parameters: Parameters? {
        switch self {
        
        case .getPopularMovies(page: let page):
            return [Constants.Parameters.ApiKey.KEY: Constants.Parameters.ApiKey.VALUE,
                    Constants.Parameters.Page.KEY: page]
            
        case .getCastOfAMovie:
            return [Constants.Parameters.ApiKey.KEY: Constants.Parameters.ApiKey.VALUE]
            
        case .getPersonDetail:
            return [Constants.Parameters.ApiKey.KEY: Constants.Parameters.ApiKey.VALUE]
        }
    }
}
