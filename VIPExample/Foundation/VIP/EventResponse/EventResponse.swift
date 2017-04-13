//
//  InteractorResponse.swift
//  VIPExample
//
//  Created by Jean-Pierre Alary on 06/04/2017.
//  Copyright © 2017 Jp. All rights reserved.
//

protocol EventResponse {
    var succeed: Bool { get }
    var data: [String: Any]? { get }
    var error: Error? { get }
    var code: EventResponseCode { get }

    func data<T>(named: String) -> T?
}

extension EventResponse {
    func data<T>(named: String) -> T? {
        return self.data?[named] as? T
    }

    func dataValue<T>() -> T? {
        return self.data(named: EventParameterKey.value)
    }

    func dataViewState() -> ViewState? {
        return self.data(named: EventParameterKey.viewState)
    }
}
