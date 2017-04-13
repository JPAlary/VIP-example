//
//  InvalidFormAppError.swift
//  VIPExample
//
//  Created by Jean-Pierre Alary on 13/04/2017.
//  Copyright © 2017 Jp. All rights reserved.
//

struct InvalidFormAppError: AppError {
    private enum Constant {
        static let messageKey = "error.global.form"
    }

    // MARK: AppError

    var raw: Error? {
        return nil
    }

    var messageKey: String {
        return Constant.messageKey
    }
}
