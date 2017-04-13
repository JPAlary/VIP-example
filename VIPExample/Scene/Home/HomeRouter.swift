//
//  HomeRouter.swift
//  VIPExample
//
//  Created by Jean-Pierre Alary on 13/04/2017.
//  Copyright © 2017 Jp. All rights reserved.
//

import UIKit
import RxSwift

final class HomeRouter: Router {
    private let container: AppContainer

    // MARK: Initializer

    init(container: AppContainer) {
        self.container = container
    }

    // MARK: Router

    var callback: Observable<Void> {
        return Observable.never()
    }

    func route(from root: UIViewController?, request: EventRequest) -> Observable<EventResponse> {
        let destination = container.resolve(serviceType: EditUserViewController.self)!
        let router = container.resolve(serviceType: AnyRouter<User>.self)!

        root?.present(destination, animated: true, completion: nil)

        return router
            .callback
            .map { AppEventResponse(code: .ok, data: [EventParameterKey.value: $0]) }
    }
}
