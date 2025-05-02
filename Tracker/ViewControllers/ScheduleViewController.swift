//
//  ScheduleViewController.swift
//  Tracker
//
//  Created by Marina Kireeva on 01.05.2025.
//

import UIKit

final class ScheduleViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Properties
    let tableView = UITableView(frame: .zero, style: .plain)
    let rowHeight: CGFloat = 75
    let weekdays = ["Понедельник", "Вторник", "Среда", "Четверг", "Пятница", "Суббота", "Воскресенье"]
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(named: "White [day]")
        setupUI()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ScheduleTableViewCell.self, forCellReuseIdentifier: ScheduleTableViewCell.cellReuseIdentifier)
        tableView.isScrollEnabled = true
    }
    
    // MARK: - UI
    private func setupUI() {
        let topLabel = UILabel.createNavAppStyleLabel(title: "Расписание")
        view.addSubview(topLabel)
        topLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.layer.cornerRadius = 16
        tableView.layer.masksToBounds = true
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)

        
        let numberOfRows = weekdays.count
        let tableHeight = rowHeight * CGFloat(numberOfRows)
        let doneButton = UIButton.createNormalStyleButton(title: "Готово")
        view.addSubview(doneButton)
        doneButton.addTarget(self, action: #selector(self.doneButtonTapped(_:)), for: .touchUpInside)
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            topLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 26),
            topLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            topLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            tableView.topAnchor.constraint(equalTo: topLabel.bottomAnchor, constant: 30),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            tableView.heightAnchor.constraint(equalToConstant: tableHeight),
            
            doneButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            doneButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            doneButton.heightAnchor.constraint(equalToConstant: 60),
            doneButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
        ])
        
    }
    
    // MARK: - TableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        weekdays.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ScheduleTableViewCell.cellReuseIdentifier, for: indexPath) as? ScheduleTableViewCell else { return UITableViewCell() }
        
        let day = weekdays[indexPath.row]
        cell.configure(cellText: day)
        cell.contentView.backgroundColor = UIColor(named: "Background [day]")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        rowHeight
    }
    
    @objc private func doneButtonTapped(_ sender: UIButton) {
        
    }
    
    
}
