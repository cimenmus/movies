//
//  PublisherExt.swift
//  Movies
//
//  Created by mustafa içmen on 7.03.2021.
//

import Foundation
import Combine

extension Publisher {

//    The flatMapLatest operator behaves much like the standard FlatMap operator, except that whenever
//    a new item is emitted by the source Publisher, it will unsubscribe to and stop mirroring the Publisher
//    that was generated from the previously-emitted item, and begin only mirroring the current one.
    func flatMapLatest<T: Publisher>(_ transform: @escaping (Self.Output) -> T) -> Publishers.SwitchToLatest<T, Publishers.Map<Self, T>> where T.Failure == Self.Failure {
        map(transform).switchToLatest()
    }
}

extension Publisher {

    static func empty() -> AnyPublisher<Output, Failure> {
        return Empty().eraseToAnyPublisher()
    }

    static func just(_ output: Output) -> AnyPublisher<Output, Failure> {
        return Just(output)
            .catch { _ in AnyPublisher<Output, Failure>.empty() }
            .eraseToAnyPublisher()
    }

    static func fail(_ error: Failure) -> AnyPublisher<Output, Failure> {
        return Fail(error: error).eraseToAnyPublisher()
    }
}

extension AnyPublisher {
    
    func observe(view: BaseView,
                 onLoading: (() -> Void)? = nil,
                 onSuccess: ((Output) -> Void)? = nil,
                 onError: ((AppError?) -> Void)? = nil) -> AnyCancellable {
        
        return handleEvents(
            receiveSubscription: { _ in
                DispatchQueue.main.async {
                    view.startLoader()
                    if let loading = onLoading { loading() }
                }
            },
            receiveRequest: { demand in
                DispatchQueue.main.async {
                    view.startLoader()
                    if let loading = onLoading { loading() }
                }
            }
        ).sink(
            receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    DispatchQueue.main.async {
                        view.stopLoader()
                        let appError = error as! AppError
                        view.onError(appError: appError)
                        if let error = onError { error(appError) }
                    }
                case .finished:
                    DispatchQueue.main.async {
                        view.stopLoader()
                    }
                }
              },
            receiveValue: { value in
                DispatchQueue.main.async {
                    view.stopLoader()
                    if let success = onSuccess { success(value) }
                }
              })
        
    }
}



