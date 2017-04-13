//
//  DictionaryToUserTransformer.swift
//  VIPExample
//
//  Created by Jean-Pierre Alary on 13/04/2017.
//  Copyright © 2017 Jp. All rights reserved.
//

import Foundation

struct DictionaryToUserTransformer: Transformer {

    // MARK: Transformer

    func transform(object: [String: String]) throws -> User {
        guard
            let name = object["name"],
            let surname = object["surname"],
            let age = object["age"]
        else {
            throw DefaultAppError(messageKey: "error.global")
        }

        return User(name: name, surname: surname, age: age)
    }
}
