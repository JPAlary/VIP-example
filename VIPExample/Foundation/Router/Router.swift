//
//  Router.swift
//  VIPExample
//
//  Created by Jp Alary on 28/04/2017.
//  Copyright © 2017 Jp. All rights reserved.
//

import RxSwift

protocol Router {
    associatedtype Value

    var callback: Observable<Value> { get }

    func perform(route: Route)
}
