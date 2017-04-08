//
//  Endpoint.swift
//  MVVMExample
//
//  Created by Jean-Pierre Alary on 08/04/2017.
//  Copyright © 2017 Jp. All rights reserved.
//

protocol Endpoint {
    var baseUrl: String { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var headers: [String: String]? { get }
    var queryParameters: [String: String]? { get }
    var bodyParameter: [String: Any]? { get }
}

extension Endpoint {
    var headers: [String: String]? {
        return nil
    }

    var queryParameters: [String: String]? {
        return nil
    }

    var bodyParameter: [String: Any]? {
        return nil
    }
}
