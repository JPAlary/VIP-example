//
//  AppEventResponse.swift
//  VIPExample
//
//  Created by Jean-Pierre Alary on 06/04/2017.
//  Copyright © 2017 Jp. All rights reserved.
//

struct AppEventResponse: EventResponse {
    private let _error: Error?
    private let _data: EventResponseDataType?

    // MARK: Initializer

    init(error: Error? = nil, data: EventResponseDataType? = nil) {
        self._error = error
        self._data = data
    }

    // MARK: EventResponse

    var succeed: Bool {
        guard let _ = error else {
            return true
        }

        return false
    }

    var data: EventResponseDataType? {
        return _data
    }

    var error: Error? {
        return _error
    }
}
