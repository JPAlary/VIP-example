//
//  MalformedUrlAppError.swift
//  MVVMExample
//
//  Created by Jean-Pierre Alary on 08/04/2017.
//  Copyright © 2017 Jp. All rights reserved.
//

struct MalformedURLAppError: AppError {

    private enum Constant {
        static let translationKey = "error.global.network"
    }

    // MARK: AppError

    var raw: Error? {
        return nil
    }

    var messageKey: String {
        return Constant.translationKey
    }
}
