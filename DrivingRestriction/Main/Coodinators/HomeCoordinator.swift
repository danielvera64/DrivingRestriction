//
//  HomeCoordinator.swift
//  DrivingRestriction
//
//  Created by Daniel Vera on 3/25/20.
//  Copyright © 2020 zakumi. All rights reserved.
//

import Foundation
import XCoordinator

enum HomeListRoute: Route {
  case home
  case alert(title:String, message:String, onAccept:AlertActionBody, onCancel:AlertActionBody?)
}

class HomeCoordinator: NavigationCoordinator<HomeListRoute> {
  
  init() {
    super.init(initialRoute: .home)
  }
  
  override func prepareTransition(for route: HomeListRoute) -> NavigationTransition {
    switch route {
      
    case .home:
      let viewController = HomeViewController()
      viewController.bind(to: HomeViewModel(router: unownedRouter))
      return .push(viewController)
    
    case .alert(let title, let message, let onAccept, let onCancel):
      return .present(getAlert(title: title, message: message, onAccept: onAccept, onCancel: onCancel))
    }
  }
  
}
