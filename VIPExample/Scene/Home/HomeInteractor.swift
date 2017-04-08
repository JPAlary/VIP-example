//
//  HomeInteractor.swift
//  VIPExample
//
//  Created by Jean-Pierre Alary on 06/04/2017.
//  Copyright © 2017 Jp. All rights reserved.
//

import RxSwift

final class HomeInteractor: Interactor {
    private let repository: AnyRepository<User>

    // MARK: Initializer

    init(repository: AnyRepository<User>) {
        self.repository = repository
    }

    // MARK: Interactor

    func handle(request: EventRequest) -> Observable<EventResponse> {
        if false == canHandle(action: request.action) {
            fatalError("Action \(request.action) can be handle by `HomeInteractor`")
        }

        let loading: Observable<EventResponse> = Observable
            .just(LoadingEventResponse<HomeViewModel>())
        
        let data: Observable<EventResponse> = repository
            .get(with: GetUserParameter(name: "John", surname: "Doe", age: 20))
            .map { AppEventResponse(data: $0) }
            .catchError { Observable.just(AppEventResponse(error: $0)) }

        return Observable
            .of(loading, data)
            .merge()
    }

    // MARK: Private

    private func canHandle(action: AppAction) -> Bool {
        guard let homeAction = action as? HomeViewController.Action else {
            return false
        }

        return homeAction == HomeViewController.Action.viewDidLoad
    }
}
