//
//  DataObserver.swift
//  Movies
//
//  Created by mustafa içmen on 28.02.2021.
//

import Foundation
import RxSwift

typealias OptionalCompletionHandler = (() -> Void)?
typealias OptionalCompletionHandlerWithErrorParameter = ((AppError?) -> Void)?

/**
 - observes the observable inside viewmodel
 - show loading indicator when an operation is started
 - hides loading indicator when an operation is finished
 - shows alert when an operation is failed
 - takes completion handler parameters from view controller to make ui operations
 - used by view conrollers
 */
class DataObserver<T>: NSObject {
    
    typealias OptionalCompletionHandlerWithData = ((T) -> Void)?
    
    var view: BaseView?
    var publishSubject: PublishSubject<Result<T>>?
    var subscription: Disposable?

    private init(view: BaseView,
                 publishSubject: PublishSubject<Result<T>>) {
        self.view = view
        self.publishSubject = publishSubject
    }
    
    deinit {
        subscription?.dispose()
        subscription = nil
        publishSubject = nil
        view = nil
    }
    
    static func create(view: BaseView,
                       publishSubject: PublishSubject<Result<T>>,
                       onLoading: OptionalCompletionHandler = nil,
                       onSuccess: OptionalCompletionHandlerWithData = nil,
                       onError: OptionalCompletionHandlerWithErrorParameter = nil,
                       onNone: OptionalCompletionHandler = nil){
        let dataObserver = DataObserver(view: view, publishSubject: publishSubject)
        dataObserver.observe(onLoading: onLoading,
                             onSuccess: onSuccess,
                             onError: onError,
                             onNone: onNone)
    }
    
    private func observe(onLoading: OptionalCompletionHandler = nil,
                         onSuccess: OptionalCompletionHandlerWithData = nil,
                         onError: OptionalCompletionHandlerWithErrorParameter = nil,
                         onNone: OptionalCompletionHandler = nil) {
        
        if let subject = self.publishSubject {
            subscription =  subject.subscribe { event in
                switch event.element?.state {
            
                    case .LOADING:
                        self.view?.startLoader()
                        if let loading = onLoading { loading() }
                
                    case .SUCCESS:
                        self.view?.stopLoader()
                        if let success = onSuccess { success(event.element!.data!) }
                
                    case .ERROR:
                        self.view?.stopLoader()
                        if let appError = event.element?.error {
                            self.view?.onError(appError: appError)
                        }
                        if let error = onError { error(event.element!.error) }
                    
                    default:
                        self.view?.stopLoader()
                }
            }
        }

    }

}
