//
//  AppEventResponse.swift
//  VIPExample
//
//  Created by Jean-Pierre Alary on 06/04/2017.
//  Copyright © 2017 Jp. All rights reserved.
//

struct AppEventResponse: EventResponse {
    private let _code: EventResponseCode
    private let _error: Error?
    private let _data: [String: Any]?

    // MARK: Initializer

    init(code: EventResponseCode, error: Error? = nil, data: [String: Any]? = nil) {
        _code = code
        _error = error
        _data = data
    }

    // MARK: EventResponse

    var succeed: Bool {
        if nil != error {
            return false
        }

        return true
    }

    var data: [String: Any]? {
        return _data
    }

    var error: Error? {
        return _error
    }

    var code: EventResponseCode {
        return _code
    }
}
