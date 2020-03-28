//
//  HomeViewController.swift
//  DrivingRestriction
//
//  Created by Daniel Vera on 3/25/20.
//  Copyright © 2020 zakumi. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import RxSwift

class HomeViewController: BaseViewController, BindableType {
  
  var viewModel: HomeViewModel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    addDissmissKeyboardGesture()
    setUpViews()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    self.navigationController?.isNavigationBarHidden = true
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    self.navigationController?.isNavigationBarHidden = false
  }
  
  func bindViewModel() {}
  
  private func setUpViews() {
    view.backgroundColor = .white
    
    let titleLabel = UILabel()
    titleLabel.font = .boldSystemFont(ofSize: 20)
    titleLabel.textAlignment = .center
    titleLabel.numberOfLines = 0
    titleLabel.setContentCompressionResistancePriority(.required, for: .vertical)
    titleLabel.setContentHuggingPriority(.required, for: .vertical)
    titleLabel.text = "put_plate_number_title" .localized
    
    let plateTextField = CustomTextField(title: "\("plate_number".localized):",
      placeholder: "PTH0226".localized, type: .plateNumber)
    plateTextField.currentText
      .bind(to: viewModel.plateNumberSubject)
      .disposed(by: disposeBag)
    
    let datePicker = UIDatePicker()
    datePicker.datePickerMode = .dateAndTime
    datePicker.rx.date
      .bind(to: viewModel.dateSelectedSubject)
      .disposed(by: disposeBag)
    
    let checkButton = UIButton(type: .roundedRect)
    checkButton.layer.borderColor = UIColor.black.cgColor
    checkButton.layer.borderWidth = 1
    checkButton.layer.cornerRadius = 10
    checkButton.setTitle("check_plate_number".localized, for: .normal)
    checkButton.snp.makeConstraints { $0.height.equalTo(50) }
    checkButton.rx.tap
      .withLatestFrom(viewModel.formObservable)
      .bind(to: viewModel.checkAction.inputs)
      .disposed(by: disposeBag)
    
    let stackView = UIStackView()
    stackView.axis = .vertical
    stackView.spacing = 15
    stackView.addArrangedSubview(titleLabel)
    stackView.addArrangedSubview(plateTextField)
    stackView.addArrangedSubview(datePicker)
    stackView.addArrangedSubview(checkButton)
    
    view.addSubview(stackView)
    stackView.snp.makeConstraints {
      $0.leading.trailing
        .equalTo(view.safeAreaLayoutGuide)
        .inset(UIEdgeInsets(top: 100, left: 15, bottom: 0, right: 15))
      $0.centerY.equalToSuperview()
    }
  }
  
}
