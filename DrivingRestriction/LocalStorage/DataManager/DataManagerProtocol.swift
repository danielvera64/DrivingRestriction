//
//  DataManagerProtocol.swift
//  DrivingRestriction
//
//  Created by Daniel Vera on 3/26/20.
//  Copyright © 2020 zakumi. All rights reserved.
//

import Foundation
import RxSwift

protocol DataManagerProtocol {
  associatedtype T
  func add(object: T, update: Bool) throws
  func add(objects: [T], update: Bool) throws
  func getSingle<T>(type: T.Type, query: String) -> T?
  func getArray<T>(type: T.Type, query: String) -> [T]
  func getAll<T>(type: T.Type) -> [T]
  func getObservable<T>(type: T.Type, query: String) -> Observable<[T]>
  func delete(object: T) throws
  func delete(objects: [T]) throws
  func clearTable(type: T.Type) throws
}
