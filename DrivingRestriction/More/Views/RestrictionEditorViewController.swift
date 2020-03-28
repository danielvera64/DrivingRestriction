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
import RxDataSources
import Action

final class RestrictionEditorViewController: UIViewController, BindableType {
  
  var viewModel: RestrictionEditorViewModel!
  
  private let disposeBag = DisposeBag()
  
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
    deleteButton.rx.tap
      .bind(to: viewModel.deleteAllAction.inputs)
      .disposed(by: disposeBag)
    
    let addButton = UIBarButtonItem(image: #imageLiteral(resourceName: "addIcon"), style: .plain, target: nil, action: nil)
    addButton.rx.tap
      .bind(to: viewModel.addNewAction.inputs)
      .disposed(by: disposeBag)
    
    navigationItem.rightBarButtonItems = [deleteButton, addButton]
  }
  
  private func setUpViews() {
    view.backgroundColor = .white
    
    let tableView = UITableView()
    tableView.tableFooterView = UIView()
    tableView.rowHeight = UITableView.automaticDimension
    tableView.separatorStyle = .none
    tableView.register(RestrictionTableViewCell.self, forCellReuseIdentifier: "cell")
    view.addSubview(tableView)
    tableView.snp.makeConstraints {
      $0.edges.equalTo(view.safeAreaLayoutGuide)
    }
    
    viewModel
      .currentRestrictions
      .bind(to: tableView.rx.items(cellIdentifier: "cell", cellType: RestrictionTableViewCell.self))
      { _, restrictions, cell in
        cell.setUpWith(restrictions: restrictions)
      }
      .disposed(by: disposeBag)
    
  }
  
}
