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

    private func register() {
        container
            .register(AnyPresenter<EditViewModel>.self) { (resolver) -> AnyPresenter<EditViewModel> in
                AnyPresenter(base: EditPresenter(translator: resolver.resolve(Translator.self)!))
            }
            .inObjectScope(.container)

        container
            .register(AnyRepository<User>.self) { (resolver) -> AnyRepository<User> in
                AnyRepository(base: UserRepository(httpClient: resolver.resolve(HTTPClientType.self)!))
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
            .register(Interactor.self) { (resolver) -> Interactor in
                EditInteractor(
                    inMemory: InMemory(defaultValue: [String: String]()),
                    validator: resolver.resolve(AnyValidator<EventRequest, FormErrorCollection>.self)!,
                    repository: resolver.resolve(AnyRepository<User>.self)!,
                    transformer: AnyTransformer(base: DictionaryToUserTransformer()),
                    logger: resolver.resolve(Logger.self)!
                )
            }
            .inObjectScope(.container)

        container
            .register(AnyRouter<User>.self) { (_) -> AnyRouter<User> in
                AnyRouter(base: EditRouter())
            }
            .inObjectScope(.container)

        container
            .register(EditUserViewController.self) { (resolver) -> EditUserViewController in
                EditUserViewController(
                    interactor: resolver.resolve(Interactor.self)!,
                    presenter: resolver.resolve(AnyPresenter<EditViewModel>.self)!,
                    router: resolver.resolve(AnyRouter<User>.self)!,
                    viewType: AnyViewType(base: EditView())
                )
            }
            .inObjectScope(.container)
    }
}
