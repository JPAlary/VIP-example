//
//  LoadingEventResponse.swift
//  VIPExample
//
//  Created by Jean-Pierre Alary on 08/04/2017.
//  Copyright © 2017 Jp. All rights reserved.
//

struct LoadingEventResponse<T>: EventResponse {

    // MARK: EventResponse

    var succeed: Bool {
        return true
    }

    var data: EventResponseDataType? {
        return ViewState<T>.loading
    }

    var error: Error? {
        return nil
    }
}
