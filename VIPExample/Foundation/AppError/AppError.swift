//
//  AppError.swift
//  MVVMExample
//
//  Created by Jean-Pierre Alary on 08/04/2017.
//  Copyright © 2017 Jp. All rights reserved.
//

protocol AppError: Error {
    var raw: Error? { get }
    var messageKey: String { get }
}
