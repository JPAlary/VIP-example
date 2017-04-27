//
//  ShowUserCommand.swift
//  VIPExample
//
//  Created by Jp Alary on 27/04/2017.
//  Copyright © 2017 Jp. All rights reserved.
//

import UIKit

struct ShowUserCommand {
    enum Request {
        case route(from: UIViewController?)
        case viewDidLoad
    }

    enum Response {
        case loading
        case error(Error)
        case value(User)
    }
}
