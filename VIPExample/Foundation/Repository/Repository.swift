//
//  Repository.swift
//  MVVMExample
//
//  Created by Jean-Pierre Alary on 08/04/2017.
//  Copyright © 2017 Jp. All rights reserved.
//

import RxSwift

protocol Repository {
    associatedtype Resource

    func get(with parameter: RepositoryParameter) -> Observable<Result<Resource>>
    func create(with parameter: RepositoryParameter) -> Observable<Result<Resource>>
    func edit(with parameter: RepositoryParameter) -> Observable<Result<Resource>>
    func delete(with parameter: RepositoryParameter) -> Observable<Result<Resource>>
}
