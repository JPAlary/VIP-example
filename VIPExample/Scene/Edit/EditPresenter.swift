//
//  EditPresenter.swift
//  VIPExample
//
//  Created by Jean-Pierre Alary on 13/04/2017.
//  Copyright © 2017 Jp. All rights reserved.
//

struct EditPresenter: Presenter {
    private let translator: Translator

    private enum Constant {
        static let namePlaceholderKey = "edit.form.field.placeholder.name"
        static let surnamePlaceholderKey = "edit.form.field.placeholder.surname"
        static let agePlaceholderKey = "edit.form.field.placeholder.age"
    }

    // MARK: Initializer

    init(translator: Translator) {
        self.translator = translator
    }

    // MARK: Presenter

    func handle(response: EventResponse) -> EditViewModel {
        switch response.code {
        case .badRequest:
            guard let formError: FormErrorCollection = response.dataValue() else {
                return EditViewModel(
                    placeholder: placeholders,
                    buttonEnabled: false,
                    buttonTitle: buttonTitleTranslation
                )
            }

            let nameFieldError = formError.errors
                .filter { $0.path == "name" }
                .first
                .map { translator.translation(for: $0.message) }
            let surnameFieldError = formError.errors
                .filter { $0.path == "surname" }
                .first
                .map { translator.translation(for: $0.message) }
            let ageFieldError = formError.errors
                .filter { $0.path == "age" }
                .first
                .map { translator.translation(for: $0.message) }

            return EditViewModel(
                placeholder: placeholders,
                errorNameFieldMessage: nameFieldError,
                errorSurnameFieldMessage: surnameFieldError,
                errorAgeFieldMessage: ageFieldError,
                buttonEnabled: buttonEnabledValue(from: response),
                buttonTitle: buttonTitleTranslation
            )
        default:
            return EditViewModel(
                placeholder: placeholders,
                buttonEnabled: buttonEnabledValue(from: response),
                buttonTitle: buttonTitleTranslation
            )
        }
    }

    // MARK: Private

    private func buttonEnabledValue(from response: EventResponse) -> Bool {
        var buttonEnabled = false
        if let objectValidated: Bool = response.data(named: EventParameterKey.objectValidated) {
            buttonEnabled = objectValidated
        }

        return buttonEnabled
    }

    private var placeholders: (name: String, surname: String, age: String) { // swiftlint:disable:this large_tuple
        return (
            name: translator.translation(for: Constant.namePlaceholderKey),
            surname: translator.translation(for: Constant.surnamePlaceholderKey),
            age: translator.translation(for: Constant.agePlaceholderKey)
        )
    }

    var buttonTitleTranslation: String {
        return translator.translation(for: "edit.button.title")
    }
}
