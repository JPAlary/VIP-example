//
//  ShowUserPresenter.swift
//  VIPExample
//
//  Created by Jean-Pierre Alary on 06/04/2017.
//  Copyright © 2017 Jp. All rights reserved.
//

import RxSwift
import RxCocoa

protocol ShowUserPresenterInput {
    var response: Observable<ShowUserCommand.Response> { get }
}

final class ShowUserPresenter: ShowUserViewControllerInput {
    private let translator: Translator
    private let input: ShowUserPresenterInput

    // MARK: Initializer

    init(translator: Translator, input: ShowUserPresenterInput) {
        self.translator = translator
        self.input = input
    }

    // MARK: ShowUserPresenterOutput

    var viewModel: Driver<ShowUserViewModel> {
        return input
            .response
            .withLatestFrom(Observable.just(translator)) { $0 }
            .map { (response, translator) in
                let buttonTitle = translator.translation(for: "home.button.title")

                switch response {
                case .loading:
                    return ShowUserViewModel(
                        state: .loading,
                        buttonTitle: buttonTitle
                    )
                case .error(let error):
                    var state: ViewState

                    if let appError = error as? AppError {
                        state = .error(message: translator.translation(for: appError.messageKey))
                    } else {
                        state = .error(message: translator.translation(for: "error.generic.message"))
                    }

                    return ShowUserViewModel(
                        state: state,
                        buttonTitle: buttonTitle
                    )
                case .value(let user):
                    return ShowUserViewModel(
                        state: .success,
                        buttonTitle: buttonTitle,
                        name: user.name,
                        surname: user.surname,
                        age: user.age
                    )
                }
            }
            .asDriver { (_) -> SharedSequence<DriverSharingStrategy, ShowUserViewModel> in
                return Driver.never()
            }
    }
}
