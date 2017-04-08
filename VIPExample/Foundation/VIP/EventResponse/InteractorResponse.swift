//
//  InteractorResponse.swift
//  VIPExample
//
//  Created by Jean-Pierre Alary on 06/04/2017.
//  Copyright © 2017 Jp. All rights reserved.
//

protocol EventResponse {
    var succeed: Bool { get }
    var data: EventResponseDataType? { get }
    var error: Error? { get }
}
