//
//  HomeViewModel.swift
//  VIPExample
//
//  Created by Jean-Pierre Alary on 06/04/2017.
//  Copyright © 2017 Jp. All rights reserved.
//

struct HomeViewModel {
    let state: ViewState
    let buttonTitle: String
    
    let name: String?
    let surname: String?
    let age: String?

    // MARK: Initializer

    init(state: ViewState, buttonTitle: String, name: String? = nil, surname: String? = nil, age: String? = nil) {
        self.state = state
        self.buttonTitle = buttonTitle
        self.name = name
        self.surname = surname
        self.age = age
    }
}
