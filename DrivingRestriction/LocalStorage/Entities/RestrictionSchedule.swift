//
//  RestrictionSchedule.swift
//  DrivingRestriction
//
//  Created by Daniel Vera on 3/26/20.
//  Copyright © 2020 zakumi. All rights reserved.
//

import Foundation
import RealmSwift

class RestrictionSchedule: Object {
  
  @objc dynamic var startTime: Date = Date()
  @objc dynamic var endTime: Date = Date()
  @objc dynamic var lastDigit: String = ""
  @objc dynamic var weekday: Int = -1
  @objc dynamic var canUseVehicle: Bool = false
  
  convenience init(startTime: Date, endTime: Date, lastDigit: String,
                   weekday: Int, canUseVehicle: Bool)
  {
    self.init()
    self.startTime = startTime
    self.endTime = endTime
    self.lastDigit = lastDigit
    self.weekday = weekday
    self.canUseVehicle = canUseVehicle
  }
  
}
