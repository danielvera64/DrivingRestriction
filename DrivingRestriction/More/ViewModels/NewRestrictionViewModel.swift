//
//  NewRestrictionViewModel.swift
//  DrivingRestriction
//
//  Created by Daniel Vera on 3/28/20.
//  Copyright © 2020 zakumi. All rights reserved.
//

import Foundation
import XCoordinator
import RxSwift
import Action

class NewRestrictionViewModel {
  
  let router: UnownedRouter<MoreListRoute>
  
  let weekdaysSubject = BehaviorSubject<[String]>(value: Date.getWeekDays())
  let rowSelected = PublishSubject<(row:Int, component:Int)>()
  let weekdaySelected = BehaviorSubject<String?>(value: nil)
  
  private let disposeBag = DisposeBag()
  
  init(router: UnownedRouter<MoreListRoute>) {
    self.router = router
    rowSelected
      .map { [unowned self] row, _ -> String? in
        guard let weekdays = try? self.weekdaysSubject.value(), row < weekdays.count else {
          return nil
        }
        return weekdays[row]
      }.bind(to: weekdaySelected)
      .disposed(by: disposeBag)
  }
  
}
