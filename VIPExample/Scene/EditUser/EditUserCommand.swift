//
//  EditUserCommand.swift
//  VIPExample
//
//  Created by Jp Alary on 27/04/2017.
//  Copyright © 2017 Jp. All rights reserved.
//

import UIKit

struct EditUserCommand {
    enum Request {
        case edit(UIViewController?)
        case value(name: String?, surname: String?, age: String?)
    }

    enum Response {
        case loading
        case error(Error)
        case formError(FormErrorCollection)
        case ok // swiftlint:disable:this identifier_name
    }
}
