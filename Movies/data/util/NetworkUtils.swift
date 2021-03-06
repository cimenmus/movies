//
//  NetworkUtils.swift
//  Movies
//
//  Created by mustafa içmen on 28.02.2021.
//

import Foundation
import Alamofire

class NetworkUtils {
    
    func isNetworkAvailable() -> Bool {
        let manager = NetworkReachabilityManager()
        return manager?.isReachable ?? false
    }
}
