//
//  TextfieldValueValidator.swift
//  VIPExample
//
//  Created by Jean-Pierre Alary on 13/04/2017.
//  Copyright © 2017 Jp. All rights reserved.
//

struct TextfieldValueValidator: Validator {
    private enum Constant {
        static let limit = 5
        static let messageKey = "error.count_limit"
    }

    // MARK: Validator

    func validate(object: String) -> DefaultAppError? {
        if object.characters.count == 0 || object.characters.count > Constant.limit {
            return nil
        }

        return DefaultAppError(messageKey: Constant.messageKey)
    }
}
