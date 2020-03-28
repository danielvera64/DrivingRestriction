//
//  RestrictionEditorViewModel.swift
//  DrivingRestriction
//
//  Created by Daniel Vera on 3/27/20.
//  Copyright © 2020 zakumi. All rights reserved.
//

import Foundation
import RxSwift
import RxRealm
import XCoordinator

class RestrictionEditorViewModel {
  
  let router: UnownedRouter<MoreListRoute>
  
  let currentRestrictions = BehaviorSubject<[[RestrictionSchedule]]>(value: [])
  
  private let dataManager = RealmDataManager()
  private let disposeBag = DisposeBag()
  
  init(router: UnownedRouter<MoreListRoute>) {
    self.router = router
    dataManager
      .getObservable(type: RestrictionSchedule.self)
      .map { Dictionary(grouping: $0) { $0.weekday }.map { $0.value } }
      .bind(to: currentRestrictions)
      .disposed(by: disposeBag)
  }
  
}
