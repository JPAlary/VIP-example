//
//  AnyInterceptor.swift
//  MVVMExample
//
//  Created by Jean-Pierre Alary on 08/04/2017.
//  Copyright © 2017 Jp. All rights reserved.
//

import RxSwift

struct AnyInterceptor<Input>: Interceptor {
    private let _intercept: (InterceptorChain<Input>) -> Observable<Input>

    // MARK: Initializer

    init<I: Interceptor>(base: I) where I.Input == Input {
        _intercept = base.intercept
    }

    // MARK: Interceptor

    func intercept(chain: InterceptorChain<Input>) -> Observable<Input> {
        return _intercept(chain)
    }
}
