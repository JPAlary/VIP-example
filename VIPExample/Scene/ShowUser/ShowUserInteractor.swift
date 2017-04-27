//
//  ShowUserInteractor.swift
//  VIPExample
//
//  Created by Jean-Pierre Alary on 06/04/2017.
//  Copyright © 2017 Jp. All rights reserved.
//

import RxSwift

final class ShowUserInteractor: ShowUserViewControllerOutput, ShowUserPresenterInput {
    private let disposeBag: DisposeBag
    private let responseVariable: Variable<ShowUserCommand.Response>
    private let repository: AnyRepository<User>
    private let logger: Logger
    private let router: AnyRouter<User>

    // MARK: Initializer

    init(repository: AnyRepository<User>, logger: Logger, router: AnyRouter<User>) {
        self.repository = repository
        self.logger = logger
        self.router = router

        disposeBag = DisposeBag()
        responseVariable = Variable(ShowUserCommand.Response.loading)

        router
            .callback
            .subscribe { [weak self] (event) in
                if case .next(let user) = event {
                    self?.responseVariable.value = ShowUserCommand.Response.value(user)
                }
            }
            .disposed(by: disposeBag)
    }

    // MARK: ShowUserViewControllerOutput

    func handle(request: ShowUserCommand.Request) {
        logger.log(level: .info, message: "Executing command: \(String(describing: request))")

        switch request {
        case .viewDidLoad:
            logger.log(level: .error, message: "Executing command: \(String(describing: request))")

            rx_request()
                .bindTo(responseVariable)
                .disposed(by: disposeBag)

        case .route(let viewController):
            router.perform(route: Route(from: viewController, data: nil))
        }
    }

    // MARK: ShowUserPresenterInput

    var response: Observable<ShowUserCommand.Response> {
        return responseVariable.asObservable()
    }

    // MARK: Private

    private func rx_request() -> Observable<ShowUserCommand.Response> {
        return repository
            .get(with: GetUserParameter(name: "John", surname: "Doe", age: 20))
            .map({ (result) -> ShowUserCommand.Response in
                switch result {
                case .noContent:
                    throw ExpectsContentAppError()
                case .value(let user):
                    return ShowUserCommand.Response.value(user)
                }
            })
            .catchError { Observable.just(ShowUserCommand.Response.error($0)) }

    }
}
