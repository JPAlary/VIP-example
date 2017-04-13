//
//  EditInteractor.swift
//  VIPExample
//
//  Created by Jean-Pierre Alary on 12/04/2017.
//  Copyright © 2017 Jp. All rights reserved.
//

import RxSwift

final class EditInteractor: Interactor {
    private let inMemory: InMemory<[String: String]>
    private let validator: AnyValidator<EventRequest, FormErrorCollection>
    private let repository: AnyRepository<User>
    private let transformer: AnyTransformer<[String: String], User>

    // MARK: Initializer

    init(
        inMemory: InMemory<[String: String]>, 
        validator: AnyValidator<EventRequest, FormErrorCollection>,
        repository: AnyRepository<User>,
        transformer: AnyTransformer<[String: String], User>
    ) {
        self.inMemory = inMemory
        self.validator = validator
        self.repository = repository
        self.transformer = transformer
    }

    // MARK: Interactor

    func handle(request: EventRequest) -> Observable<EventResponse> {
        switch request.action {
        case .userInfo:
            return handleUserInfo(from: request)
        case .tap:
            return handleTap()
        default: break
        }

        return Observable.never()
    }

    // MARK: Private

    private func handleUserInfo(from request: EventRequest) -> Observable<EventResponse> {
        guard let parameter = request.parameters else {
            return Observable.just(AppEventResponse(code: .badRequest, error: NoRequestParameterAppError()))
        }

        let validator = self.validator
        let transformer = self.transformer

        return inMemory
            .update(with: parameter)
            .map({ (parameter) -> EventResponse in
                var objectValidated = false

                if let _ = try? transformer.transform(object: parameter) {
                    objectValidated = true
                }

                if let error = validator.validate(object: request) {
                    return AppEventResponse(
                        code: .badRequest,
                        error: InvalidFormAppError(),
                        data: [
                            EventParameterKey.value: error,
                            EventParameterKey.objectValidated: objectValidated
                        ]
                    )
                }

                return AppEventResponse(code: .ok, data: [EventParameterKey.objectValidated: objectValidated])
            })
    }

    private func handleTap() -> Observable<EventResponse> {
        guard let user = try? transformer.transform(object: inMemory.value) else {
            return Observable.just(AppEventResponse(code: .badRequest, error: InvalidFormAppError()))
        }

        return repository
            .edit(with: EditUserParameter(name: user.name, surname: user.surname, age: user.age))
            .map({ (result) -> AppEventResponse in
                switch result {
                case .noContent:
                    throw ExpectsContentAppError()
                case .value(let user):
                    return AppEventResponse(code: .navigate, data: [EventParameterKey.value: user])
                }
            })
            .catchError { Observable.just(AppEventResponse(code: .badRequest, error: $0)) }
    }
}
