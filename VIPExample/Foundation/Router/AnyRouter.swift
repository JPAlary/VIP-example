//
//  AnyRouter.swift
//  VIPExample
//
//  Created by Jp Alary on 28/04/2017.
//  Copyright © 2017 Jp. All rights reserved.
//

import UIKit
import RxSwift

final class AnyRouter<Value>: Router {
    private let _callback: () -> Observable<Value>
    private let _perform: (Route) -> Void

    // MARK: Initializer

    init<R: Router>(base: R) where R.Value == Value {
        _perform = base.perform
        _callback = {
            return base.callback
        }
    }

    // MARK: Router

    var callback: Observable<Value> {
        return _callback()
    }

    func perform(route: Route) {
        _perform(route)
    }
}
