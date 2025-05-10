//
//  CreateTrackerViewController.swift
//  Tracker
//
//  Created by Marina Kireeva on 30.04.2025.
//

import UIKit

protocol CreateTrackerDelegate: AnyObject {
    func addNewTracker(id: UUID, title: String, color: UIColor, emoji: String, schedule: Set<WeekDay>?, completedDays: Int)
}

final class CreateTrackerViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Properties
    var trackerType: TrackerType?
    private var topLabel = UILabel()
    private let tableView = UITableView(frame: .zero, style: .grouped)
    private let saveButton = UIButton.createNoActiveStyleButton(title: "Создать")
    private let cancelButton = UIButton.createCancelStyleButton(title: "Отменить")
    private let titleTextField = UITextField()
    private let hStack  = UIStackView()
    
    weak var delegate: CreateTrackerDelegate?
    private var selectedSchedule: Set<WeekDay>?
    private let trackerColors  = (1...17).map { "Color selection \($0)" }
    private let emojis = ["🔥", "🌸", "🧡", "🌺"]
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(named: "White [day]")
        
        setupTopLabel()
        setupTitleTextField()
        configureTableView()
        setupButtons()
        setupConstraints()
    }
    
    // MARK: - UI
    private func setupTopLabel() {
        // topLabel
        let title = trackerType == .regular ? "Новая привычка" : "Новое нерегулярное событие"
        topLabel = UILabel.createNavAppStyleLabel(title: title)
        view.addSubview(topLabel)
        topLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupTitleTextField() {
        // titleTextField
        view.addSubview(titleTextField)
        titleTextField.placeholder = "Введите название трекера"
        titleTextField.backgroundColor = UIColor(named: "Background [day]")
        titleTextField.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        titleTextField.textColor = UIColor(named: "Gray")
        titleTextField.layer.cornerRadius = 16
        titleTextField.translatesAutoresizingMaskIntoConstraints = false
        titleTextField.addTarget(self, action: #selector(titleTextFieldChanged(_:)), for: .editingChanged)
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 1))
        titleTextField.leftView = paddingView
        titleTextField.rightView = paddingView
        titleTextField.leftViewMode = .always
        titleTextField.rightViewMode = .always
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(HabitTableViewCell.self, forCellReuseIdentifier: HabitTableViewCell.cellReuseIdentifier)
        
        view.addSubview(tableView)
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
    }
    
    private func setupButtons() {
        // hStack
        hStack.addArrangedSubview(cancelButton)
        hStack.addArrangedSubview(saveButton)
        view.addSubview(hStack)
        hStack.axis = .horizontal
        hStack.spacing = 8
        hStack.distribution = .fillEqually
        hStack.alignment = .center
        hStack.translatesAutoresizingMaskIntoConstraints = false
        
        // buttons
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.addTarget(self, action: #selector(cancelButtonTapped(_:)), for: .touchUpInside)
        
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.isEnabled = false
        saveButton.addTarget(self, action: #selector(saveButtonTapped(_:)), for: .touchUpInside)
    }
    
    private func setupConstraints() {
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
    }
    
    // MARK: - TableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        trackerType == .regular ? 2 : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HabitTableViewCell.cellReuseIdentifier, for: indexPath) as? HabitTableViewCell else { return UITableViewCell() }
        
        if indexPath.row == 0 {
            cell.configure(title: "Категория", value: nil, isShowseparator: false)
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
            scheduleVC.finalSchedule = { [weak self] selected in
                self?.selectedSchedule = selected
            }
            present(scheduleVC, animated: true, completion: nil)
        }
    }
    
    @objc private func cancelButtonTapped(_ sender: UIButton) {
        view.window?.rootViewController?.dismiss(animated: true)
    }
    
    @objc private func titleTextFieldChanged(_ sender: UITextField) {
        saveButton.backgroundColor = UIColor(named: "Black [day]")
        saveButton.isEnabled = true
    }
    
    @objc private func saveButtonTapped(_ sender: UIButton) {
        guard let trackerTitle = titleTextField.text else { return }
        
        let colorName = trackerColors.randomElement() ?? "Color selection 1"
        let color = UIColor(named: colorName) ?? .systemGreen
        guard let emoji = emojis.randomElement() else { return }
        
        delegate?.addNewTracker(id: UUID(),
                                title: trackerTitle,
                                color: color,
                                emoji: emoji,
                                schedule: selectedSchedule,
                                completedDays: 0)
        
        view.window?.rootViewController?.dismiss(animated: true)
    }
    
    
}
