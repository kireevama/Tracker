//
//  CreateTrackerViewController.swift
//  Tracker
//
//  Created by Marina Kireeva on 30.04.2025.
//

import UIKit

final class CreateTrackerViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Properties
    var trackerType: TrackerType?
    let tableView = UITableView(frame: .zero, style: .grouped)
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(named: "White [day]")
        setupUI()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(HabitTableViewCell.self, forCellReuseIdentifier: HabitTableViewCell.cellReuseIdentifier)
        tableView.separatorStyle = .none
    }
    
    // MARK: - UI
    private func setupUI() {
        
        // topLabel
        let title = trackerType == .regular ? "Новая привычка" : "Новое нерегулярное событие"
        let topLabel = UILabel.createNavAppStyleLabel(title: title)
        view.addSubview(topLabel)
        topLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // titleTextField
        let titleTextField = UITextField()
        view.addSubview(titleTextField)
        titleTextField.placeholder = "Введите название трекера"
        titleTextField.backgroundColor = UIColor(named: "Background [day]")
        titleTextField.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        titleTextField.textColor = UIColor(named: "Gray")
        titleTextField.layer.cornerRadius = 16
        titleTextField.translatesAutoresizingMaskIntoConstraints = false
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 1))
        titleTextField.leftView = paddingView
        titleTextField.rightView = paddingView
        titleTextField.leftViewMode = .always
        titleTextField.rightViewMode = .always
        
        // tableView
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        
        // buttons
        let cancelButton = UIButton.createCancelStyleButton(title: "Отменить")
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        let saveButton = UIButton.createNoActiveStyleButton(title: "Создать")
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        
        // hStack
        let hStack = UIStackView(arrangedSubviews: [cancelButton, saveButton])
        view.addSubview(hStack)
        hStack.axis = .horizontal
        hStack.spacing = 8
        hStack.distribution = .fillEqually
        hStack.alignment = .center
        hStack.translatesAutoresizingMaskIntoConstraints = false
        
        // Constraints
        NSLayoutConstraint.activate([
            topLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 26),
            topLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            topLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            titleTextField.topAnchor.constraint(equalTo: topLabel.bottomAnchor, constant: 24),
            titleTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            titleTextField.heightAnchor.constraint(equalToConstant: 75),
            
            tableView.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 24),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            cancelButton.heightAnchor.constraint(equalToConstant: 60),
            saveButton.heightAnchor.constraint(equalToConstant: 60),
            
            hStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            hStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            hStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ])
        
        cancelButton.addTarget(self, action: #selector(cancelButtonTapped(_:)), for: .touchUpInside)
        saveButton.addTarget(self, action: #selector(saveButtonTapped(_:)), for: .touchUpInside)
        
    }
    
    // MARK: - TableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        trackerType == .regular ? 2 : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HabitTableViewCell.cellReuseIdentifier, for: indexPath) as? HabitTableViewCell else { return UITableViewCell() }
        
        if indexPath.row == 0 {
            cell.configure(title: "Категория", value: "Важное", isShowseparator: false)
        } else {
            cell.configure(title: "Расписание", value: nil, isShowseparator: true)
        }
        
        cell.contentView.backgroundColor = UIColor(named: "Background [day]")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        75
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cornerRadius: CGFloat = 16
        
        if trackerType == .regular {
            if indexPath.row == 0 {
                cell.contentView.layer.cornerRadius = cornerRadius
                cell.contentView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
                cell.contentView.clipsToBounds = true
            } else {
                cell.contentView.layer.cornerRadius = cornerRadius
                cell.contentView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
                cell.contentView.clipsToBounds = true
            }
        } else {
            cell.contentView.layer.cornerRadius = cornerRadius
            cell.contentView.clipsToBounds = true
        }
        

    }
    
    // MARK: - TableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true) // Убираем выделение
        
        if indexPath.row == 0 {
            // MARK: - TODO Переход на экран с категорией
        } else if trackerType == .regular && indexPath.row == 1 {
            // Переход на экран расписания
            let scheduleVC = ScheduleViewController()
            present(scheduleVC, animated: true, completion: nil)
        }
    }
    
    @objc private func cancelButtonTapped(_ sender: UIButton) {
        view.window?.rootViewController?.dismiss(animated: true)
    }
    
    @objc private func saveButtonTapped(_ sender: UIButton) {
        
    }
    
   
}
