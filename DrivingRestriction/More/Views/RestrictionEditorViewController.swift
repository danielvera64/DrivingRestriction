//
//  RestrictionEditorViewController.swift
//  DrivingRestriction
//
//  Created by Daniel Vera on 3/27/20.
//  Copyright © 2020 zakumi. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

final class RestrictionEditorViewController: UIViewController, BindableType {
  
  var viewModel: RestrictionEditorViewModel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setUpBarButtons()
    setUpViews()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    navigationItem.title = "restriction_title".localized
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    navigationItem.title = ""
  }
  
  func bindViewModel() {}
  
  private func setUpBarButtons() {
    let deleteButton = UIBarButtonItem(image: #imageLiteral(resourceName: "trashIcon"), style: .plain, target: nil, action: nil)
    
    let addButton = UIBarButtonItem(image: #imageLiteral(resourceName: "addIcon"), style: .plain, target: nil, action: nil)
    
    navigationItem.rightBarButtonItems = [deleteButton, addButton]
  }
  
  private func setUpViews() {
    let tableView = UITableView()
    tableView.tableFooterView = UIView()
    tableView.rowHeight = UITableView.automaticDimension
    tableView.separatorStyle = .singleLine
    tableView.register(RestrictionTableViewCell.self, forCellReuseIdentifier: "cell")
    view.addSubview(tableView)
    tableView.snp.makeConstraints {
      $0.edges.equalTo(view.safeAreaLayoutGuide)
    }
  }
  
}
