//
//  HTTPErrorHandler.swift
//  MVVMExample
//
//  Created by Jean-Pierre Alary on 08/04/2017.
//  Copyright © 2017 Jp. All rights reserved.
//

protocol HTTPErrorHandler {
    func handle(response: Response) -> Error
}
