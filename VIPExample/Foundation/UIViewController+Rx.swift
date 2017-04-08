//
//  UIViewController+Rx.swift
//  MVVMExample
//
//  Created by Jean-Pierre Alary on 08/04/2017.
//  Copyright © 2017 Jp. All rights reserved.
//

import UIKit
import RxSwift

extension Reactive where Base: UIViewController {
    var viewWillAppear: Observable<Void> {
        return methodInvoked(#selector(base.viewWillAppear(_:))).map { _ in return }
    }
}
