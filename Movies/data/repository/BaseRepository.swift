//
//  BaseRepository.swift
//  Movies
//
//  Created by mustafa içmen on 28.02.2021.
//

import Foundation
import RxSwift
import RxCocoa

class BaseRepository {
    
    /**
     that method will be use to fetch data
     takes 3 closure parameters to fetch data from network, insert data to database and fetch data from database
     first tries to fetch data from network
     if fetching network succeed, the fetched data will be inserted into database, then data is returned
     if network is not available, the data will be fetched from database and then returned
     */
    func resource<ResultType>(loadFromNetwork: @escaping () -> Single<ResultType>,
                              loadFromDb: @escaping () -> Single<ResultType>,
                              saveToDb: @escaping (ResultType) -> Void
    ) -> Single<ResultType> {
        
        return Single.create { single in
            var error: AppError?
            var dbDisposable: Disposable?
            var networkDisposable: Disposable?
            networkDisposable =
                loadFromNetwork()
                .observeOn(MainScheduler.instance)
                .subscribe(
                    
                    onSuccess: { networkData in
                        saveToDb(networkData)
                        single(.success(networkData))
                        networkDisposable?.dispose()
                    },

                    onError: { networkError in
                        error = networkError.toAppError()
                        dbDisposable =
                            loadFromDb()
                            .observeOn(MainScheduler.instance)
                            .subscribe(
                                onSuccess: { dbData in
                                    single(.success(dbData))
                                    networkDisposable?.dispose()
                                    dbDisposable?.dispose()
                                },
                                onError: { dbError in
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
