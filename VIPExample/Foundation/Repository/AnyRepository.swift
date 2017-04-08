//
//  AnyRepository.swift
//  MVVMExample
//
//  Created by Jean-Pierre Alary on 08/04/2017.
//  Copyright © 2017 Jp. All rights reserved.
//

import RxSwift

final class AnyRepository<T>: Repository {
    private let _get: (RepositoryParameter) -> Observable<Result<T>>
    private let _create: (RepositoryParameter) -> Observable<Result<T>>
    private let _edit: (RepositoryParameter) -> Observable<Result<T>>
    private let _delete: (RepositoryParameter) -> Observable<Result<T>>

    // MARK: Initializer

    init<R: Repository>(base: R) where R.T == T {
        _get = base.get
        _create = base.create
        _edit = base.edit
        _delete = base.delete
    }

    // MARK: Repository

    func get(with parameter: RepositoryParameter) -> Observable<Result<T>> {
        return _get(parameter)
    }

    func create(with parameter: RepositoryParameter) -> Observable<Result<T>> {
        return _create(parameter)
    }

    func edit(with parameter: RepositoryParameter) -> Observable<Result<T>> {
        return _edit(parameter)
    }

    func delete(with parameter: RepositoryParameter) -> Observable<Result<T>> {
        return _delete(parameter)
    }
}
