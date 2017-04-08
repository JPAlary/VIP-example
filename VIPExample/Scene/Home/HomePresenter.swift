//
//  HomePresenter.swift
//  VIPExample
//
//  Created by Jean-Pierre Alary on 06/04/2017.
//  Copyright © 2017 Jp. All rights reserved.
//

import RxSwift
import RxCocoa

struct HomePresenter: Presenter {
    private let translator: Translator

    // MARK: Initializer

    init(translator: Translator) {
        self.translator = translator
    }

    // MARK: Presenter

    func handle(response: EventResponse) -> ViewState<HomeViewModel> {
        if let state = hasError(in: response) {
            return state
        }

        if let state = hasState(in: response) {
            return state
        }

        if let state = hasObject(in: response) {
            return state
        }

        return .error(message: translator.translation(for: "error.generic.message"))
    }

    // MARK: Private

    func hasError(in response: EventResponse) -> ViewState<HomeViewModel>? {
        guard let error = response.error else {
            return nil
        }

        guard let appError = error as? AppError else {
            assertionFailure("Should be instance of AppError")

            return .error(message: translator.translation(for: "error.generic.message"))
        }

        return .error(message: translator.translation(for: appError.messageKey))
    }

    func hasState(in response: EventResponse) -> ViewState<HomeViewModel>? {
        if let state = response.data as? ViewState<HomeViewModel> {
            return state
        } else {
            return nil
        }
    }

    func hasObject(in response: EventResponse) -> ViewState<HomeViewModel>? {
        guard let result = response.data as? Result<User> else {
            return nil
        }

        if case .value(let user) = result {
            return .success(HomeViewModel(name: user.name, surname: user.surname, age: user.age))
        } else {
            assertionFailure("Should be instance of AppError")

            return .error(message: translator.translation(for: "error.generic.message"))
        }
    }
}
