//
//  BindableType.swift
//  DrivingRestriction
//
//  Created by Daniel Vera on 3/27/20.
//  Copyright © 2020 zakumi. All rights reserved.
//

import Foundation
import UIKit

protocol BindableType: AnyObject {
  
  associatedtype ViewModelType
  
  var viewModel: ViewModelType! { get set }
  func bindViewModel()
  
}

extension BindableType where Self: UIViewController {
  func bind(to model: Self.ViewModelType) {
    viewModel = model
    loadViewIfNeeded()
    bindViewModel()
  }
}
