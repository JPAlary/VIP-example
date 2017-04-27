//
//  EditUserInteractor.swift
//  VIPExample
//
//  Created by Jean-Pierre Alary on 12/04/2017.
//  Copyright © 2017 Jp. All rights reserved.
//

import RxSwift

final class EditUserInteractor: EditUserViewControllerOutput, EditUserPresenterInput {
    private let disposeBag: DisposeBag
    private let responseVariable: Variable<EditUserCommand.Response>
    private var editUserParameter: EditUserParameter?
    private let repository: AnyRepository<User>
    private let logger: Logger
    private let router: AnyRouter<User>

    // MARK: Initializer

    init(
        repository: AnyRepository<User>,
        logger: Logger,
        router: AnyRouter<User>
    ) {
        self.repository = repository
        self.logger = logger
        self.router = router

        disposeBag = DisposeBag()
        responseVariable = Variable(EditUserCommand.Response.ok)
    }

    // MARK: EditUserViewControllerOutput

    func handle(request: EditUserCommand.Request) {
        logger.log(level: .warning, message: "Handling request: \(String(describing: request))")

        switch request {
        case .value(let name, let surname, let age):
            validate(value: (name: name, surname: surname, age: age))
        case .edit(let viewController):
            editUser(andRouteTo: viewController)
        }
    }

    // MARK: EditUserPresenterInput

    var response: Observable<EditUserCommand.Response> {
        return responseVariable.asObservable()
    }

    // MARK: Private

    struct EditUserFormValue {
        let name: String?
        let surname: String?
        let age: String?
    }

    private func validate(value: (name: String?, surname: String?, age: String?)) { // swiftlint:disable:this large_tuple
        /*
            Simple validation based on:
            - has value
            - has, at least, 1 character
         
            This validation should be more complex: have int value validation, limit character count, etc..
        */

        guard
            let name = value.name,
            let surname = value.surname,
            let age = value.age
        else {
            responseVariable.value = EditUserCommand.Response.error(InvalidFormAppError())

            return
        }

        var errors: [FormError] = []

        if name.characters.count == 0 {
            errors.append(FormError(path: "name", message: "edit_user.form.error.name"))
        }

        if surname.characters.count == 0 {
            errors.append(FormError(path: "surname", message: "edit_user.form.error.surname"))
        }

        if age.characters.count == 0 {
            errors.append(FormError(path: "age", message: "edit_user.form.error.age"))
        }

        if errors.count > 0 {
            responseVariable.value = EditUserCommand.Response.formError(FormErrorCollection(errors: errors))
        } else {
            editUserParameter = EditUserParameter(name: name, surname: surname, age: age)
            responseVariable.value = EditUserCommand.Response.ok
        }
    }

    private func editUser(andRouteTo viewController: UIViewController?) {
        guard let parameter = editUserParameter else {
            logger.log(level: .warning, message: "EditInteractor - No parameter in request.")
            responseVariable.value = EditUserCommand.Response.error(NoRequestParameterAppError())

            return
        }

        responseVariable.value = EditUserCommand.Response.loading

        let request = repository
            .edit(with: parameter)
            .share()

        request
            .subscribe { [weak self] (event) in
                if case .next(let result) = event {
                    if case .value(let user) = result {
                        self?.router.perform(route: Route(from: viewController, data: user))
                    }
                }
            }
            .disposed(by: disposeBag)

        request
            .map({ (result) -> EditUserCommand.Response in
                switch result {
                case .noContent:
                    throw ExpectsContentAppError()
                case .value(_):
                    return EditUserCommand.Response.ok
                }
            })
            .catchError { Observable.just(EditUserCommand.Response.error($0)) }
            .bindTo(responseVariable)
            .disposed(by: disposeBag)
    }
}
