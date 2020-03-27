//
//  DataManagerProtocol.swift
//  DrivingRestriction
//
//  Created by Daniel Vera on 3/26/20.
//  Copyright © 2020 zakumi. All rights reserved.
//

import Foundation

protocol DataManagerProtocol {
  associatedtype T
  func add(object: T, update: Bool) throws
  func add(objects: [T], update: Bool) throws
  func delete(object: T) throws
  func delete(objects: [T]) throws
  func clearTable(type: T.Type) throws
}
