//
//  NetworkResource.swift
//  Movies
//
//  Created by mustafa içmen on 2.03.2021.
//

import Foundation
import RxSwift
import Alamofire

class NetworkResource<ApiResponseType: Codable, ResultType> {
            
    private var networkRequest: URLRequestConvertible!
    private var responseParser: ((ApiResponseType) -> ResultType)?
    
    init(networkRequest: URLRequestConvertible,
         responseParser: ((ApiResponseType) -> ResultType)? = nil) {
        self.networkRequest = networkRequest
        self.responseParser = responseParser
    }
        
    func execute<ResultType>() -> Single<ResultType> {
       return Single<ResultType>.create { single in
        let request = AF.request(self.networkRequest).responseDecodable { [self] (response: DataResponse<ApiResponseType, AFError>) in
               switch response.result {
                    case .success(let value):
                        if let parser = responseParser {
                            let result = parser(value as ApiResponseType) as! ResultType
                            single(.success(result))
                        } else {
                            single(.success(value as! ResultType))
                        }
                    case .failure(_):
                        let appError = self.getAppError(apiResponse: response)
                        single(.failure(appError))
               }
           }.validate()
           return Disposables.create { request.cancel() }
       }
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
