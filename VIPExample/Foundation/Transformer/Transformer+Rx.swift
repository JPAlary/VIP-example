//
//  Transformer+Rx.swift
//  MVVMExample
//
//  Created by Jean-Pierre Alary on 08/04/2017.
//  Copyright © 2017 Jp. All rights reserved.
//

import RxSwift

extension Transformer {
    func rx_transform(object: Input) -> Observable<Output> {
        return Observable.create({ (observer) -> Disposable in
            do {
                observer.onNext(try self.transform(object: object))
                observer.onCompleted()
            } catch {
                observer.onError(error)
            }

            return Disposables.create()
        })
    }
}
