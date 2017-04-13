//
//  AnyRouter.swift
//  VIPExample
//
//  Created by Jean-Pierre Alary on 13/04/2017.
//  Copyright © 2017 Jp. All rights reserved.
//

import RxSwift

final class AnyRouter<T>: Router {
    private let _callback: () -> Observable<T>
    private let _route: (UIViewController?, EventRequest) -> Observable<EventResponse>

    // MARK: Initializer

    init<R: Router>(base: R) where R.T == T {
        _callback = {
            return base.callback
        }
        _route = base.route
    }

    // MARK: Router

    var callback: Observable<T> {
        return _callback()
    }

    func route(from root: UIViewController?, request: EventRequest) -> Observable<EventResponse> {
        return _route(root, request)
    }
}
