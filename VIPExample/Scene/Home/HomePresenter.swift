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
    private let logger: Logger

    // MARK: Initializer

    init(translator: Translator, logger: Logger) {
        self.translator = translator
        self.logger = logger
    }

    // MARK: Presenter

    func handle(response: EventResponse) -> HomeViewModel {
        switch response.code {
        case .ok:
            guard let user: User = response.dataValue() else {
                assertionFailure("Should have data")

                return HomeViewModel(
                    state: .error(message: translator.translation(for: "error.generic.message")),
                    buttonTitle: buttonTitleTranslation
                )
            }

            return HomeViewModel(
                state: .success,
                buttonTitle: buttonTitleTranslation,
                name: user.name,
                surname: user.surname,
                age: user.age
            )
        case .badRequest:
            var state: ViewState

            if let appError = response.error as? AppError {
                logger.log(level: .warning, message: "HomePresenter - response.error should be instance of AppError")
                state = .error(message: translator.translation(for: appError.messageKey))
            } else {
                state = .error(message: translator.translation(for: "error.generic.message"))
            }

            return HomeViewModel(
                state: state,
                buttonTitle: buttonTitleTranslation
            )
        case .processing:
            return HomeViewModel(
                state: .loading,
                buttonTitle: buttonTitleTranslation
            )
        default:
            return HomeViewModel(
                state: .error(message: translator.translation(for: "error.generic.message")),
                buttonTitle: buttonTitleTranslation
            )
        }
    }

    // MARK: Private

    var buttonTitleTranslation: String {
        return translator.translation(for: "home.button.title")
    }
}
