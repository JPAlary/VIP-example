//
//  EventRequest.swift
//  VIPExample
//
//  Created by Jean-Pierre Alary on 06/04/2017.
//  Copyright © 2017 Jp. All rights reserved.
//

import Foundation

struct EventRequest {
    private let _path: String?
    private let _parameters: [String: String]?
    private let _data: [String: Any]?
    private let _action: AppAction

    // MARK: Initializer

    init(path: String? = nil, parameters: [String: String]? = nil, data: [String: Any]? = nil, action: AppAction) {
        _path = path
        _parameters = parameters
        _data = data
        _action = action
    }

    // MARK: Public

    var path: String? {
        return _path
    }

    var parameters: [String: String]? {
        return _parameters
    }

    var action: AppAction {
        return _action
    }

    var data: [String: Any]? {
        return _data
    }

    func parameter(named: String) -> String? {
        return parameters?[named]
    }

    func dataValue<T>() -> T? {
        return data?[EventParameterKey.value] as? T
    }
}
