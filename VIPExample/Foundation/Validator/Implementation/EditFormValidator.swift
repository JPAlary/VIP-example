//
//  EditFormValidator.swift
//  VIPExample
//
//  Created by Jean-Pierre Alary on 13/04/2017.
//  Copyright © 2017 Jp. All rights reserved.
//

struct EditFormValidator: Validator {
    private let countLimitValidator: AnyValidator<String, DefaultAppError>
    private let intValidator: AnyValidator<String, DefaultAppError>

    // MARK: Initializer

    init(
        countLimitValidator: AnyValidator<String, DefaultAppError>,
        intValidator: AnyValidator<String, DefaultAppError>
    ) {
        self.countLimitValidator = countLimitValidator
        self.intValidator = intValidator
    }

    // MARK: Validator

    func validate(object: EventRequest) -> FormErrorCollection? {
        var errors = [FormError]()
        
        if let name = object.parameter(named: "name"),
            let error = countLimitValidator.validate(object: name) {
            errors.append(FormError(path: "name", message: error.messageKey))
        }

        if let surname = object.parameter(named: "surname"),
            let error = countLimitValidator.validate(object: surname) {
            errors.append(FormError(path: "surname", message: error.messageKey))
        }

        if let age = object.parameter(named: "age"),
            let error = intValidator.validate(object: age) {
            errors.append(FormError(path: "age", message: error.messageKey))
        }

        return errors.count > 0 ? FormErrorCollection(errors: errors) : nil
    }
}
