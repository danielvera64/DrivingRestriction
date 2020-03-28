//
//  Coordinator+Extension.swift
//  DrivingRestriction
//
//  Created by Daniel Vera on 3/28/20.
//  Copyright © 2020 zakumi. All rights reserved.
//

import Foundation
import UIKit
import XCoordinator

extension NavigationCoordinator {
  
  func getAlert(title: String, message: String, onAccept:@escaping AlertActionBody, onCancel:AlertActionBody?) -> UIAlertController {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "accept_title".localized, style: .default) { _ in
      onAccept()
    })
    if let onCancel = onCancel {
      alert.addAction(UIAlertAction(title: "cancel_title".localized, style: .default) { _ in
        onCancel()
      })
    }
    return alert
  }
  
}
