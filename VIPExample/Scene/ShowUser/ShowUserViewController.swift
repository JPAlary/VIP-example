//
//  ShowUserViewController.swift
//  VIPExample
//
//  Created by Jean-Pierre Alary on 06/04/2017.
//  Copyright © 2017 Jp. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

protocol ShowUserViewControllerOutput {
    func handle(request: ShowUserCommand.Request)
}

protocol ShowUserViewControllerInput: class {
    var viewModel: Driver<ShowUserViewModel> { get }
}

final class ShowUserViewController: UIViewController {
    private let disposeBag: DisposeBag
    private let showUserView: ShowUserView
    private let output: ShowUserViewControllerOutput
    private weak var input: ShowUserViewControllerInput?

    // MARK: Initializer

    init(
        output: ShowUserViewControllerOutput,
        input: ShowUserViewControllerInput
    ) {
        self.output = output
        self.input = input

        showUserView =  ShowUserView()
        disposeBag = DisposeBag()

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: View life cycle

    override func loadView() {
        super.loadView()

        view = showUserView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        output.handle(request: ShowUserCommand.Request.viewDidLoad)

        showUserView
            .event
            .map { [weak self] () -> ShowUserCommand.Request in
                return ShowUserCommand.Request.route(from: self)
            }
            .subscribe { [weak self] (event) in
                if case .next(let request) = event {
                    self?.output.handle(request: request)
                }
            }
            .disposed(by: disposeBag)

        showUserView.update(with: input?.viewModel)
    }
}
