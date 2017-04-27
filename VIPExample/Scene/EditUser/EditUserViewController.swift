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

protocol EditUserViewControllerOutput {
    func handle(request: EditUserCommand.Request)
}

protocol EditUserViewControllerInput: class {
    var viewModel: Driver<EditUserViewModel> { get }
}

final class EditUserViewController: UIViewController {
    private let disposeBag: DisposeBag
    private let editUserView: EditUserView
    private let output: EditUserViewControllerOutput
    private weak var input: EditUserViewControllerInput?

    // MARK: Initializer

    init(
        output: EditUserViewControllerOutput,
        input: EditUserViewControllerInput
    ) {
        self.output = output
        self.input = input

        disposeBag = DisposeBag()
        editUserView = EditUserView()

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: View life cycle

    override func loadView() {
        super.loadView()

        view = editUserView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        editUserView
            .event
            .map({ [weak self] (request) -> EditUserCommand.Request in
                if case .edit = request {
                    return EditUserCommand.Request.edit(self)
                }

                return request
            })
            .subscribe { [weak self] (event) in
                if case .next(let request) = event {
                    self?.output.handle(request: request)
                }
            }
            .disposed(by: disposeBag)

        editUserView.update(with: input?.viewModel)
    }
}
