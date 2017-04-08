//
//  AppHTTPErrorHandler.swift
//  MVVMExample
//
//  Created by Jean-Pierre Alary on 08/04/2017.
//  Copyright © 2017 Jp. All rights reserved.
//

struct AppHTTPErrorHandler: HTTPErrorHandler {

    // MARK: HTTPErrorHandler

    func handle(response: Response) -> Error {
        // All the error logic error of the api should be handle here
        
        return NetworkAppError(error: nil)
    }
}
