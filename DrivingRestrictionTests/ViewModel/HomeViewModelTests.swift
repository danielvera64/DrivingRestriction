//
//  HomeViewModelTests.swift
//  DrivingRestrictionTests
//
//  Created by Daniel Vera on 3/28/20.
//  Copyright © 2020 zakumi. All rights reserved.
//

import Foundation
import Quick
import Nimble
import RealmSwift

@testable import Restriction
class HomeViewModelTests: QuickSpec {
  override func spec() {
    
    let viewModel = HomeViewModel(router: HomeCoordinator().unownedRouter)
    var dataManager: RealmDataManager!
    let DB_NAME = "testDB"
    
    beforeSuite {
      deleteTestDB()
      dataManager = RealmDataManager(dbName: DB_NAME)
      viewModel.dataManager = dataManager
      let objects = dataManager.getAll(type: RestrictionSchedule.self)
      if objects.count > 0 { try? dataManager.delete(objects: objects) }
    }
    
    describe("the user press check button") {
      it("return if has restriction") {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        
        var date1 = dateFormatter.date(from: "2020-12-26T07:00:00")!
        var date2 = dateFormatter.date(from: "2020-12-26T09:30:00")!
        var restriction = RestrictionSchedule(startTime: date1, endTime: date2, lastDigit: "8", weekday: 6, canUseVehicle: false)
        try? dataManager.add(object: restriction, update: false)
        
        expect(viewModel.checkRestriction(lastDigit: 8, date: dateFormatter.date(from: "2020-12-26T08:00:00")!)).to(beFalse())
        expect(viewModel.checkRestriction(lastDigit: 8, date: dateFormatter.date(from: "2020-12-26T06:00:00")!)).to(beTrue())
        
        date1 = dateFormatter.date(from: "2020-12-26T07:00:00")!
        date2 = dateFormatter.date(from: "2020-12-26T09:30:00")!
        restriction = RestrictionSchedule(startTime: date1, endTime: date2, lastDigit: "7", weekday: 6, canUseVehicle: true)
        try? dataManager.add(object: restriction, update: false)
        
        expect(viewModel.checkRestriction(lastDigit: 7, date: dateFormatter.date(from: "2020-12-26T08:00:00")!)).to(beTrue())
        expect(viewModel.checkRestriction(lastDigit: 7, date: dateFormatter.date(from: "2020-12-26T06:00:00")!)).to(beFalse())
      }
    }
    
    func deleteTestDB() {
      let auxPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first
      guard let destPath = auxPath else {
        return
      }
      let path = (destPath as NSString).appendingPathComponent("\(DB_NAME).realm")
      try? FileManager.default.removeItem(atPath: path)
    }
    
  }
}
