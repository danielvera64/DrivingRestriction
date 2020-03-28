//
//  Date+Extension.swift
//  DrivingRestriction
//
//  Created by Daniel Vera on 3/28/20.
//  Copyright © 2020 zakumi. All rights reserved.
//

import Foundation

extension Date {
  
  func toTime() -> String {
    let dateFormater = DateFormatter()
    dateFormater.dateFormat = "HH:mm"
    return dateFormater.string(from: self)
  }
  
  static func getWeekDays() -> [String] {
    let calendar = Calendar.current
    return calendar.weekdaySymbols
  }
  
  func compareTimeOnly(to: Date) -> ComparisonResult {
    let calendar = Calendar.current
    let components2 = calendar.dateComponents([.hour, .minute, .second], from: to)
    let date3 = calendar.date(bySettingHour: components2.hour!, minute: components2.minute!, second: components2.second!, of: self)!

    let seconds = calendar.dateComponents([.second], from: self, to: date3).second!
    if seconds == 0 {
        return .orderedSame
    } else if seconds > 0 {
        return .orderedAscending // Ascending means before
    } else {
        return .orderedDescending // Descending means after
    }
  }
  
}
