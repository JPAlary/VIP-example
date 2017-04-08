//
//  AnyPresenter.swift
//  VIPExample
//
//  Created by Jean-Pierre Alary on 06/04/2017.
//  Copyright © 2017 Jp. All rights reserved.
//

final class AnyPresenter<T>: Presenter {
    private let _handle: (EventResponse) -> ViewState<T>

    // MARK: Initializer

    init<P: Presenter>(base: P) where P.T == T {
        _handle = base.handle
    }

    // MARK: Presenter

    func handle(response: EventResponse) -> ViewState<T> {
        return _handle(response)
    }
}
