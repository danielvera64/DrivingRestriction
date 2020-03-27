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
  
  @objc dynamic var startHour: Int = -1
  @objc dynamic var startMinute: Int = -1
  @objc dynamic var endHour: Int = -1
  @objc dynamic var endMinute: Int = -1
  @objc dynamic var lastDigit: String = ""
  @objc dynamic var weekday: Int = -1
  
  convenience init(startHour: Int, startMinute: Int, endHour: Int, endMinute: Int, lastDigit: String, weekday: Int) {
    self.init()
    self.startHour = startHour
    self.startMinute = startMinute
    self.endHour = endHour
    self.endMinute = endMinute
    self.lastDigit = lastDigit
    self.weekday = weekday
  }
  
}
