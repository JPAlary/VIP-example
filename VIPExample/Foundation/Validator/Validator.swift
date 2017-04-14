//
//  Validator.swift
//  VIPExample
//
//  Created by Jean-Pierre Alary on 13/04/2017.
//  Copyright © 2017 Jp. All rights reserved.
//

protocol Validator {
    associatedtype Object
    associatedtype Error

    func validate(object: Object) -> Error?
}
