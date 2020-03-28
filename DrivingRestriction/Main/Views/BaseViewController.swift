//
//  BaseViewController.swift
//  DrivingRestriction
//
//  Created by Daniel Vera on 3/28/20.
//  Copyright © 2020 zakumi. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

class BaseViewController: UIViewController {
  
  let disposeBag = DisposeBag()
  
  func addDissmissKeyboardGesture() {
    let dismissKeyBoardGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
    view.addGestureRecognizer(dismissKeyBoardGesture)
  }

  @objc func dismissKeyboard() {
    view.endEditing(true)
  }
  
}
