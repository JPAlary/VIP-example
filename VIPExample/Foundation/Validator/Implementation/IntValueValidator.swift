//
//  IntValueValidator.swift
//  VIPExample
//
//  Created by Jean-Pierre Alary on 13/04/2017.
//  Copyright © 2017 Jp. All rights reserved.
//

struct IntValueValidator: Validator {
    private enum Constant {
        static let messageKey = "error.int"
    }

    // MARK: Validator

    func validate(object: String) -> DefaultAppError? {
        if object.characters.count == 0 {
            return nil
        }

        if nil != Int(object) {
            return nil
        }

        return DefaultAppError(messageKey: Constant.messageKey)
    }
}
