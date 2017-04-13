//
//  HTTPBinEndpoint.swift
//  MVVMExample
//
//  Created by Jean-Pierre Alary on 08/04/2017.
//  Copyright © 2017 Jp. All rights reserved.
//

enum HTTPBinEndpoint: Endpoint {
    case get(with: GetUserParameter)
    case edit(with: EditUserParameter)

    private enum Constant {
        static let baseUrl = "https://httpbin.org"
        static let get = "get"
        static let edit = "put"

        enum Key {
            static let name = "name"
            static let surname = "surname"
            static let age = "age"
        }
    }

    // MARK: Endpoint

    var baseUrl: String {
        return Constant.baseUrl
    }

    var path: String {
        switch self {
        case .get:
            return Constant.get
        case .edit:
            return Constant.edit
        }
    }

    var httpMethod: HTTPMethod {
        switch self {
        case .get:
            return .GET
        case .edit:
            return .PUT
        }
    }

    var queryParameters: [String: String]? {
        switch self {
        case .get(let parameter):
            return [
                Constant.Key.name: parameter.name,
                Constant.Key.surname: parameter.surname,
                Constant.Key.age: "\(parameter.age)",
            ]
        case .edit(let parameter):
            return [
                Constant.Key.name: parameter.name,
                Constant.Key.surname: parameter.surname,
                Constant.Key.age: parameter.age,
            ]
        }
    }
}
