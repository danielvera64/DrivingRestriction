//
//  RestrictionTableViewCell.swift
//  DrivingRestriction
//
//  Created by Daniel Vera on 3/27/20.
//  Copyright © 2020 zakumi. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class RestrictionTableViewCell: UITableViewCell {
  
  private let lastDigistsLabel = UILabel()
  private let weekdaysLabel = UILabel()
  private let hoursStackView = UIStackView()
  private let canUseLabel = UILabel()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setUpViews()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setUpViews()
  }
  
  private func setUpViews() {
    selectionStyle = .none
    backgroundColor = .clear
    contentView.backgroundColor = .clear
    
    let containerView = UIView()
    containerView.backgroundColor = .lightGray
    containerView.layer.cornerRadius = 10
    containerView.clipsToBounds = true
    contentView.addSubview(containerView)
    containerView.snp.makeConstraints {
      $0.edges.equalToSuperview().inset(UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
    }
    
    let lastTitle = UILabel()
    lastTitle.font = .boldSystemFont(ofSize: 16)
    lastTitle.numberOfLines = 1
    lastTitle.setContentCompressionResistancePriority(.required, for: .horizontal)
    lastTitle.setContentHuggingPriority(.required, for: .horizontal)
    lastTitle.text = "\("last_digits_title".localized):"
    
    lastDigistsLabel.font = .systemFont(ofSize: 14)
    lastDigistsLabel.numberOfLines = 0
    lastDigistsLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
    lastDigistsLabel.setContentCompressionResistancePriority(.required, for: .vertical)
    
    let weekdaysTitle = UILabel()
    weekdaysTitle.font = .boldSystemFont(ofSize: 16)
    weekdaysTitle.numberOfLines = 1
    weekdaysTitle.setContentCompressionResistancePriority(.required, for: .horizontal)
    weekdaysTitle.setContentHuggingPriority(.required, for: .horizontal)
    weekdaysTitle.text = "\("weekdays_title".localized):"
    
    weekdaysLabel.font = .systemFont(ofSize: 14)
    weekdaysLabel.numberOfLines = 0
    weekdaysLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
    weekdaysLabel.setContentCompressionResistancePriority(.required, for: .vertical)
    
    let scheduleTitle = UILabel()
    scheduleTitle.font = .boldSystemFont(ofSize: 16)
    scheduleTitle.numberOfLines = 1
    scheduleTitle.setContentCompressionResistancePriority(.required, for: .horizontal)
    scheduleTitle.setContentHuggingPriority(.required, for: .horizontal)
    scheduleTitle.text = "\("schedule_title".localized):"
    
    hoursStackView.axis = .vertical
    hoursStackView.spacing = 3
    
    let canUseTitle = UILabel()
    canUseTitle.font = .boldSystemFont(ofSize: 16)
    canUseTitle.numberOfLines = 1
    canUseTitle.setContentCompressionResistancePriority(.required, for: .horizontal)
    canUseTitle.setContentHuggingPriority(.required, for: .horizontal)
    canUseTitle.text = "\("can_use_vehicle_title".localized):"
    
    canUseLabel.numberOfLines = 1
    canUseLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
    
    let lastStackView = UIStackView()
    lastStackView.axis = .horizontal
    lastStackView.spacing = 10
    lastStackView.addArrangedSubview(lastTitle)
    lastStackView.addArrangedSubview(lastDigistsLabel)
    
    let weekStackView = UIStackView()
    weekStackView.axis = .horizontal
    weekStackView.spacing = 10
    weekStackView.addArrangedSubview(weekdaysTitle)
    weekStackView.addArrangedSubview(weekdaysLabel)
    
    let scheduleStackView = UIStackView()
    scheduleStackView.axis = .horizontal
    scheduleStackView.spacing = 10
    scheduleStackView.addArrangedSubview(scheduleTitle)
    scheduleStackView.addArrangedSubview(hoursStackView)
    
    let canUseStackView = UIStackView()
    canUseStackView.axis = .horizontal
    canUseStackView.spacing = 10
    canUseStackView.addArrangedSubview(canUseTitle)
    canUseStackView.addArrangedSubview(canUseLabel)
    
    let stackView = UIStackView()
    stackView.axis = .vertical
    stackView.spacing = 5
    stackView.addArrangedSubview(lastStackView)
    stackView.addArrangedSubview(weekStackView)
    stackView.addArrangedSubview(scheduleStackView)
    stackView.addArrangedSubview(canUseStackView)
    
    containerView.addSubview(stackView)
    stackView.snp.makeConstraints {
      $0.edges.equalToSuperview().inset(UIEdgeInsets(top: 3, left: 5, bottom: 3, right: 5))
    }
  }
  
  override func prepareForReuse() {
    lastDigistsLabel.text = ""
    weekdaysLabel.text = ""
    hoursStackView.safelyRemoveArrangedSubviews()
    canUseLabel.text = ""
  }
  
  func setUpWith(restrictions: [RestrictionSchedule]) {
    lastDigistsLabel.text = restrictions
      .map { $0.lastDigit }
      .joined(separator: " - ")
    
    let weekdaysSet = Set(restrictions
      .sorted(by: { $0.weekday < $1.weekday })
      .map { $0.weekday.weekdayName })
    weekdaysLabel.text = Array(weekdaysSet).joined(separator: " - ")
    
    restrictions
      .sorted(by: { $0.startTime < $1.startTime })
      .map { [unowned self] schedule in return self.getScheduleLabel(schedule: schedule) }
      .forEach { [unowned self] label in self.hoursStackView.addArrangedSubview(label) }
    
    let canUse = restrictions.map { $0.canUseVehicle }.reduce(true) { $0 && $1 }
    canUseLabel.text = canUse ? "✅" : "⛔️"
  }
  
  private func getScheduleLabel(schedule: RestrictionSchedule) -> UILabel {
    let auxLabel = UILabel()
    auxLabel.font = .systemFont(ofSize: 14)
    auxLabel.numberOfLines = 1
    auxLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
    auxLabel.setContentCompressionResistancePriority(.required, for: .vertical)
    auxLabel.text = "\(schedule.startTime.toTime()) - \(schedule.endTime.toTime())"
    return auxLabel
  }
  
}
