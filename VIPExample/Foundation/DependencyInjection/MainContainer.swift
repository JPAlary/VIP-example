//
//  MainContainer.swift
//  VIPExample
//
//  Created by Jean-Pierre Alary on 09/04/2017.
//  Copyright © 2017 Jp. All rights reserved.
//

import Swinject

final class MainContainer: AppContainer {
    private let container: Container

    // MARK: Initializer

    init() {
        container = Container()

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
            .register(NetworkActivity.self) { (_) -> NetworkActivity in
                UIApplicationNetworkActivity(application: UIApplication.shared)
            }
            .inObjectScope(.container)

        container
            .register(Translator.self) { (_) -> Translator in
                NSLocalizedStringTranslator()
            }
            .inObjectScope(.container)

        container
            .register(Logger.self) { (_) -> Logger in
                AppLogger()
            }
            .inObjectScope(.container)

        container
            .register(NetworkAdapter.self) { (resolver) -> NetworkAdapter in
                URLSessionNetworkAdapter(
                    networkActivity: resolver.resolve(NetworkActivity.self)!,
                    session: URLSession(configuration: .ephemeral)
                )
            }
            .inObjectScope(.container)

        container
            .register(InterceptorChain<URLRequest>.self) { (resolver) -> InterceptorChain<URLRequest> in
                InterceptorChain<URLRequest>()
                    .add(interceptor: AnyInterceptor(base: LoggerInterceptor(logger: resolver.resolve(Logger.self)!)))
            }
            .inObjectScope(.container)

        container
            .register(HTTPClientType.self) { (resolver) -> HTTPClientType in
                AppHTTPClientType(
                    transformer: AnyTransformer(base: EndpointToURLRequestTransformer()),
                    networkAdapter: resolver.resolve(NetworkAdapter.self)!,
                    requestChain: resolver.resolve(InterceptorChain<URLRequest>.self)!,
                    responseChain: InterceptorChain<Response>(),
                    httpErrorHandler: AppHTTPErrorHandler()
                )
            }
            .inObjectScope(.container)
    }
}
