//
//  AppResponse.swift
//  MVVMExample
//
//  Created by Jean-Pierre Alary on 08/04/2017.
//  Copyright © 2017 Jp. All rights reserved.
//

import Foundation

struct AppResponse: Response {
    private let _request: URLRequest
    private let _data: Data?
    private let httpResponse: URLResponse?
    private let _error: Error?

    // MARK: Initializer

    init(request: URLRequest, data: Data?, httpResponse: URLResponse?, error: Error?) {
        _request = request
        _data = data
        _error = error
        self.httpResponse = httpResponse
    }

    // MARK: Response

    var succeed: Bool {
        guard let httpResponse = httpResponse as? HTTPURLResponse else {
            return false
        }

        return httpResponse.statusCode >= HTTPStatusCode.ok.rawValue && httpResponse.statusCode < HTTPStatusCode.badRequest.rawValue
    }

    var data: Data? {
        return _data
    }

    var error: Error? {
        return _error
    }

    var statusCode: HTTPStatusCode? {
        guard let httpResponse = httpResponse as? HTTPURLResponse else {
            return nil
        }

        return HTTPStatusCode(rawValue: httpResponse.statusCode)
    }

    var request: URLRequest {
        return _request
    }

    var headers: [String: Any]? {
        guard let httpResponse = httpResponse as? HTTPURLResponse else {
            return nil
        }

        return httpResponse.allHeaderFields as? [String: Any]
    }
}
