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
import XCoordinatorRx
import Action

class RestrictionEditorViewModel {
  
  let router: UnownedRouter<MoreListRoute>
  
  let currentRestrictions = BehaviorSubject<[[RestrictionSchedule]]>(value: [])
  
  lazy var addNewAction = CocoaAction { [unowned self] _ in
    return self.router.rx.trigger(.newRestriction)
  }
  
  lazy var deleteAllAction = CocoaAction { [unowned self] _ in
    return self.router.rx.trigger(.alert(title: "".localized,
                                         message: "delete_all_confirmation".localized,
                                         onAccept: { try? self.dataManager.clearTable(type: RestrictionSchedule.self)},
                                         onCancel: {}))
  }
  
  private let dataManager = RealmDataManager()
  private let disposeBag = DisposeBag()
  
  init(router: UnownedRouter<MoreListRoute>) {
    self.router = router
    dataManager
      .getObservable(type: RestrictionSchedule.self)
      .map { Dictionary(grouping: $0) { $0.weekday }.map { $0.value } }
      .map { $0.sorted(by: { ($0.first?.weekday ?? 0) < ($1.first?.weekday ?? 0) })}
      .bind(to: currentRestrictions)
      .disposed(by: disposeBag)
  }
  
}
