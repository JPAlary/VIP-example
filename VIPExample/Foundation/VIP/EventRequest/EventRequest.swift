//
//  EventRequest.swift
//  VIPExample
//
//  Created by Jean-Pierre Alary on 06/04/2017.
//  Copyright © 2017 Jp. All rights reserved.
//

protocol EventRequest {
    var url: String? { get }
    var parameters: [String: String]? { get }
    var action: AppAction { get }
}
