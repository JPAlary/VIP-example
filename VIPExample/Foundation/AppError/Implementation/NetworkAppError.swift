//
//  NetworkAppError.swift
//  MVVMExample
//
//  Created by Jean-Pierre Alary on 08/04/2017.
//  Copyright © 2017 Jp. All rights reserved.
//

struct NetworkAppError: AppError {
    private let error: Error?

    private enum Constant {
        static let translationKey = "error.global.network"
    }

    // MARK: Initializer

    init(error: Error?) {
        self.error = error
    }

    // MARK: AppError

    var raw: Error? {
        return error
    }

    var messageKey: String {
        return Constant.translationKey
    }
}
