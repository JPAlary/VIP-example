//
//  AnyValidator.swift
//  VIPExample
//
//  Created by Jean-Pierre Alary on 13/04/2017.
//  Copyright © 2017 Jp. All rights reserved.
//

struct AnyValidator<T, E>: Validator {
    private let _validate: (T) -> E?

    // MARK: Initializer

    init<V: Validator>(base: V) where V.T == T, V.E == E {
        _validate = base.validate
    }

    // MARK: Validator

    func validate(object: T) -> E? {
        return _validate(object)
    }
}
