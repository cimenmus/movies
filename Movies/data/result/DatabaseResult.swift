//
//  DatabaseResult.swift
//  Movies
//
//  Created by mustafa içmen on 6.03.2021.
//

import Foundation
import RxSwift

class DatabaseResult<ResultType> {
            
    private var dbRequest: (() -> ResultType?)
    
    init(dbRequest: @escaping (() -> ResultType?)) {
        self.dbRequest = dbRequest
    }
            
    func execute<ResultType>() -> Single<ResultType> {
        return Single<ResultType>.create { single in
            let data = self.dbRequest()
            if data == nil || (data is Array<AnyObject> && (data as! Array<AnyObject>).isEmpty) {
                let error = AppError(type: AppError.ErrorType.DB_ITEM_NOT_FOUND, message: "Database item not found.")
                single(.failure(error))
            } else {
                single(.success(data as! ResultType))
            }
            return Disposables.create()
        }
   }
    
}
