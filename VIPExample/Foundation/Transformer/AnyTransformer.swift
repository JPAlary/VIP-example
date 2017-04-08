//
//  AnyTransformer.swift
//  MVVMExample
//
//  Created by Jean-Pierre Alary on 08/04/2017.
//  Copyright © 2017 Jp. All rights reserved.
//

struct AnyTransformer<Input, Output>: Transformer {
    private let _transform: (Input) throws -> Output

    // MARK: Initializer

    init<T: Transformer>(base: T) where T.Input == Input, T.Output == Output {
        _transform = base.transform
    }

    // MARK: Transformer

    func transform(object: Input) throws -> Output {
        return try _transform(object)
    }
}
