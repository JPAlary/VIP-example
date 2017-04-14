//
//  Interceptor.swift
//  MVVMExample
//
//  Created by Jean-Pierre Alary on 08/04/2017.
//  Copyright © 2017 Jp. All rights reserved.
//

import RxSwift

protocol Interceptor {
    associatedtype Input

    func intercept(chain: InterceptorChain<Input>) -> Observable<Input>
}
