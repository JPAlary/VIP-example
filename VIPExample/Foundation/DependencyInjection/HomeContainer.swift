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

    private func register() -> Void {
        container
            .register(AnyPresenter<HomeViewModel>.self) { (r) -> AnyPresenter<HomeViewModel> in
                AnyPresenter(base: HomePresenter(translator: r.resolve(Translator.self)!))
            }
            .inObjectScope(.container)

        container
            .register(AnyRepository<User>.self) { (r) -> AnyRepository<User> in
                AnyRepository(base: UserRepository(httpClient: r.resolve(HTTPClientType.self)!))
            }
            .inObjectScope(.container)

        container
            .register(Interactor.self) { (r) -> Interactor in
                HomeInteractor(
                    repository: r.resolve(AnyRepository<User>.self)!
                )
            }
            .inObjectScope(.container)

        container
            .register(AnyRouter<Void>.self) { (_) -> AnyRouter<Void> in
                AnyRouter(base: HomeRouter(container: EditContainer(container: self.getChild())))
            }
            .inObjectScope(.container)

        container
            .register(HomeViewController.self) { (r) -> HomeViewController in
                HomeViewController(
                    interactor: r.resolve(Interactor.self)!,
                    presenter: r.resolve(AnyPresenter<HomeViewModel>.self)!,
                    router: r.resolve(AnyRouter<Void>.self)!,
                    viewType: AnyViewType(base: HomeView())
                )
            }
            .inObjectScope(.container)
    }
}
