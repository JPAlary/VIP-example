//
//  LoadingEventResponse.swift
//  VIPExample
//
//  Created by Jean-Pierre Alary on 08/04/2017.
//  Copyright © 2017 Jp. All rights reserved.
//

struct LoadingEventResponse: EventResponse {

    // MARK: EventResponse

    var succeed: Bool {
        return true
    }

    var data: [String: Any]? {
        return [
            EventParameterKey.viewState: ViewState.loading
        ]
    }

    var error: Error? {
        return nil
    }

    var code: EventResponseCode {
        return .processing
    }
}
