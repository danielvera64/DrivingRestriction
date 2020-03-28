//
//  CustomTextField.swift
//  DrivingRestriction
//
//  Created by Daniel Vera on 3/28/20.
//  Copyright © 2020 zakumi. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import RxSwift

class CustomTextField: UIView {
  
  private let textField = TextField()
  
  private var currentType: TextFieldType = .lastDigit
  private var filterEditActions: [ResponderStandardEditActions: Bool]?
  private lazy var plateNumberCharacterSet = CharacterSet.letters.union(CharacterSet.decimalDigits)
  
  private let disposeBag = DisposeBag()
  
  let currentText = PublishSubject<String?>()
  let currentDigitsSubject = BehaviorSubject<[Int]>(value: [])
  
  init(title: String,
       placeholder: String = "",
       type: TextFieldType,
       dataSource: BehaviorSubject<[String]>? = nil,
       selectionTrigger: AnyObserver<(row: Int, component: Int)>? = nil)
  {
    super.init(frame: .zero)
    currentType = type
    commonInit(title: title, placeholder: placeholder, type: type)
    if type == .weekdays, let dataSource = dataSource, let trigger = selectionTrigger {
      configWeekdaysPicker(dataSource: dataSource, selectionTrigger: trigger)
    }
    bindTextField()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }
  
  private func commonInit(title: String, placeholder: String, type: TextFieldType) {
    backgroundColor = .clear
    
    let lastTitle = UILabel()
    lastTitle.font = .boldSystemFont(ofSize: 16)
    lastTitle.numberOfLines = 1
    lastTitle.setContentCompressionResistancePriority(.required, for: .horizontal)
    lastTitle.setContentCompressionResistancePriority(.required, for: .vertical)
    lastTitle.setContentHuggingPriority(.required, for: .horizontal)
    lastTitle.text = title
    
    textField.delegate = self
    textField.placeholder = placeholder
    textField.keyboardType = getKeyboardTypeOf(type: type)
    textField.borderStyle = .roundedRect
    
    let stackView = UIStackView()
    stackView.axis = .vertical
    stackView.spacing = 4
    stackView.addArrangedSubview(lastTitle)
    stackView.addArrangedSubview(textField)
    
    addSubview(stackView)
    stackView.snp.makeConstraints {
      $0.edges.equalToSuperview().inset(UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0))
    }
  }
  
  private func getKeyboardTypeOf(type: TextFieldType) -> UIKeyboardType {
    switch type {
    case .lastDigit:
      return .numberPad
    case .weekdays, .plateNumber:
      return .default
    }
  }
  
  private func configWeekdaysPicker(dataSource: BehaviorSubject<[String]>,
                                    selectionTrigger: AnyObserver<(row: Int, component: Int)>)
  {
    let picker = UIPickerView()
    textField.inputView = picker
    textField.filterEditActions(notAllowed: [.paste, .copy, .select, .selectAll, .cut])
    
    dataSource
      .bind(to: picker.rx.itemTitles) { _, element in return element.localizedCapitalized }
      .disposed(by: disposeBag)
    
    picker.rx.itemSelected
      .bind(to: selectionTrigger)
      .disposed(by: disposeBag)
    
    Observable
    .combineLatest(dataSource, picker.rx.itemSelected)
    .map { catalog, selected -> String? in
      guard selected.row < catalog.count else { return nil }
      return catalog[selected.row].localizedCapitalized
    }
    .bind(to: textField.rx.text)
    .disposed(by: disposeBag)
  }
  
  private func bindTextField() {
    textField.rx.text
      .bind(to: currentText)
      .disposed(by: disposeBag)
    
    if currentType == .lastDigit {
      currentDigitsSubject
        .map { digits in digits.sorted(by: { $0 < $1 }).map { "\($0)" }.joined(separator: ", ") }
        .bind(to: textField.rx.text)
        .disposed(by: disposeBag)
    }
  }
  
  private func backSpacePressed(string: String) -> Bool {
    if let char = string.cString(using: String.Encoding.utf8) {
        let isBackSpace = strcmp(char, "\\b")
        if (isBackSpace == -92) {
            return true
        }
    }
    return false
  }
  
}

extension CustomTextField: UITextFieldDelegate {
  
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    switch currentType {
      
    case .lastDigit:
      if backSpacePressed(string: string) {
        currentDigitsSubject.onNext([])
        return false
      }
      guard
        string.containsNumbers, string.count == 1,
        let digit = Int(string),
        var digits = try? currentDigitsSubject.value() else
      {
        return false
      }
      digits.append(digit)
      currentDigitsSubject.onNext(Array(Set(digits)))
      return false
      
    case .plateNumber:
      if string.count == 0, range.length > 0 { return true } //delete pressed
      return string.count == string.components(separatedBy: plateNumberCharacterSet.inverted).count
      
    case .weekdays:
      return string.count > 1
    }
  }
}
