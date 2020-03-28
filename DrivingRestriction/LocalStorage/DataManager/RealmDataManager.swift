//
//  RealmDataManager.swift
//  DrivingRestriction
//
//  Created by Daniel Vera on 3/26/20.
//  Copyright © 2020 zakumi. All rights reserved.
//

import Foundation
import RealmSwift
import RxSwift
import RxRealm

class RealmDataManager: DataManagerProtocol {

  typealias T = Object

  public var dataSource: Realm!
  private let DB_NAME: String

  private static let AUX_DB_NAME = "DrivingRestriction"
  
  init(dbName: String = AUX_DB_NAME) {
    self.DB_NAME = dbName
    preloadDB()
  }

  private func preloadDB() {
    if !FileManager.default.fileExists(atPath: getActiveDBPath() ?? "") {
      copyPreloadedDB()
    }
    guard let fullDestPath = getActiveDBPath(),
      FileManager.default.fileExists(atPath: fullDestPath),
      let dbUrl = URL(string: fullDestPath) else
    {
      dataSource = try! Realm()
      return
    }
    dataSource = try! Realm(configuration: Realm.Configuration(fileURL: dbUrl))
  }

  private func copyPreloadedDB() {
    guard
      let bundlePath = Bundle.main.path(forResource: DB_NAME, ofType: "realm"),
      let fullDestPath = getActiveDBPath() else
    {
      return
    }
    let fileManager = FileManager.default
    do {
      try fileManager.copyItem(at: URL(fileURLWithPath: bundlePath), to: URL(fileURLWithPath: fullDestPath))
    } catch {
      print(error.localizedDescription)
      return
    }
  }

  private func getActiveDBPath() -> String? {
    guard
      let destPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first else
    {
      return nil
    }
    let path = (destPath as NSString).appendingPathComponent("\(DB_NAME).realm")
    return path
  }

  func add(object: Object, update: Bool) throws {
    do {
      try dataSource.write { dataSource.add(object, update: update ? .modified : .error) }
    } catch {
      throw error
    }
  }

  func add(objects: [Object], update: Bool) throws {
    do {
      try dataSource.write { dataSource.add(objects, update: update ? .modified : .error) }
    } catch {
      throw error
    }
  }

  func getSingle<T>(type: T.Type, query: String) -> T? {
    guard let objType = type as? Object.Type, query.count > 0 else { return nil }
    return dataSource.objects(objType).filter(query).first as? T
  }
  
  func getArray<T>(type: T.Type, query: String) -> [T] {
    guard let objType = type as? Object.Type, query.count > 0 else { return [] }
    return dataSource.objects(objType).filter(query).compactMap { $0 as? T }
  }
  
  func getAll<T>(type: T.Type) -> [T] {
    guard let objType = type as? Object.Type else { return [] }
    return dataSource.objects(objType).compactMap { $0 as? T }
  }
  
  func getObservable<T>(type: T.Type, query: String = "") -> Observable<[T]> {
    guard let objType = type as? Object.Type else { return Observable.just([]) }
    var objects = dataSource.objects(objType)
    if query.count > 0 { objects = objects.filter(query) }
    return Observable
      .collection(from: objects)
      .compactMap { $0.toArray().map { $0 as? T }.filter { $0 != nil } as? [T] }
  }
  
  func delete(object: Object) throws {
    do {
      try dataSource.write { dataSource.delete(object) }
    } catch {
      throw error
    }
  }

  func delete(objects: [Object]) throws {
    do {
      try dataSource.write {  }
    } catch {
      throw error
    }
    dataSource.delete(objects)
  }

  func clearTable(type: Object.Type) throws {
    let objectsToDelete = dataSource.objects(type)
    guard objectsToDelete.count > 0 else { return }
    do {
      try dataSource.write { dataSource.delete(objectsToDelete) }
    } catch {
      throw error
    }
  }

}
