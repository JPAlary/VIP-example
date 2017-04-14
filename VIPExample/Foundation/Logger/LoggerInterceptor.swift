//
//  LoggerInterceptor.swift
//  VIPExample
//
//  Created by Jean-Pierre Alary on 14/04/2017.
//  Copyright © 2017 Jp. All rights reserved.
//

import RxSwift

struct LoggerInterceptor: Interceptor {
    private let logger: Logger

    // MARK: Initializer

    init(logger: Logger) {
        self.logger = logger
    }

    // MARK: Interceptor

    func intercept(chain: InterceptorChain<URLRequest>) -> Observable<URLRequest> {
        if let input = chain.input {
            logger.log(level: .info, message: "Sending request: \n" + String(describing: input) + "\n")
        }

        return chain.proceed()
    }
}
