//
//  RestrictionEditorViewModel.swift
//  DrivingRestriction
//
//  Created by Daniel Vera on 3/27/20.
//  Copyright © 2020 zakumi. All rights reserved.
//

import Foundation
import XCoordinator

class RestrictionEditorViewModel {
  
  let router: UnownedRouter<MoreListRoute>
  
  init(router: UnownedRouter<MoreListRoute>) {
    self.router = router
  }
  
}
