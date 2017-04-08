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
    private let viewType: AnyViewType<HomeViewModel>

    // MARK: Nested

    enum Action: AppAction {
        case viewDidLoad
    }

    // MARK: Initializer

    init(interactor: Interactor, presenter: AnyPresenter<HomeViewModel>, viewType: AnyViewType<HomeViewModel>) {
        self.interactor = interactor
        self.presenter = presenter
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

        let output = interactor
            .handle(request: AppEventRequest(_action: Action.viewDidLoad))
            .withLatestFrom(Observable.just(presenter)) { $0 }
            .map { $1.handle(response: $0) }
            .asDriver { (e) -> SharedSequence<DriverSharingStrategy, ViewState<HomeViewModel>> in
                return Driver.just(.loading)
            }

        viewType.update(with: output)
    }
}
