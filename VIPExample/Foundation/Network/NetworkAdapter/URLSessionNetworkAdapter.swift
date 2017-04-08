//
//  URLSessionNetworkAdapter.swift
//  MVVMExample
//
//  Created by Jean-Pierre Alary on 08/04/2017.
//  Copyright © 2017 Jp. All rights reserved.
//


import Foundation
import RxSwift
import RxCocoa

final class URLSessionNetworkAdapter: NetworkAdapter {
    private let networkActivity: NetworkActivity
    private let session: URLSession

    // MARK: Initializer

    init(networkActivity: NetworkActivity, session: URLSession) {
        self.networkActivity = networkActivity
        self.session = session
    }

    // MARK: NetworkAdapter

    func rx_send(request: URLRequest) -> Observable<Response> {
        networkActivity.show()
        
        return Observable.create { [weak self] observer in
            var didHideNetworkActivity = false
            let task = self?.session.dataTask(with: request) { (data, response, error) in
                didHideNetworkActivity = true
                self?.networkActivity.hide()

                guard let response = response, let data = data else {
                    observer.onError(NetworkAppError(error: error))

                    return
                }

                observer.onNext(AppResponse(request: request, data: data, httpResponse: response, error: error))
                observer.on(.completed)
            }

            let t = task
            t?.resume()

            return Disposables.create {
                if false == didHideNetworkActivity {
                    self?.networkActivity.hide()
                }

                t?.cancel()
            }
        }
    }
}
