//
//  PersonApiClient.swift
//  Movies
//
//  Created by mustafa içmen on 28.02.2021.
//

import Foundation
import RxSwift

class PersonApiClient: BaseApiClient {
    
    // uses "request" method inside BaseApiClient to fetch person details data from API
    func getPersonDetails(personId: Int) -> Single<PersonModel> {
        return request(ApiRouter.getPersonDetail(personId: personId))
    }
}
