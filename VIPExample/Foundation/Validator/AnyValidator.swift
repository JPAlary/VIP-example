//
//  AnyValidator.swift
//  VIPExample
//
//  Created by Jean-Pierre Alary on 13/04/2017.
//  Copyright © 2017 Jp. All rights reserved.
//

struct AnyValidator<Object, Error>: Validator {
    private let _validate: (Object) -> Error?

    // MARK: Initializer

    init<V: Validator>(base: V) where V.Object == Object, V.Error == Error {
        _validate = base.validate
    }

    // MARK: Validator

    func validate(object: Object) -> Error? {
        return _validate(object)
    }
}
