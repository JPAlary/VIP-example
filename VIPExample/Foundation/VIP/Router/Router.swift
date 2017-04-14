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
    associatedtype Object

    var callback: Observable<Object> { get }

    func route(from root: UIViewController?, request: EventRequest) -> Observable<EventResponse>
}
