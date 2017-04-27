//
//  EditUserView.swift
//  VIPExample
//
//  Created by Jean-Pierre Alary on 12/04/2017.
//  Copyright © 2017 Jp. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

final class EditUserView: UIView {
    private let disposeBag: DisposeBag
    private let nameTextfield: UITextField
    private let surnameTextfield: UITextField
    private let ageTextfield: UITextField
    private let button: UIButton

    // MARK: Initializer

    init() {
        disposeBag = DisposeBag()
        nameTextfield = UITextField()
        surnameTextfield = UITextField()
        ageTextfield = UITextField()
        button = UIButton()

        super.init(frame: CGRect.zero)

        backgroundColor = .white
        setUpSubviews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Public

    var event: Observable<EditUserCommand.Request> {
        let tap: Observable<EditUserCommand.Request> = button
            .rx
            .tap
            .asObservable()
            .map { EditUserCommand.Request.edit(nil) }

        let textfields: Observable<EditUserCommand.Request> = Observable
            .combineLatest(nameTextfield.rx.text, surnameTextfield.rx.text, ageTextfield.rx.text) { name, surname, age in
                return EditUserCommand.Request.value(name: name, surname: surname, age: age)
            }

        return Observable
            .of(tap, textfields)
            .merge()
    }

    func update(with provider: Driver<EditUserViewModel>?) {
        provider?
            .map { $0.namePlaceholder }
            .drive(nameTextfield.rx.placeholder)
            .disposed(by: disposeBag)

        provider?
            .map { $0.surnamePlaceholder }
            .drive(surnameTextfield.rx.placeholder)
            .disposed(by: disposeBag)

        provider?
            .map { $0.agePlaceholder }
            .drive(ageTextfield.rx.placeholder)
            .disposed(by: disposeBag)

        provider?
            .map { $0.buttonTitle }
            .drive(button.rx.title())
            .disposed(by: disposeBag)

        provider?
            .map { $0.buttonEnabled }
            .drive(button.rx.isEnabled)
            .disposed(by: disposeBag)

        provider?
            .map { nil != $0.errorNameFieldMessage }
            .drive(nameTextfield.rx.errorState)
            .disposed(by: disposeBag)

        provider?
            .map { nil != $0.errorSurnameFieldMessage }
            .drive(surnameTextfield.rx.errorState)
            .disposed(by: disposeBag)

        provider?
            .map { nil != $0.errorAgeFieldMessage }
            .drive(ageTextfield.rx.errorState)
            .disposed(by: disposeBag)
    }

    // MARK: Private

    private func setUpSubviews() {
        [nameTextfield, surnameTextfield, ageTextfield].forEach { (textfield) in
            textfield.borderStyle = .none
            textfield.placeholder = ""
            textfield.layer.cornerRadius = 5.0

            addSubview(textfield)
        }

        button.backgroundColor = UIColor.blue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 5.0
        addSubview(button)

        nameTextfield.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(50.0)
            make.left.equalToSuperview().offset(20.0)
            make.right.equalToSuperview().offset(-20.0)
            make.height.equalTo(30.0)
        }
        surnameTextfield.snp.makeConstraints { (make) in
            make.top.equalTo(nameTextfield.snp.bottom).offset(20.0)
            make.left.equalToSuperview().offset(20.0)
            make.right.equalToSuperview().offset(-20.0)
            make.height.equalTo(30.0)
        }
        ageTextfield.snp.makeConstraints { (make) in
            make.top.equalTo(surnameTextfield.snp.bottom).offset(20.0)
            make.left.equalToSuperview().offset(20.0)
            make.right.equalToSuperview().offset(-20.0)
            make.height.equalTo(30.0)
        }
        button.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(20.0)
            make.right.equalToSuperview().offset(-20.0)
            make.bottom.equalToSuperview().offset(-20.0)
            make.height.equalTo(50.0)
        }
    }
}
