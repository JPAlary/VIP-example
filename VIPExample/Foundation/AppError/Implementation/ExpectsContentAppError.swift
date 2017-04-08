//
//  ExpectsContentAppError.swift
//  MVVMExample
//
//  Created by Jean-Pierre Alary on 08/04/2017.
//  Copyright © 2017 Jp. All rights reserved.
//

struct ExpectsContentAppError: AppError {
    private let developerMessage: String

    private enum Constant {
        static let translationKey = "error.global"
    }

    // MARK: Initializer

    init(developerMessage: String) {
        self.developerMessage = developerMessage
    }

    // MARK: AppError

    var raw: Error? {
        return nil
    }

    var messageKey: String {
        return Constant.translationKey
    }
}
