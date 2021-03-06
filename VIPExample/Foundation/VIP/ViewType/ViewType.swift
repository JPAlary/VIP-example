//
//  ViewType.swift
//  VIPExample
//
//  Created by Jean-Pierre Alary on 08/04/2017.
//  Copyright © 2017 Jp. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

protocol ViewType {
    associatedtype ViewModel

    var view: UIView { get }

    func request() -> Observable<EventRequest>
    func update(with provider: Driver<ViewModel>)
}

extension ViewType where Self: UIView {
    var view: UIView {
        return self
    }
}
