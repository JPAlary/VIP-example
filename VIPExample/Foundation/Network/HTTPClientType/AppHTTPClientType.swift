//
//  AppHTTPClientType.swift
//  MVVMExample
//
//  Created by Jean-Pierre Alary on 08/04/2017.
//  Copyright © 2017 Jp. All rights reserved.
//

import Foundation
import RxSwift

final class AppHTTPClientType: HTTPClientType {
    private let transformer: AnyTransformer<Endpoint, URLRequest>
    private let networkAdapter: NetworkAdapter
    private let requestChain: InterceptorChain<URLRequest>
    private let responseChain: InterceptorChain<Response>
    private let httpErrorHandler: HTTPErrorHandler

    // MARK: Initializer

    init(
        transformer: AnyTransformer<Endpoint, URLRequest>,
        networkAdapter: NetworkAdapter,
        requestChain: InterceptorChain<URLRequest>,
        responseChain: InterceptorChain<Response>,
        httpErrorHandler: HTTPErrorHandler
    ) {
        self.transformer = transformer
        self.networkAdapter = networkAdapter
        self.requestChain = requestChain
        self.responseChain = responseChain
        self.httpErrorHandler = httpErrorHandler
    }

    // MARK: HTTPClientType

    func request<T: Deserializable>(endpoint: Endpoint) -> Observable<Result<T>> {
        let requestChain = self.requestChain
        let networkAdapter = self.networkAdapter
        let responseChain = self.responseChain
        let httpErrorHandler = self.httpErrorHandler

        return transformer
            .rx_transform(object: endpoint)
            .flatMap { requestChain.proceed(object: $0) }
            .flatMap { networkAdapter.rx_send(request: $0) }
            .flatMap { responseChain.proceed(object: $0) }
            .flatMap { (response) -> Observable<Result<T>> in
                if false == response.succeed {
                    return Observable.error(httpErrorHandler.handle(response: response))
                }

                guard let data = response.data else {
                    return Observable.just(Result.noContent)
                }

                do {
                    let object = try T.init(data: data)

                    return Observable.just(Result.value(object))
                } catch {
                    return Observable.error(error)
                }
        }
    }

    func request(endpoint: Endpoint) -> Observable<Response> {
        let requestChain = self.requestChain
        let networkAdapter = self.networkAdapter
        let responseChain = self.responseChain

        return transformer
            .rx_transform(object: endpoint)
            .flatMap { requestChain.proceed(object: $0) }
            .flatMap { networkAdapter.rx_send(request: $0) }
            .flatMap { responseChain.proceed(object: $0) }
    }
}

