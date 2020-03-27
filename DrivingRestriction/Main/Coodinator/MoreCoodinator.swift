//
//  MoreCoodinator.swift
//  DrivingRestriction
//
//  Created by Daniel Vera on 3/25/20.
//  Copyright © 2020 zakumi. All rights reserved.
//

import Foundation
import XCoordinator

enum MoreListRoute: Route {
  case more
}

class MoreCoodinator: NavigationCoordinator<MoreListRoute> {
  
  init() {
    super.init(initialRoute: .more)
  }
  
  override func prepareTransition(for route: MoreListRoute) -> NavigationTransition {
    switch route {
    case .more:
      let viewController = MoreViewController()
      return .present(viewController)
    }
  }
  
}
