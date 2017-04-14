//
//  HomeViewController.swift
//  VIPExample
//
//  Created by Jean-Pierre Alary on 06/04/2017.
//  Copyright © 2017 Jp. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class HomeViewController: UIViewController {
    private let disposeBag: DisposeBag
    private let interactor: Interactor
    private let presenter: AnyPresenter<HomeViewModel>
    private let router: AnyRouter<Void>
    private let viewType: AnyViewType<HomeViewModel>

    // MARK: Initializer

    init(
        interactor: Interactor,
        presenter: AnyPresenter<HomeViewModel>,
        router: AnyRouter<Void>,
        viewType: AnyViewType<HomeViewModel>
    ) {
        self.interactor = interactor
        self.presenter = presenter
        self.router = router
        self.viewType = viewType

        disposeBag = DisposeBag()

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: View life cycle

    override func loadView() {
        super.loadView()

        view = viewType.view
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let routerResult = viewType
            .request()
            .map { _ in EventRequest(action: .navigate) }
            .withLatestFrom(Observable.just(router)) { $0 }
            .flatMap({ (request, router) -> Observable<EventResponse> in
                return router.route(from: self, request: request)
            })
            .withLatestFrom(Observable.just(presenter)) { $0 }
            .map { $1.handle(response: $0) }

        let output = interactor
            .handle(request: EventRequest(action: .viewDidLoad))
            .withLatestFrom(Observable.just(presenter)) { $0 }
            .map { $1.handle(response: $0) }

        let provider = Observable
            .of(routerResult, output)
            .merge()
            .asDriver { (_) -> SharedSequence<DriverSharingStrategy, HomeViewModel> in
                return Driver.never()
            }

        viewType.update(with: provider)
    }
}
