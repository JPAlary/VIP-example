//
//  AppEventRequest.swift
//  VIPExample
//
//  Created by Jean-Pierre Alary on 06/04/2017.
//  Copyright © 2017 Jp. All rights reserved.
//

struct AppEventRequest: EventRequest {
    private let _url: String?
    private let _parameters: [String: String]?
    private let _action: AppAction

    // MARK: Initializer

    init(_url: String? = nil, _parameters: [String: String]? = nil, _action: AppAction) {
        self._url = _url
        self._parameters = _parameters
        self._action = _action
    }

    // MARK: EventRequest

    var url: String? {
        return _url
    }

    var parameters: [String: String]? {
        return _parameters
    }

    var action: AppAction {
        return _action
    }
}
