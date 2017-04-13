//
//  UITextfield+Rx.swift
//  VIPExample
//
//  Created by Jean-Pierre Alary on 13/04/2017.
//  Copyright © 2017 Jp. All rights reserved.
//

import UIKit
import RxSwift

extension Reactive where Base: UITextField {
    var placeholder: AnyObserver<String?> {
        return AnyObserver { event in
            MainScheduler.ensureExecutingOnScheduler()

            if case .next(let value) = event {
                self.base.placeholder = value
            }
        }
    }

    var errorState: AnyObserver<Bool> {
        return AnyObserver { event in
            MainScheduler.ensureExecutingOnScheduler()

            if case .next(let value) = event {
                if value {
                    self.base.layer.borderWidth = 2.0
                    self.base.layer.borderColor = UIColor.red.cgColor
                } else {
                    self.base.layer.borderWidth = 0.0
                    self.base.layer.borderColor = UIColor.clear.cgColor
                }
            }
        }
    }
}
