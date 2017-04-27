//
//  ShowUserRouter.swift
//  VIPExample
//
//  Created by Jean-Pierre Alary on 13/04/2017.
//  Copyright © 2017 Jp. All rights reserved.
//

import UIKit
import RxSwift

final class ShowUserRouter: Router {
    private let container: AppContainer

    // MARK: Initializer

    init(container: AppContainer) {
        self.container = container
    }

    // MARK: Router

    var callback: Observable<User> {
        return container.resolve(serviceType: AnyRouter<User>.self)!.callback
    }

    func perform(route: Route) {
        let destination = container.resolve(serviceType: UIViewController.self)!
        route.from?.present(destination, animated: true, completion: nil)
    }
}
