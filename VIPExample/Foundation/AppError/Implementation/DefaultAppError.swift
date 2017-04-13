//
//  DefaultAppError.swift
//  VIPExample
//
//  Created by Jean-Pierre Alary on 13/04/2017.
//  Copyright © 2017 Jp. All rights reserved.
//

struct DefaultAppError: AppError {
    private let _messageKey: String

    // MARK: Initializer

    init(messageKey: String) {
        _messageKey = messageKey
    }

    // MARK: AppError

    var raw: Error? {
        return nil
    }

    var messageKey: String {
        return _messageKey
    }
}
