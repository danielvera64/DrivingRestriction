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
}

class HomeCoordinator: NavigationCoordinator<HomeListRoute> {
  
  init() {
    super.init(initialRoute: .home)
  }
  
  override func prepareTransition(for route: HomeListRoute) -> NavigationTransition {
    switch route {
    case .home:
      let viewController = HomeViewController()
      return .present(viewController)
    }
  }
  
}
