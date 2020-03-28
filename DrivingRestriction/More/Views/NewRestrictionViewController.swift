//
//  NewRestrictionViewController.swift
//  DrivingRestriction
//
//  Created by Daniel Vera on 3/28/20.
//  Copyright © 2020 zakumi. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import SnapKit
import Action

class NewRestrictionViewController: UIViewController, BindableType {
  
  var viewModel: NewRestrictionViewModel!
  
  private let disposeBag = DisposeBag()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    addDissmissKeyboardGesture()
    setUpViews()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    navigationItem.title = "new_restriction_title".localized
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    navigationItem.title = ""
  }
  
  func addDissmissKeyboardGesture() {
    let dismissKeyBoardGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
    view.addGestureRecognizer(dismissKeyBoardGesture)
  }

  @objc func dismissKeyboard() {
    view.endEditing(true)
  }
  
  func bindViewModel() {}
  
  private func setUpViews() {
    view.backgroundColor = .white
    
    let lastDigitTextField = CustomTextField(title: "last_digits_title".localized,
      placeholder: "1, 2, 3".localized, type: .lastDigit)
    
    let weekdaysPicker = CustomTextField(title: "weekday_title".localized,
                                         placeholder: "pick_weekday_title".localized,
                                         type: .weekdays,
                                         dataSource: viewModel.weekdaysSubject,
                                         selectionTrigger: viewModel.rowSelected.asObserver())
    
    let canUseTitle = UILabel()
    canUseTitle.font = .boldSystemFont(ofSize: 16)
    canUseTitle.numberOfLines = 1
    canUseTitle.setContentCompressionResistancePriority(.required, for: .horizontal)
    canUseTitle.text = "\("can_use_vehicle_title".localized):"
    
    let canUseSwitch = UISwitch()
    
    let canUseStackView = UIStackView()
    canUseStackView.axis = .horizontal
    canUseStackView.spacing = 5
    canUseStackView.addArrangedSubview(canUseTitle)
    canUseStackView.addArrangedSubview(canUseSwitch)
    
    let scheduleTitle = UILabel()
    scheduleTitle.font = .boldSystemFont(ofSize: 16)
    scheduleTitle.numberOfLines = 1
    scheduleTitle.setContentCompressionResistancePriority(.required, for: .horizontal)
    scheduleTitle.text = "\("schedule_title".localized):"
    
    let addScheduleButton = UIButton(type: .roundedRect)
    addScheduleButton.layer.borderColor = UIColor.black.cgColor
    addScheduleButton.layer.borderWidth = 1
    addScheduleButton.layer.cornerRadius = 10
    addScheduleButton.setTitle("add_schedule".localized, for: .normal)
    addScheduleButton.snp.makeConstraints { $0.width.equalTo(120) }
    
    let scheduleStackView = UIStackView()
    scheduleStackView.axis = .horizontal
    scheduleStackView.spacing = 5
    scheduleStackView.addArrangedSubview(scheduleTitle)
    scheduleStackView.addArrangedSubview(addScheduleButton)
    
    let scheduleTableView = UITableView()
    scheduleTableView.tableFooterView = UIView()
    
    let stackView = UIStackView()
    stackView.axis = .vertical
    stackView.spacing = 15
    stackView.addArrangedSubview(lastDigitTextField)
    stackView.addArrangedSubview(weekdaysPicker)
    stackView.addArrangedSubview(canUseStackView)
    stackView.addArrangedSubview(scheduleStackView)
    stackView.addArrangedSubview(scheduleTableView)
    
    view.addSubview(stackView)
    stackView.snp.makeConstraints {
      $0.edges.equalTo(view.safeAreaLayoutGuide)
        .inset(UIEdgeInsets(top: 15, left: 10, bottom: 0, right: 10))
    }
  }
  
}
