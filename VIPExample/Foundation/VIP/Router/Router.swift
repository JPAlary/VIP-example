//
//  Router.swift
//  VIPExample
//
//  Created by Jean-Pierre Alary on 09/04/2017.
//  Copyright © 2017 Jp. All rights reserved.
//

import UIKit
import RxSwift

protocol Router {
    associatedtype T

    var callback: Observable<T> { get }

    func route(from root: UIViewController?, request: EventRequest) -> Observable<EventResponse>
}
