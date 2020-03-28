//
//  Int+Extension.swift
//  DrivingRestriction
//
//  Created by Daniel Vera on 3/27/20.
//  Copyright © 2020 zakumi. All rights reserved.
//

import Foundation

extension Int {
  
  var weekdayName: String {
    let calendar = Calendar.current
    let weekdaySymbols = calendar.weekdaySymbols
    let index = (self + calendar.firstWeekday - 1) % 7
    return weekdaySymbols[index]
  }
  
}
