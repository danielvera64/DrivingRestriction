//
//  String+Extension.swift
//  DrivingRestriction
//
//  Created by Daniel Vera on 3/27/20.
//  Copyright © 2020 zakumi. All rights reserved.
//

import Foundation

extension String {
  
  var localized: String {
    return NSLocalizedString(self, tableName: "localized", bundle: Bundle.main, value: "", comment: "")
  }
  
  var containsNumbers: Bool {
    let numberRegEx  = ".*[0-9]+.*"
    let testCase     = NSPredicate(format:"SELF MATCHES %@", numberRegEx)
    return testCase.evaluate(with: self)
  }
  
  var lastDigit: Int? {
    guard let digit = self.last else { return nil }
    return Int(String(digit))
  }
  
}
