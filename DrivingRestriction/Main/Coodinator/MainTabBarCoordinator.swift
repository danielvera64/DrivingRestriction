//
//  MainTabBarCoordinator.swift
//  DrivingRestriction
//
//  Created by Daniel Vera on 3/25/20.
//  Copyright © 2020 zakumi. All rights reserved.
//

import Foundation
import XCoordinator
import UIKit

enum MainTabBarRoute: Route {}

class MainTabBarCoordinator: TabBarCoordinator<MainTabBarRoute> {
  
  init() {
    let homeCoordinator = HomeCoordinator()
    homeCoordinator.rootViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .featured, tag: 1)
    
    let moreCoordinator = MoreCoodinator()
    moreCoordinator.rootViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .more, tag: 1)
    
    super.init(tabs: [homeCoordinator, moreCoordinator])
  }
  
}
