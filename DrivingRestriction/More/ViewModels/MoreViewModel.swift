//
//  MoreViewModel.swift
//  DrivingRestriction
//
//  Created by Daniel Vera on 3/27/20.
//  Copyright © 2020 zakumi. All rights reserved.
//

import Foundation
import XCoordinator
import XCoordinatorRx
import RxSwift
import RxDataSources
import Action

struct MenuOption {
  var title: String
  var route: MoreListRoute
}

class MoreViewModel {
  
  let router: UnownedRouter<MoreListRoute>
  
  let optionsSubject = BehaviorSubject<[MenuOption]>(value: [])
  
  lazy var menuOptionSelected = Action<MoreListRoute,Void>() { [unowned self] option in
    return self.router.rx.trigger(option)
  }
  
  init(router: UnownedRouter<MoreListRoute>) {
    self.router = router
    optionsSubject.onNext([MenuOption(title: "current_driving_restrictions".localized, route: .editRestrictions)])
  }
  
}
