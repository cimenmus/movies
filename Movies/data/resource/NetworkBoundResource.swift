//
//  NetworkBoundResource.swift
//  Movies
//
//  Created by mustafa içmen on 3.03.2021.
//

import Foundation
import RxSwift

class NetworkBoundResource<ResultType> {
            
    private var loadFromNetwork: () -> Single<ResultType>
    private var loadFromDb: () -> Single<ResultType>
    private var saveToDb: (ResultType) -> Void
    
    init(loadFromNetwork: @escaping () -> Single<ResultType>,
         loadFromDb: @escaping () -> Single<ResultType>,
         saveToDb: @escaping (ResultType) -> Void) {
        self.loadFromNetwork = loadFromNetwork
        self.loadFromDb = loadFromDb
        self.saveToDb = saveToDb
    }
    
    func execute<ResultType>() -> Single<ResultType> {
        return Single.create { single in
            var error: AppError?
            var dbDisposable: Disposable?
            var networkDisposable: Disposable?
            networkDisposable =
                self.loadFromNetwork()
                .observe(on: MainScheduler.instance)
                .subscribe(
                    
                    onSuccess: { networkData in
                        self.saveToDb(networkData)
                        single(.success(networkData as! ResultType))
                        networkDisposable?.dispose()
                    },
                    
                    onFailure: { networkError in
                        error = networkError.toAppError()
                        dbDisposable =
                            self.loadFromDb()
                            .observe(on: MainScheduler.instance)
                            .subscribe(
                                onSuccess: { dbData in
                                    single(.success(dbData as! ResultType))
                                    networkDisposable?.dispose()
                                    dbDisposable?.dispose()
                                },
                                onFailure: { dbError in
                                    if error == nil {
                                        error = dbError.toAppError()
                                    }
                                    single(.failure(error!))
                                    networkDisposable?.dispose()
                                    dbDisposable?.dispose()
                                }
                            )
                    }
                )
            return Disposables.create()
        }
   }
    
}
