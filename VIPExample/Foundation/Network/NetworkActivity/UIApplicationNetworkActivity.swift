//
//  UIApplicationNetworkActivity.swift
//  MVVMExample
//
//  Created by Jean-Pierre Alary on 08/04/2017.
//  Copyright © 2017 Jp. All rights reserved.
//

import UIKit

final class UIApplicationNetworkActivity: NetworkActivity {
    private let application: UIApplication
    private var counter: Int

    // MARK: Initializer

    init(application: UIApplication) {
        self.application = application
        counter = 0
    }

    // MARK: NetworkActivity

    func show() -> Void {
        counter += 1

        if false == application.isNetworkActivityIndicatorVisible {
            application.isNetworkActivityIndicatorVisible = true
        }
    }

    func hide() -> Void {
        if counter > 0 {
            counter -= 1
        }

        if counter == 0 && application.isNetworkActivityIndicatorVisible {
            application.isNetworkActivityIndicatorVisible = false
        }
    }
}
