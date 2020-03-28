//
//  MoreCoodinator.swift
//  DrivingRestriction
//
//  Created by Daniel Vera on 3/25/20.
//  Copyright © 2020 zakumi. All rights reserved.
//

import Foundation
import UIKit
import XCoordinator

typealias AlertActionBody = () -> Void

enum MoreListRoute: Route {
  case more
  case editRestrictions
  case newRestriction
  case alert(title:String, message:String, onAccept:AlertActionBody, onCancel:AlertActionBody?)
}

class MoreCoodinator: NavigationCoordinator<MoreListRoute> {
  
  init() {
    super.init(initialRoute: .more)
  }
  
  override func prepareTransition(for route: MoreListRoute) -> NavigationTransition {
    switch route {
      
    case .more:
      let viewController = MoreViewController()
      viewController.bind(to: MoreViewModel(router: unownedRouter))
      return .push(viewController)
      
    case .editRestrictions:
      let vc = RestrictionEditorViewController()
      vc.bind(to: RestrictionEditorViewModel(router: unownedRouter))
      return .push(vc)
      
    case .newRestriction:
      let vc = NewRestrictionViewController()
      vc.bind(to: NewRestrictionViewModel(router: unownedRouter))
      return .push(vc)
      
    case let .alert(title, message, onAccept, onCancel):
      let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
      alert.addAction(UIAlertAction(title: "accept_title".localized, style: .default) { _ in
        onAccept()
      })
      if let onCancel = onCancel {
        alert.addAction(UIAlertAction(title: "cancel_title".localized, style: .cancel) { _ in
          onCancel()
        })
      }
      return .present(alert)
    }
  }
  
}
