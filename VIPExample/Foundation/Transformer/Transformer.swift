//
//  Transformer.swift
//  MVVMExample
//
//  Created by Jean-Pierre Alary on 08/04/2017.
//  Copyright © 2017 Jp. All rights reserved.
//

protocol Transformer {
    associatedtype Input
    associatedtype Output

    func transform(object: Input) throws -> Output
}
