//
//  Presenter.swift
//  VIPExample
//
//  Created by Jean-Pierre Alary on 06/04/2017.
//  Copyright © 2017 Jp. All rights reserved.
//

protocol Presenter {
    associatedtype ViewModel

    func handle(response: EventResponse) -> ViewModel
}
