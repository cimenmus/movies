//
//  PersonApiClient.swift
//  Movies
//
//  Created by mustafa içmen on 28.02.2021.
//

import Foundation
import RxSwift

class PersonApiClient {
    
    func getPersonDetails(personId: Int) -> Single<PersonModel> {
        return NetworkResource<PersonModel, PersonModel>(
            networkRequest: ApiRouter.getPersonDetail(personId: personId)
        ).execute()
    }
}
