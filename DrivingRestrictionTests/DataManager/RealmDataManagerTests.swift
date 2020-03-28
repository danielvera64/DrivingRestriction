//
//  RealmDataManagerTests.swift
//  DrivingRestrictionTests
//
//  Created by Daniel Vera on 3/26/20.
//  Copyright © 2020 zakumi. All rights reserved.
//

import Foundation
import Quick
import Nimble
import RealmSwift

@testable import Restriction
class RealmDataManagerTests: QuickSpec {
  override func spec() {
    
    var dataManager: RealmDataManager!
    let DB_NAME = "testDB"
    
    beforeSuite {
      deleteTestDB()
      dataManager = RealmDataManager(dbName: DB_NAME)
    }
    
    describe("the RealmDataManager") {
      it("preloads database") {
        let restriction = dataManager.getAll(type: RestrictionSchedule.self).first
        expect(restriction).toEventuallyNot(beNil())
        expect(restriction?.lastDigit).to(equal("TEST"))
      }
      
      it("insert a Restriction Schedule") {
        let restriction = RestrictionSchedule(startHour: 7, startMinute: 30, endHour: 19,
                                              endMinute: 15, lastDigit: "TEST2", weekday: 4, canUseVehicle: false)
        try? dataManager.add(object: restriction, update: false)
        
        let objects = dataManager.getAll(type: RestrictionSchedule.self)
        expect(objects.count).to(equal(2))
      }
      
      it("delete a Restriction Schedule") {
        let restriction = RestrictionSchedule(startHour: 7, startMinute: 30, endHour: 19,
                                              endMinute: 15, lastDigit: "TEST3", weekday: 4, canUseVehicle: true)
        try? dataManager.add(object: restriction, update: false)
        
        var toBeDeleted = dataManager.getSingle(type: RestrictionSchedule.self, query: "lastDigit = 'TEST3'")
        expect(toBeDeleted).toNot(beNil())
        
        try? dataManager.delete(object: toBeDeleted!)
        
        toBeDeleted = dataManager.getSingle(type: RestrictionSchedule.self, query: "lastDigit = 'TEST3'")
        expect(toBeDeleted).to(beNil())
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
