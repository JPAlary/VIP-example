//
//  EditUserViewController.swift
//  VIPExample
//
//  Created by Jean-Pierre Alary on 09/04/2017.
//  Copyright © 2017 Jp. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class EditUserViewController: UIViewController {
    private let disposeBag: DisposeBag
    private let viewType: AnyViewType<EditViewModel>
    private let interactor: Interactor
    private let router: AnyRouter<User>
    private let presenter: AnyPresenter<EditViewModel>

    // MARK: Initializer

    init(
        interactor: Interactor,
        presenter: AnyPresenter<EditViewModel>,
        router: AnyRouter<User>,
        viewType: AnyViewType<EditViewModel>
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

        let interactorResponse = viewType
            .request()
            .withLatestFrom(Observable.just(interactor)) { $0 }
            .flatMap { $1.handle(request: $0) }

        interactorResponse
            .filter { (response) -> Bool in
                if case .navigate = response.code {
                    return true
                } else {
                    return false
                }
            }
            .map({ (response) -> EventRequest in
                guard let user: User = response.dataValue() else {
                    fatalError("Should contains User object")
                }

                return EventRequest(data: [EventParameterKey.value: user], action: .navigate)
            })
            .withLatestFrom(Observable.just(router)) { $0 }
            .flatMap({ [weak self] (request, router) -> Observable<EventResponse> in
                return router.route(from: self, request: request)
            })
            .subscribe()
            .disposed(by: disposeBag)

        let provider = interactorResponse
            .filter { (response) -> Bool in
                if case .navigate = response.code {
                    return false
                } else {
                    return true
                }
            }
            .withLatestFrom(Observable.just(presenter)) { $0 }
            .map { $1.handle(response: $0) }
            .asDriver { (_) -> SharedSequence<DriverSharingStrategy, EditViewModel> in
                return Driver.never()
            }

        viewType.update(with: provider)
    }
}
