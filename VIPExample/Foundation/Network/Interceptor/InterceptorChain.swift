//
//  InterceptorChain.swift
//  MVVMExample
//
//  Created by Jean-Pierre Alary on 08/04/2017.
//  Copyright © 2017 Jp. All rights reserved.
//

import RxSwift

final class InterceptorChain<T> {
    private var interceptors: [AnyInterceptor<T>]

    // MARK: Initializer

    convenience init() {
        self.init(interceptors: [AnyInterceptor<T>](), input: nil)
    }

    init(interceptors: [AnyInterceptor<T>], input: T?) {
        self.interceptors = interceptors
        self.input = input
    }

    // MARK: Public

    var input: T?

    func add(interceptor: AnyInterceptor<T>) -> InterceptorChain {
        interceptors.append(interceptor)

        return self
    }

    func proceed(object: T? = nil) -> Observable<T> {
        if let object = object {
            return proceedNext(with: object)
        } else if let input = self.input {
            return proceedNext(with: input)
        } else {
            fatalError("You must set an input object to the chain (setter or in parameter of `proceed` method)")
        }
    }

    // MARK: Private

    private func proceedNext(with input: T) -> Observable<T> {
        guard let interceptor = self.interceptors.first else {
            return Observable.just(input)
        }

        var interceptors = self.interceptors
        interceptors.removeFirst()

        return interceptor.intercept(chain: InterceptorChain(interceptors: interceptors, input: input))
    }
}
