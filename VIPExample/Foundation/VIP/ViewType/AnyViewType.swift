//
//  AnyViewType.swift
//  VIPExample
//
//  Created by Jean-Pierre Alary on 08/04/2017.
//  Copyright © 2017 Jp. All rights reserved.
//

import RxSwift
import RxCocoa

final class AnyViewType<ViewModel>: ViewType {
    private let _view: () -> UIView
    private let _request: () -> Observable<EventRequest>
    private let _update: (Driver<ViewModel>) -> Void

    // MARK: Initializer

    init<V: ViewType>(base: V) where V.ViewModel == ViewModel {
        _view = {
            return base.view
        }
        _request = base.request
        _update = base.update
    }

    // MARK: ViewType

    var view: UIView {
        return _view()
    }

    func request() -> Observable<EventRequest> {
        return _request()
    }

    func update(with stateProvider: Driver<ViewModel>) {
        return _update(stateProvider)
    }
}
