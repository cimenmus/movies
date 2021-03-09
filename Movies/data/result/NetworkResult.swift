//
//  NetworkResult.swift
//  Movies
//
//  Created by mustafa içmen on 6.03.2021.
//

import Foundation
import RxSwift
import Combine
import Alamofire

class NetworkResult<ApiResponseType: Codable, ResultType> {
            
    private var responseParser: ((ApiResponseType) -> ResultType)?
    
    init(responseParser: ((ApiResponseType) -> ResultType)? = nil) {
        self.responseParser = responseParser
    }
    
    @discardableResult
    func execute<ResultType>(urlRequest: URLRequest?) -> AnyPublisher<ResultType, AppError> {
        
        guard let request = urlRequest else {
            let appError = AppError(type: AppError.ErrorType.BAD_REQUEST, message: "Can not build network request")
            return .fail(appError)
        }
        
        let config = URLSessionConfiguration.default
        config.requestCachePolicy = .reloadIgnoringLocalCacheData
        config.urlCache = nil
        let session = URLSession.init(configuration: config)
        
        return session.dataTaskPublisher(for: request)
            .mapError {_ in AppError(type: AppError.ErrorType.BAD_REQUEST, message: "Invalid network request") }
            .print()
            .flatMap { data, response -> AnyPublisher<Data, Error> in
                guard let response = response as? HTTPURLResponse else {
                    let appError = AppError(type: AppError.ErrorType.BAD_REQUEST, message: "Invalid network response")
                    return .fail(appError)
                }

                guard 200..<300 ~= response.statusCode else {
                    //return .fail(NetworkError.dataLoadingError(statusCode: response.statusCode, data: data))
                    let appError = AppError(type: AppError.ErrorType.BAD_REQUEST, message: "Invalid network data")
                    return .fail(appError)
                }
                
                return .just(data)
                
            }
            .decode(type: ApiResponseType.self, decoder: JSONDecoder())
            .catch ({ error -> AnyPublisher<ApiResponseType, AppError> in
                let appError = AppError(type: AppError.ErrorType.BAD_REQUEST, message: "JSON Decoding error")
                return .fail(appError)
            })
            .map {
                //.success($0)
                if let parser = self.responseParser {
                    let result = parser($0 as ApiResponseType) as! ResultType
                    return result
                } else {
                    return $0 as! ResultType
                }
                
            }
            .eraseToAnyPublisher()
        
       
   }
    
    // converts api error to AppError model
    private func getAppError<ApiResponseType: Codable>(apiResponse: DataResponse<ApiResponseType, AFError>) -> AppError {
        let responseCode = apiResponse.response?.statusCode ?? AppError.ErrorType.UNKNOWN.rawValue
        let errorType = AppError.ErrorType(rawValue: responseCode) ?? AppError.ErrorType.UNKNOWN
        let errorMessage = getErrorMessage(apiResponse: apiResponse)
        return AppError(type: errorType, message: errorMessage)
    }
    
    // reads error message from API response when API request failed
    private func getErrorMessage<ApiResponseType: Codable>(apiResponse: DataResponse<ApiResponseType, AFError>) -> String {
        let apiError = getApiError(apiResponse: apiResponse)
        let errorLocalizedMessage = apiResponse.error?.localizedDescription ?? ""
        if apiError != nil && !apiError!.message.isEmpty {
            return apiError!.message
        }
        else if !errorLocalizedMessage.isEmpty {
            return errorLocalizedMessage
        }
        switch apiResponse.response?.statusCode {
            case 400:
                 return "400 - Bad Request"
            case 401:
                 return "401 - Unauthorized"
            case 403:
                 return "403 - Forbidden"
            case 404:
                return "404 - Not Found"
            case 500:
                return "500 - Internal Server Error"
            default:
                return "An error has occured"
        }
        
    }
    
    // reads error data from API response and creates ApiError model
    private func getApiError<ApiResponseType: Codable>(apiResponse: DataResponse<ApiResponseType, AFError>) -> ApiError? {
        if let data = apiResponse.data {
            do {
                let decoder = JSONDecoder()
                let apiError = try decoder.decode(ApiError.self, from: data)
                return apiError
            } catch {
                return nil
            }
        } else {
            return nil
        }
    }

}
