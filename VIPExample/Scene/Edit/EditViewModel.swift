//
//  EditViewModel.swift
//  VIPExample
//
//  Created by Jean-Pierre Alary on 12/04/2017.
//  Copyright © 2017 Jp. All rights reserved.
//

struct EditViewModel {
    let namePlaceholder: String
    let surnamePlaceholder: String
    let agePlaceholder: String

    let errorNameFieldMessage: String?
    let errorSurnameFieldMessage: String?
    let errorAgeFieldMessage: String?

    let buttonEnabled: Bool
    let buttonTitle: String

    // MARK: Initializer

    init(
        placeholder: (name: String, surname: String, age: String),
        errorNameFieldMessage: String? = nil,
        errorSurnameFieldMessage: String? = nil,
        errorAgeFieldMessage: String? = nil,
        buttonEnabled: Bool,
        buttonTitle: String
    ) {
        self.namePlaceholder = placeholder.name
        self.surnamePlaceholder = placeholder.surname
        self.agePlaceholder = placeholder.age

        self.errorNameFieldMessage = errorNameFieldMessage
        self.errorSurnameFieldMessage = errorSurnameFieldMessage
        self.errorAgeFieldMessage = errorAgeFieldMessage

        self.buttonEnabled = buttonEnabled
        self.buttonTitle = buttonTitle
    }
}
