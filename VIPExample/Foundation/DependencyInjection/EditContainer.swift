//
//  EditContainer.swift
//  VIPExample
//
//  Created by Jean-Pierre Alary on 13/04/2017.
//  Copyright © 2017 Jp. All rights reserved.
//

import Swinject

final class EditContainer: AppContainer {
    private let container: Container

    // MARK: Initializer

    init(container: Container) {
        self.container = container

        register()
    }

    // MARK: AppContainer

    func getChild() -> Container {
        return Container(parent: container)
    }

    func resolve<Service>(serviceType: Service.Type) -> Service? {
        return container.resolve(serviceType)
    }

    func resolve<Service>(serviceType: Service.Type, name: String) -> Service? {
        return container.resolve(serviceType, name: name)
    }

    // MARK: Private

    private func register() -> Void {
        container
            .register(AnyPresenter<EditViewModel>.self) { (r) -> AnyPresenter<EditViewModel> in
                AnyPresenter(base: EditPresenter(translator: r.resolve(Translator.self)!))
            }
            .inObjectScope(.container)

        container
            .register(AnyRepository<User>.self) { (r) -> AnyRepository<User> in
                AnyRepository(base: UserRepository(httpClient: r.resolve(HTTPClientType.self)!))
            }
            .inObjectScope(.container)

        container
            .register(AnyValidator<EventRequest, FormErrorCollection>.self) { (_) -> AnyValidator<EventRequest, FormErrorCollection> in
                AnyValidator(base: EditFormValidator(
                    countLimitValidator: AnyValidator(base: TextfieldValueValidator()),
                    intValidator: AnyValidator(base: IntValueValidator())
                ))
            }
            .inObjectScope(.container)

        container
            .register(Interactor.self) { (r) -> Interactor in
                EditInteractor(
                    inMemory: InMemory(defaultValue: [String: String]()),
                    validator: r.resolve(AnyValidator<EventRequest, FormErrorCollection>.self)!,
                    repository: r.resolve(AnyRepository<User>.self)!,
                    transformer: AnyTransformer(base: DictionaryToUserTransformer())
                )
            }
            .inObjectScope(.container)

        container
            .register(AnyRouter<User>.self) { (r) -> AnyRouter<User> in
                AnyRouter(base: EditRouter())
            }
            .inObjectScope(.container)

        container
            .register(EditUserViewController.self) { (r) -> EditUserViewController in
                EditUserViewController(
                    interactor: r.resolve(Interactor.self)!,
                    presenter: r.resolve(AnyPresenter<EditViewModel>.self)!,
                    router: r.resolve(AnyRouter<User>.self)!,
                    viewType: AnyViewType(base: EditView())
                )
            }
            .inObjectScope(.container)
    }
}
