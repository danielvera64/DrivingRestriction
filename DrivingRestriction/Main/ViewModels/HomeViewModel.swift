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
    return Observable.just(())
  }
  
}
