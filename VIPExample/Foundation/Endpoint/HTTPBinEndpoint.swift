//
//  HTTPBinEndpoint.swift
//  MVVMExample
//
//  Created by Jean-Pierre Alary on 08/04/2017.
//  Copyright © 2017 Jp. All rights reserved.
//

enum HTTPBinEndpoint: Endpoint {
    case get(with: GetUserParameter)

    private enum Constant {
        static let baseUrl = "https://httpbin.org"
        static let path = "get"

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
        return Constant.path
    }

    var httpMethod: HTTPMethod {
        return .GET
    }

    var queryParameters: [String : String]? {
        if case .get(let parameter) = self {
            return [
                Constant.Key.name: parameter.name,
                Constant.Key.surname: parameter.surname,
                Constant.Key.age: "\(parameter.age)",
            ]
        }

        return nil
    }
}
