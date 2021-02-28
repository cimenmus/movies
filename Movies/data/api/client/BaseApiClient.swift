//
//  BaseApiClient.swift
//  Movies
//
//  Created by mustafa içmen on 28.02.2021.
//

import Foundation
import Alamofire
import RxSwift

class BaseApiClient {
    
    // The request function to get results in an Observable
     func request<T: Codable> (_ urlConvertible: URLRequestConvertible) -> Single<T> {
        return Single<T>.create { single in
            let request = AF.request(urlConvertible).responseDecodable { (response: DataResponse<T, AFError>) in
                switch response.result {
                case .success(let value):
                    single(.success(value))
                case .failure(_):
                    let appError = self.getAppError(apiResponse: response)
                    single(.failure(appError))
                }
            }.validate()
            return Disposables.create {
                request.cancel()
            }
        }
    }
    
    // converts api error to AppError model
    private func getAppError<T: Codable>(apiResponse: DataResponse<T, AFError>) -> AppError {
        let responseCode = apiResponse.response?.statusCode ?? ErrorType.UNKNOWN.rawValue
        let errorType = ErrorType(rawValue: responseCode) ?? ErrorType.UNKNOWN
        let errorMessage = getErrorMessage(apiResponse: apiResponse)
        return AppError(type: errorType, message: errorMessage)
    }
    
    // reads error message from API response when API request failed
    private func getErrorMessage<T: Codable>(apiResponse: DataResponse<T, AFError>) -> String {
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
    private func getApiError<T: Codable>(apiResponse: DataResponse<T, AFError>) -> ApiError? {
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
