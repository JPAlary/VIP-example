//
//  UserRepository.swift
//  MVVMExample
//
//  Created by Jean-Pierre Alary on 08/04/2017.
//  Copyright © 2017 Jp. All rights reserved.
//

import RxSwift

final class UserRepository: Repository {
    private let httpClient: HTTPClientType

    // MARK: Initializer

    init(httpClient: HTTPClientType) {
        self.httpClient = httpClient
    }

    // MARK: Repository

    func get(with parameter: RepositoryParameter) -> Observable<Result<User>> {
        guard let userParameter = parameter as? GetUserParameter else {
            return Observable.error(ParameterTypeAppError(developerMessage: "Parameter should be typed GetUserParameter"))
        }

        return httpClient.request(endpoint: HTTPBinEndpoint.get(with: userParameter))
    }

    func create(with parameter: RepositoryParameter) -> Observable<Result<User>> {
        fatalError("create is not implemented")
    }

    func edit(with parameter: RepositoryParameter) -> Observable<Result<User>> {
        fatalError("edit is not implemented")
    }

    func delete(with parameter: RepositoryParameter) -> Observable<Result<User>> {
        fatalError("delete is not implemented")
    }
}
