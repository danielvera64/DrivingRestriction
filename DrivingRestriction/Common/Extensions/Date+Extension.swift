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
  
}
