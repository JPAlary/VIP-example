//
//  AppAction.swift
//  VIPExample
//
//  Created by Jean-Pierre Alary on 06/04/2017.
//  Copyright © 2017 Jp. All rights reserved.
//

enum AppAction: Equatable {
    case viewDidLoad
    case viewWillAppear
    case viewDidAppear
    case viewWillDisappear
    case viewDidDisappear
    case tap
    case userInfo
    case navigate
}

func == (lhs: AppAction, rhs: AppAction) -> Bool {
    return String(describing: lhs) == String(describing: rhs)
}
