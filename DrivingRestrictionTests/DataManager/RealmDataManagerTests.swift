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

@testable import DrivingRestriction
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
        let restriction = dataManager.dataSource.objects(RestrictionSchedule.self).first
        expect(restriction).toEventuallyNot(beNil())
        expect(restriction?.lastDigit).to(equal("TEST"))
      }
      
      it("insert a Restriction Schedule") {
        let restriction = RestrictionSchedule(startHour: 7, startMinute: 30, endHour: 19,
                                              endMinute: 15, lastDigit: "TEST2", weekday: 4)
        try? dataManager.add(object: restriction, update: false)
        
        let objects = dataManager.dataSource.objects(RestrictionSchedule.self)
        expect(objects.count).to(equal(2))
      }
      
      it("delete a Restriction Schedule") {
        let restriction = RestrictionSchedule(startHour: 7, startMinute: 30, endHour: 19,
                                              endMinute: 15, lastDigit: "TEST3", weekday: 4)
        try? dataManager.add(object: restriction, update: false)
        
        var toBeDeleted = dataManager.dataSource.objects(RestrictionSchedule.self).filter("lastDigit = 'TEST3'").first
        expect(toBeDeleted).toNot(beNil())
        
        try? dataManager.delete(object: toBeDeleted!)
        
        toBeDeleted = dataManager.dataSource.objects(RestrictionSchedule.self).filter("lastDigit = 'TEST3'").first
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
