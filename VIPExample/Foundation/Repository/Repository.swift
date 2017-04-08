//
//  Repository.swift
//  MVVMExample
//
//  Created by Jean-Pierre Alary on 08/04/2017.
//  Copyright © 2017 Jp. All rights reserved.
//

import RxSwift

protocol Repository {
    associatedtype T

    func get(with parameter: RepositoryParameter) -> Observable<Result<T>>
    func create(with parameter: RepositoryParameter) -> Observable<Result<T>>
    func edit(with parameter: RepositoryParameter) -> Observable<Result<T>>
    func delete(with parameter: RepositoryParameter) -> Observable<Result<T>>
}
