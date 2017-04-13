//
//  EditRouter.swift
//  VIPExample
//
//  Created by Jean-Pierre Alary on 13/04/2017.
//  Copyright © 2017 Jp. All rights reserved.
//

import UIKit
import RxSwift

final class EditRouter: Router {
    private let subject: PublishSubject<User>

    // MARK: Initializer 

    init() {
        subject = PublishSubject()
    }

    // MARK: Router

    var callback: Observable<User> {
        return subject.asObservable()
    }

    func route(from root: UIViewController?, request: EventRequest) -> Observable<EventResponse> {
        root?.dismiss(animated: true, completion: nil)

        guard let user: User = request.dataValue() else {
            assertionFailure("Should have User object")

            return Observable.never()
        }

        subject.asObserver().onNext(user)

        return Observable.never()
    }
}
