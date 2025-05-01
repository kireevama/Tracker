//
//  ScheduleViewController.swift
//  Tracker
//
//  Created by Marina Kireeva on 01.05.2025.
//

import UIKit

final class ScheduleViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Properties
    let tableView = UITableView(frame: .zero, style: .grouped)
    
    
    // MARK: - Lifecycle
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        tableView.delegate = self
        tableView.dataSource = self
        view.backgroundColor = UIColor(named: "White [day]")
        tableView.register(HabitTableViewCell.self, forCellReuseIdentifier: HabitTableViewCell.cellReuseIdentifier)
        tableView.separatorStyle = .none
    }
    
    // MARK: - UI
    private func setupUI() {
        let topLabel = UILabel.createNavAppStyleLabel(title: "Расписание")
        view.addSubview(topLabel)
        topLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        let doneButton = UIButton.createNormalStyleButton(title: "Готово")
        view.addSubview(doneButton)
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        
        
        
    }
    
    // MARK: - TableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
}
