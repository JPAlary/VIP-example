//
//  Interactor.swift
//  VIPExample
//
//  Created by Jean-Pierre Alary on 06/04/2017.
//  Copyright © 2017 Jp. All rights reserved.
//

import RxSwift

protocol Interactor {
    func handle(request: EventRequest) -> Observable<EventResponse>
}
