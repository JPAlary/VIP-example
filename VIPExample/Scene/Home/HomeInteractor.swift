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
    private let logger: Logger

    // MARK: Initializer

    init(repository: AnyRepository<User>, logger: Logger) {
        self.repository = repository
        self.logger = logger
    }

    // MARK: Interactor

    func handle(request: EventRequest) -> Observable<EventResponse> {
        if request.action != .viewDidLoad {
            logger.log(level: .error, message: "Action \(request.action) can be handle by `HomeInteractor`")
        }

        let loading: Observable<EventResponse> = Observable
            .just(LoadingEventResponse())

        let data: Observable<EventResponse> = repository
            .get(with: GetUserParameter(name: "John", surname: "Doe", age: 20))
            .map({ (result) -> AppEventResponse in
                switch result {
                case .noContent:
                    throw ExpectsContentAppError()
                case .value(let user):
                    return AppEventResponse(code: .ok, data: [EventParameterKey.value: user])
                }
            })
            .catchError { Observable.just(AppEventResponse(code: .badRequest, error: $0)) }

        return Observable
            .of(loading, data)
            .merge()
    }
}
