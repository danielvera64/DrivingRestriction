//
//  MoreViewController.swift
//  DrivingRestriction
//
//  Created by Daniel Vera on 3/25/20.
//  Copyright © 2020 zakumi. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import RxSwift
import RxDataSources

final class MoreViewController: UIViewController, BindableType {
  
  var viewModel: MoreViewModel!
  
  let disposeBag = DisposeBag()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setUpViews()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    navigationItem.title = "more_title".localized
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    navigationItem.title = ""
  }
  
  func bindViewModel() {}
  
  private func setUpViews() {
    let tableView = UITableView()
    tableView.tableFooterView = UIView()
    tableView.rowHeight = 60
    tableView.separatorStyle = .singleLine
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    view.addSubview(tableView)
    tableView.snp.makeConstraints {
      $0.edges.equalTo(view.safeAreaLayoutGuide)
    }
    
    viewModel
      .optionsSubject
      .bind(to: tableView.rx.items(cellIdentifier: "cell", cellType: UITableViewCell.self))
      { _, option, cell in
        cell.textLabel?.text = option.title
        cell.selectionStyle = .none
        cell.accessoryType = .disclosureIndicator
      }
      .disposed(by: disposeBag)
    
    tableView.rx
      .modelSelected(MenuOption.self)
      .map { $0.route }
      .bind(to: viewModel.menuOptionSelected.inputs)
      .disposed(by: disposeBag)
  }
  
}
