//
//  HomeViewModel.swift
//  DrivingRestriction
//
//  Created by Daniel Vera on 3/28/20.
//  Copyright © 2020 zakumi. All rights reserved.
//

import Foundation
import XCoordinator
import XCoordinatorRx
import RxSwift
import Action

class HomeViewModel {
  
  let router: UnownedRouter<HomeListRoute>
  let formObservable: Observable<(String?, Date?)>
  
  let plateNumberSubject = BehaviorSubject<String?>(value: nil)
  let dateSelectedSubject = BehaviorSubject<Date?>(value: nil)
  
  private let dataManager = RealmDataManager()
  private let calendar = Calendar.current
  
  lazy var checkAction = Action<(String?, Date?),Void>() { [unowned self] plate, date in
    guard let plateNumber = plate, let selectedDate = date else {
      return self.router.rx.trigger(.alert(title: "", message: "missing_plate_number".localized,
                                           onAccept: {}, onCancel: nil))
    }
    guard let lastDigit = plateNumber.lastDigit else {
      return self.router.rx.trigger(.alert(title: "", message: "invalid_plate_number".localized,
      onAccept: {}, onCancel: nil))
    }
    return self.checkRestriction(lastDigit: lastDigit, date: selectedDate)
  }
  
  init(router: UnownedRouter<HomeListRoute>) {
    self.router = router
    self.formObservable = Observable.combineLatest(plateNumberSubject, dateSelectedSubject)
  }
  
  private func checkRestriction(lastDigit: Int, date: Date) -> Observable<Void> {
    let weekday = calendar.component(.weekday, from: date) - 1
    let restrictions = dataManager.getArray(type: RestrictionSchedule.self, query: "weekday = \(weekday)")
    if restrictions.isEmpty {
      return self.router.rx.trigger(.alert(title: "", message: "you_can_drive".localized,
                                           onAccept: {}, onCancel: nil))
    }
    let current = restrictions.filter({ rest in
      let startComp = rest.startTime.compareTimeOnly(to: date)
      let endComp = rest.endTime.compareTimeOnly(to: date)
      return rest.lastDigit == "\(lastDigit)" &&
        rest.canUseVehicle == false &&
        (startComp == .orderedAscending || startComp == .orderedSame) &&
        (endComp == .orderedDescending || endComp == .orderedSame)
    })
    if current.isEmpty {
      return self.router.rx.trigger(.alert(title: "", message: "you_can_drive".localized,
                                           onAccept: {}, onCancel: nil))
    }
    return self.router.rx.trigger(.alert(title: "", message: "you_can_not_drive".localized,
                                         onAccept: {}, onCancel: nil))
  }
  
}
