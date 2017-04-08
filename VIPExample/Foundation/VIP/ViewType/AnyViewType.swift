//
//  AnyViewType.swift
//  VIPExample
//
//  Created by Jean-Pierre Alary on 08/04/2017.
//  Copyright © 2017 Jp. All rights reserved.
//

import RxCocoa

final class AnyViewType<T>: ViewType {
    private let _view: () -> UIView
    private let _update: (Driver<ViewState<T>>) -> Void

    // MARK: Initializer

    init<V: ViewType>(base: V) where V.T == T {
        _view = {
            return base.view
        }
        _update = base.update
    }

    // MARK: ViewType

    var view: UIView {
        return _view()
    }

    func update(with stateProvider: Driver<ViewState<T>>) -> Void {
        return _update(stateProvider)
    }
}
