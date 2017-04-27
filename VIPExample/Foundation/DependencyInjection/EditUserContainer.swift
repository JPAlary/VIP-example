//
//  EditUserContainer.swift
//  VIPExample
//
//  Created by Jean-Pierre Alary on 13/04/2017.
//  Copyright © 2017 Jp. All rights reserved.
//

import Swinject

final class EditUserContainer: AppContainer {
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
            .register(AnyRepository<User>.self) { (resolver) -> AnyRepository<User> in
                AnyRepository(base: UserRepository(httpClient: resolver.resolve(HTTPClientType.self)!))
            }
            .inObjectScope(.container)

        container
            .register(AnyRouter<User>.self) { (_) -> AnyRouter<User> in
                AnyRouter(base: EditRouter())
            }
            .inObjectScope(.container)

        container
            .register(EditUserInteractor.self) { (resolver) -> EditUserInteractor in
                EditUserInteractor(
                    repository: resolver.resolve(AnyRepository<User>.self)!,
                    logger: resolver.resolve(Logger.self)!,
                    router: resolver.resolve(AnyRouter<User>.self)!
                )
            }
            .inObjectScope(.container)

        container
            .register(EditUserViewControllerInput.self) { (resolver) -> EditUserViewControllerInput in
                EditUserPresenter(
                    translator: resolver.resolve(Translator.self)!,
                    input: resolver.resolve(EditUserInteractor.self)!
                )
            }
            .inObjectScope(.container)

        container
            .register(UIViewController.self) { (resolver) -> UIViewController in
                EditUserViewController(
                    output: resolver.resolve(EditUserInteractor.self)!,
                    input: resolver.resolve(EditUserViewControllerInput.self)!
                )
            }
            .inObjectScope(.container)
    }
}
