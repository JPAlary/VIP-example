//
//  AnyInterceptor.swift
//  MVVMExample
//
//  Created by Jean-Pierre Alary on 08/04/2017.
//  Copyright © 2017 Jp. All rights reserved.
//

import RxSwift

struct AnyInterceptor<T>: Interceptor {
    private let _intercept: (InterceptorChain<T>) -> Observable<T>

    // MARK: Initializer

    init<I: Interceptor>(base: I) where I.T == T {
        _intercept = base.intercept
    }

    // MARK: Interceptor

    func intercept(chain: InterceptorChain<T>) -> Observable<T> {
        return _intercept(chain)
    }
}
