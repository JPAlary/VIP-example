//
//  HomeContainer.swift
//  VIPExample
//
//  Created by Jean-Pierre Alary on 06/04/2017.
//  Copyright © 2017 Jp. All rights reserved.
//

import Swinject

final class HomeContainer: AppContainer {
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
            .register(AnyPresenter<HomeViewModel>.self) { (resolver) -> AnyPresenter<HomeViewModel> in
                AnyPresenter(base: HomePresenter(
                    translator: resolver.resolve(Translator.self)!,
                    logger: resolver.resolve(Logger.self)!
                ))
            }
            .inObjectScope(.container)

        container
            .register(AnyRepository<User>.self) { (resolver) -> AnyRepository<User> in
                AnyRepository(base: UserRepository(httpClient: resolver.resolve(HTTPClientType.self)!))
            }
            .inObjectScope(.container)

        container
            .register(Interactor.self) { (resolver) -> Interactor in
                HomeInteractor(
                    repository: resolver.resolve(AnyRepository<User>.self)!,
                    logger: resolver.resolve(Logger.self)!
                )
            }
            .inObjectScope(.container)

        container
            .register(AnyRouter<Void>.self) { (_) -> AnyRouter<Void> in
                AnyRouter(base: HomeRouter(container: EditContainer(container: self.getChild())))
            }
            .inObjectScope(.container)

        container
            .register(HomeViewController.self) { (resolver) -> HomeViewController in
                HomeViewController(
                    interactor: resolver.resolve(Interactor.self)!,
                    presenter: resolver.resolve(AnyPresenter<HomeViewModel>.self)!,
                    router: resolver.resolve(AnyRouter<Void>.self)!,
                    viewType: AnyViewType(base: HomeView())
                )
            }
            .inObjectScope(.container)
    }
}
