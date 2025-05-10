//
//  ScheduleTableViewCell.swift
//  Tracker
//
//  Created by Marina Kireeva on 01.05.2025.
//

import UIKit

final class ScheduleTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    static let cellReuseIdentifier = "scheduleTableViewCell"
    private let label = UILabel()
    private let cellSwitch = UISwitch()
    private var switchChangedCallback: ((Bool) -> Void)?
    
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: ScheduleTableViewCell.cellReuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        let hStack = UIStackView(arrangedSubviews: [label, cellSwitch])
        contentView.addSubview(hStack)
        hStack.axis = .horizontal
        hStack.alignment = .center
        
        hStack.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        cellSwitch.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            hStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            hStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            hStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            hStack.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        ])
        
        cellSwitch.addTarget(self, action: #selector(cellSwitchValueChanged), for: .valueChanged)
    }
    
    // MARK: - Metods
    func configure(cellText: String, isOn: Bool, switchChanged: @escaping (Bool) -> Void) {
        label.text = cellText
        cellSwitch.isOn = isOn
        self.switchChangedCallback = switchChanged
    }
    
    @objc private func cellSwitchValueChanged(_ sender: UISwitch) {
        switchChangedCallback?(sender.isOn)
    }
    
}


