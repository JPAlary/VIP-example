//
//  User.swift
//  MVVMExample
//
//  Created by Jean-Pierre Alary on 08/04/2017.
//  Copyright © 2017 Jp. All rights reserved.
//

struct User: Deserializable {
    let name: String
    let surname: String
    let age: String

    fileprivate enum Key {
        static let args = "args"
        static let name = "name"
        static let surname = "surname"
        static let age = "age"
    }
}

extension User: AnyInitializable {
    init(object: Any) throws {
        guard
            let dictionary = object as? [String: Any],
            let args = dictionary[Key.args] as? [String: Any]
            else {
                throw DeserializationAppError(developerMessage: "[User] - Not a dictionary")
        }

        guard
            let name = args[Key.name] as? String,
            let surname = args[Key.surname] as? String,
            let age = args[Key.age] as? String
            else {
                throw DeserializationAppError(developerMessage: "[User] - Missing value")
        }

        self.name = name
        self.surname = surname
        self.age = age
    }
}
