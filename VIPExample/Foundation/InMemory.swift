//
//  InMemory.swift
//  VIPExample
//
//  Created by Jean-Pierre Alary on 13/04/2017.
//  Copyright © 2017 Jp. All rights reserved.
//

import RxSwift

final class InMemory<T> {
    private(set) var value: T

    // MARK: Initializer

    init(defaultValue: T) {
        value = defaultValue
    }

    // MARK: Public

    func update(with object: T) -> Observable<T> {
        value = object

        return Observable.just(value)
    }

    var rx_value: Observable<T> {
        return Observable.just(value)
    }
}
