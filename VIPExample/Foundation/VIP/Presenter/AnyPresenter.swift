//
//  AnyPresenter.swift
//  VIPExample
//
//  Created by Jean-Pierre Alary on 06/04/2017.
//  Copyright © 2017 Jp. All rights reserved.
//

final class AnyPresenter<ViewModel>: Presenter {
    private let _handle: (EventResponse) -> ViewModel

    // MARK: Initializer

    init<P: Presenter>(base: P) where P.ViewModel == ViewModel {
        _handle = base.handle
    }

    // MARK: Presenter

    func handle(response: EventResponse) -> ViewModel {
        return _handle(response)
    }
}
