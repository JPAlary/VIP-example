//
//  NoRequestParameterAppError.swift
//  VIPExample
//
//  Created by Jean-Pierre Alary on 12/04/2017.
//  Copyright © 2017 Jp. All rights reserved.
//

struct NoRequestParameterAppError: AppError {
    private enum Constant {
        static let translationKey = "error.global.default"
    }

    // MARK: AppError

    var raw: Error? {
        return nil
    }

    var messageKey: String {
        return Constant.translationKey
    }
}
