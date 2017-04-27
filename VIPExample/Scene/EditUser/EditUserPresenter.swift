//
//  EditUserPresenter.swift
//  VIPExample
//
//  Created by Jean-Pierre Alary on 13/04/2017.
//  Copyright © 2017 Jp. All rights reserved.
//

import RxSwift
import RxCocoa

protocol EditUserPresenterInput {
    var response: Observable<EditUserCommand.Response> { get }
}

final class EditUserPresenter: EditUserViewControllerInput {
    private let translator: Translator
    private let input: EditUserPresenterInput

    private enum Constant {
        static let namePlaceholderKey = "edit.form.field.placeholder.name"
        static let surnamePlaceholderKey = "edit.form.field.placeholder.surname"
        static let agePlaceholderKey = "edit.form.field.placeholder.age"
    }

    // MARK: Initializer

    init(translator: Translator, input: EditUserPresenterInput) {
        self.translator = translator
        self.input = input
    }

    // MARK: EditUserViewControllerInput

    var viewModel: Driver<EditUserViewModel> {
        return input
            .response
            .withLatestFrom(Observable.just(translator)) { $0 }
            .map { (response, translator) in
                let buttonTitle = translator.translation(for: "edit.button.title")

                switch response {
                case .error(let error):
                    guard let appError = error as? AppError else {
                        fatalError("EditUserPresenter: \(error) should be instance of `AppError`")
                    }

                    return EditUserViewModel(
                        state: .error(message: translator.translation(for: appError.messageKey)),
                        placeholder: (
                            name: translator.translation(for: Constant.namePlaceholderKey),
                            surname: translator.translation(for: Constant.surnamePlaceholderKey),
                            age: translator.translation(for: Constant.agePlaceholderKey)
                        ),
                        buttonEnabled: false,
                        buttonTitle: buttonTitle
                    )
                case .formError(let collection):
                    let nameFieldError = collection.errors
                        .filter { $0.path == "name" }
                        .first
                        .map { translator.translation(for: $0.message) }
                    let surnameFieldError = collection.errors
                        .filter { $0.path == "surname" }
                        .first
                        .map { translator.translation(for: $0.message) }
                    let ageFieldError = collection.errors
                        .filter { $0.path == "age" }
                        .first
                        .map { translator.translation(for: $0.message) }

                    return EditUserViewModel(
                        state: .success,
                        placeholder: (
                            name: translator.translation(for: Constant.namePlaceholderKey),
                            surname: translator.translation(for: Constant.surnamePlaceholderKey),
                            age: translator.translation(for: Constant.agePlaceholderKey)
                        ),
                        errorNameFieldMessage: nameFieldError,
                        errorSurnameFieldMessage: surnameFieldError,
                        errorAgeFieldMessage: ageFieldError,
                        buttonEnabled: false,
                        buttonTitle: buttonTitle
                    )
                case .ok:
                    return EditUserViewModel(
                        state: .success,
                        placeholder: (
                            name: translator.translation(for: Constant.namePlaceholderKey),
                            surname: translator.translation(for: Constant.surnamePlaceholderKey),
                            age: translator.translation(for: Constant.agePlaceholderKey)
                        ),
                        buttonEnabled: true,
                        buttonTitle: buttonTitle
                    )
                case .loading:
                    return EditUserViewModel(
                        state: .loading,
                        placeholder: (
                            name: translator.translation(for: Constant.namePlaceholderKey),
                            surname: translator.translation(for: Constant.surnamePlaceholderKey),
                            age: translator.translation(for: Constant.agePlaceholderKey)
                        ),
                        buttonEnabled: true,
                        buttonTitle: buttonTitle
                    )
                }
            }
            .asDriver { (_) -> SharedSequence<DriverSharingStrategy, EditUserViewModel> in
                return Driver.never()
            }
    }
}
