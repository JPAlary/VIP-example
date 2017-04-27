//
//  ShowUserView.swift
//  VIPExample
//
//  Created by Jean-Pierre Alary on 08/04/2017.
//  Copyright © 2017 Jp. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

final class ShowUserView: UIView {
    private let disposeBag = DisposeBag()
    private let nameLabel: UILabel
    private let surnameLabel: UILabel
    private let ageLabel: UILabel
    private let button: UIButton
    private let activityIndicator: UIActivityIndicatorView

    // MARK: Initializer

    init() {
        nameLabel = UILabel()
        surnameLabel = UILabel()
        ageLabel = UILabel()
        button = UIButton()
        activityIndicator = UIActivityIndicatorView()

        super.init(frame: CGRect.zero)

        backgroundColor = .white

        setUpSubviews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Public

    var event: Observable<Void> {
        return button
            .rx
            .tap
            .asObservable()
            .share()
    }

    func update(with provider: Driver<ShowUserViewModel>?) {
        provider?
            .map { (viewModel) -> Bool in
                if case .loading = viewModel.state {
                    return true
                } else {
                    return false
                }
            }
            .drive(activityIndicator.rx.isAnimating)
            .disposed(by: disposeBag)

        provider?
            .drive(onNext: { (viewModel) in
                switch viewModel.state {
                case .error(let message):
                    print("You should display a nice view and put \(message)")
                default:
                    break
                }
            })
            .disposed(by: disposeBag)

        provider?
            .map { $0.name }
            .drive(nameLabel.rx.text)
            .disposed(by: disposeBag)

        provider?
            .map { $0.surname }
            .drive(surnameLabel.rx.text)
            .disposed(by: disposeBag)

        provider?
            .map { $0.age }
            .drive(ageLabel.rx.text)
            .disposed(by: disposeBag)

        provider?
            .map { $0.buttonTitle }
            .drive(button.rx.title())
            .disposed(by: disposeBag)
    }

    // MARK: Private

    private func setUpSubviews() {
        [nameLabel, surnameLabel, ageLabel].forEach { (label) in
            label.textColor = .black
            label.textAlignment = .center
            label.font = UIFont.systemFont(ofSize: 20.0)
            label.numberOfLines = 0
            label.lineBreakMode = .byWordWrapping

            addSubview(label)
        }
        activityIndicator.activityIndicatorViewStyle = .gray
        activityIndicator.hidesWhenStopped = true
        addSubview(activityIndicator)

        button.backgroundColor = UIColor.blue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 5.0
        addSubview(button)

        activityIndicator.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }

        nameLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(60.0)
            make.left.equalToSuperview().offset(20.0)
            make.right.equalToSuperview().offset(-20.0)
        }

        surnameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(nameLabel.snp.bottom).offset(20.0)
            make.left.equalToSuperview().offset(20.0)
            make.right.equalToSuperview().offset(-20.0)
        }

        ageLabel.snp.makeConstraints { (make) in
            make.top.equalTo(surnameLabel.snp.bottom).offset(20.0)
            make.left.equalToSuperview().offset(20.0)
            make.right.equalToSuperview().offset(-20.0)
        }

        button.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(20.0)
            make.right.equalToSuperview().offset(-20.0)
            make.bottom.equalToSuperview().offset(-20.0)
            make.height.equalTo(50.0)
        }
    }
}
