//
//  TextField.swift
//  DrivingRestriction
//
//  Created by Daniel Vera on 3/28/20.
//  Copyright © 2020 zakumi. All rights reserved.
//

import Foundation
import UIKit

class TextField: UITextField {
  
  private var filterEditActions: [ResponderStandardEditActions: Bool]?
  
  // MARK: filter edit actions
  private func filterEditActions(actions: [ResponderStandardEditActions], allowed: Bool) {
    if self.filterEditActions == nil { self.filterEditActions = [:] }
    actions.forEach { self.filterEditActions?[$0] = allowed }
  }
  
  func filterEditActions(notAllowed: [ResponderStandardEditActions]) {
    filterEditActions(actions: notAllowed, allowed: false)
  }
  
  open override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
    if let actions = filterEditActions {
      for _action in actions where _action.key.selector == action { return _action.value }
    }
    return super.canPerformAction(action, withSender: sender)
  }
  
}
