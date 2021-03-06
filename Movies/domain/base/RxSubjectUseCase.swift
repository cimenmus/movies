//
//  RxSubjectUseCase.swift
//  Movies
//
//  Created by mustafa içmen on 6.03.2021.
//

import Foundation
import RxSwift

protocol RxSubjectUseCase {
   
    associatedtype P
    associatedtype R
    
    func execute(parameters: P) -> Single<R>
}

extension RxSubjectUseCase {
    
    func invoke(parameters: P,
                showLoading: Bool = true,
                subject: PublishSubject<Result<R>>,
                disposeBag: DisposeBag,
                onSuccess: ((R) -> Void)? = nil,
                onError: ((AppError?) -> Void)? = nil){
        
        if showLoading {
            subject.onNext(Result.loading())
        }
        
        execute(parameters: parameters)
            .observe(on: MainScheduler.instance)
            .subscribe(
                onSuccess: { data in
                    subject.onNext(Result.success(data: data))
                    if let success = onSuccess { success(data) }
                },
                onFailure: { error in
                    let appError = error.toAppError()
                    subject.onNext(Result.error(error: appError))
                    if let error = onError { error(appError) }
                }
            )
            .disposed(by: disposeBag)
    }
    
    
}
