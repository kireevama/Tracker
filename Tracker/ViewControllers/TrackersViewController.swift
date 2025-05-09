//
//  ViewController.swift
//  Tracker
//
//  Created by Marina Kireeva on 06.04.2025.
//

import UIKit

class TrackersViewController: UIViewController, CreateTrackerDelegate {
    
    // MARK: - Properties
    weak var delegate: CreateTrackerDelegate?
    
    private var categories: [TrackerCategory]?
    private var visibleCategories: [TrackerCategory]?
    private let defaultCategory = "Важное"
    
    // Моковые данные для трекеров
    let mockTrackers: [Tracker] = [
        Tracker(id: UUID(),
                title: "Пить воду",
                color: UIColor(named: "Color selection 1") ?? .green,
                emoji: "💧",
                schedule: [.monday, .wednesday, .friday],
                completedDays: 3),
        
        Tracker(id: UUID(),
                title: "Утренние упражнения",
                color: UIColor(named: "Color selection 2") ?? .green,
                emoji: "💪",
                schedule: [.monday, .tuesday, .thursday],
                completedDays: 5),
        
        Tracker(id: UUID(),
                title: "Чтение книги",
                color: UIColor(named: "Color selection 3") ?? .green,
                emoji: "📚",
                schedule: [.tuesday, .thursday],
                completedDays: 2),
        
        Tracker(id: UUID(),
                title: "Медитация",
                color: UIColor(named: "Color selection 4") ?? .green,
                emoji: "🧘‍♀️",
                schedule: [.monday, .friday],
                completedDays: 7),
        
        Tracker(id: UUID(),
                title: "Подготовка к экзаменам",
                color: UIColor(named: "Color selection 5") ?? .green,
                emoji: "📖",
                schedule: [.wednesday, .saturday],
                completedDays: 1),
        
        Tracker(id: UUID(),
                title: "Прогулки на свежем воздухе",
                color: UIColor(named: "Color selection 6") ?? .green,
                emoji: "🚶‍♀️",
                schedule: [.sunday],
                completedDays: 4)
    ]
    
    private let trackersCollectionVC = TrackersCollectionViewController()
    private let createTrackerVC = CreateTrackerViewController()
    
    private let topNavView: UIView = {
        let topNavView = UIView()
        
        return topNavView
    }()
    
    private let datePicker = UIDatePicker()
    private let searchBar = UISearchBar()
    
    private var stubView: UIStackView?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Разбиение на категории
        categories = [
            TrackerCategory(categoryName: "Здоровье", trackers: [
                mockTrackers[0], // Пить воду
                mockTrackers[1], // Утренние упражнения
                mockTrackers[3]  // Медитация
            ]),
            
            TrackerCategory(categoryName: "Учеба", trackers: [
                mockTrackers[4] // Подготовка к экзаменам
            ]),
            
            TrackerCategory(categoryName: "Что-то еще", trackers: [
                mockTrackers[2], // Чтение книги
                mockTrackers[5]  // Прогулки на свежем воздухе
            ])
        ]
        
        view.addSubview(topNavView)
        setupUI()
    }
    
    // MARK: - UI
    private func setupUI() {
        lazy var plusButton: UIButton = {
            let button = UIButton()
            
            let imageView = UIImageView.init(image: UIImage(named: "iconPlus"))
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.widthAnchor.constraint(equalToConstant: 19).isActive = true
            imageView.heightAnchor.constraint(equalToConstant: 19).isActive = true
            button.addSubview(imageView)
            imageView.centerXAnchor.constraint(equalTo: button.centerXAnchor).isActive = true
            imageView.centerYAnchor.constraint(equalTo: button.centerYAnchor).isActive = true
            
            button.translatesAutoresizingMaskIntoConstraints = false
            button.widthAnchor.constraint(equalToConstant: 42).isActive = true
            button.heightAnchor.constraint(equalToConstant: 42).isActive = true
            
            button.addTarget(self, action: #selector(self.plusButtonTapped(_:)), for: .touchUpInside)
            
            return button
        }()
        
        var calendar = Calendar.current
        calendar.firstWeekday = 2  // Установка понедельника первым днем недели
        datePicker.calendar = calendar
        datePicker.preferredDatePickerStyle = .compact
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
        
        let hStack: UIStackView = {
            let stack = UIStackView()
            topNavView.addSubview(stack)
            stack.axis = .horizontal
            stack.alignment = .center
            stack.addArrangedSubview(plusButton)
            stack.addArrangedSubview(datePicker)
            
            stack.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                stack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 6),
                stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
                stack.heightAnchor.constraint(equalToConstant: 42),
            ])
            
            return stack
        }()
        
        let label: UILabel = {
            let label = UILabel()
            topNavView.addSubview(label)
            label.text = "Трекеры"
            label.font = UIFont.systemFont(ofSize: 34, weight: .bold)
            label.textColor = UIColor(named: "Black [day]")
            
            label.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                label.topAnchor.constraint(equalTo: hStack.bottomAnchor, constant: 2),
                label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            ])
            
            return label
        }()
        
        topNavView.addSubview(searchBar)
        searchBar.placeholder = "Поиск"
        searchBar.backgroundImage = UIImage() // убираем линии
        searchBar.delegate = self
        searchBar.showsCancelButton = false
        
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 7),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
        
        topNavView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topNavView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            topNavView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            topNavView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            topNavView.bottomAnchor.constraint(equalTo: searchBar.bottomAnchor)
        ])
        
        
        if let categories = categories, !categories.isEmpty {
            showCollection()
        } else {
            stubView = getStubScreen(imageName: "star",
                                     text: "Что будем отслеживать?", view: self.view)
        }
        
    }
    
    // MARK: - Methods
    private func showCollection() {
        trackersCollectionVC.trackerCategories = categories
        addChild(trackersCollectionVC) // Добавление child
        view.addSubview(trackersCollectionVC.view)
        trackersCollectionVC.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            trackersCollectionVC.view.topAnchor.constraint(equalTo: topNavView.bottomAnchor, constant: 24),
            trackersCollectionVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            trackersCollectionVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            trackersCollectionVC.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
        trackersCollectionVC.didMove(toParent: self)
    }
    
    func addNewTracker(id: UUID,
                       title: String,
                       color: UIColor,
                       emoji: String,
                       schedule: Set<WeekDay>?,
                       completedDays: Int) {
        
        if let categories = categories {
            let category = categories[0]
            
            let newTracker = Tracker(id: id, title: title, color: color, emoji: emoji, schedule: schedule, completedDays: completedDays)
            let updatedCategory = TrackerCategory(categoryName: category.categoryName,
                                                  trackers: category.trackers + [newTracker])
            
            self.categories?[0] = updatedCategory
        }
        
        trackersCollectionVC.selectedDate = datePicker.date
        trackersCollectionVC.trackerCategories = self.categories
        trackersCollectionVC.collectionView.reloadData()
    }
    
    private func reloadVisibleCategories() {
        let selectedDate = datePicker.date
        let calendar = Calendar.current
        let filterWeekday = calendar.component(.weekday, from: selectedDate)
        let filterText = (searchBar.text ?? "").lowercased()
        
        visibleCategories = categories?.compactMap { category in
            let trackers = category.trackers.filter { tracker in
                let textCondition = filterText.isEmpty ||
                tracker.title.lowercased().contains(filterText)
                let dateCondition = tracker.schedule?.contains { (weekDay: WeekDay) in
                    weekDay.rawValue == filterWeekday
                } == true
                
                return textCondition && dateCondition
            }
            
            return trackers.isEmpty ? nil : TrackerCategory(
                categoryName: category.categoryName,
                trackers: trackers
            )
        }
        
        trackersCollectionVC.trackerCategories = visibleCategories
        trackersCollectionVC.collectionView.reloadData()
        
        reloadStubScreen()
    }
    
    private func reloadStubScreen() {
        stubView?.removeFromSuperview()
        
        if visibleCategories?.isEmpty == true {
            stubView = getStubScreen(imageName: "empty",
                                     text: "Ничего не найдено", view: self.view)
        }
        
    }
    
    // MARK: - Actions
    @objc private func plusButtonTapped(_ sender: UIButton) {
        let chooseTrackerVC = ChooseTrackerTypeViewController()
        chooseTrackerVC.delegate = self
        present(chooseTrackerVC, animated: true, completion: nil)
    }
    
    @objc private func datePickerValueChanged(_ sender: UIDatePicker) {
        let selectedDate = sender.date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        let formattedDate = dateFormatter.string(from: selectedDate)
        trackersCollectionVC.selectedDate = selectedDate
        
        reloadVisibleCategories()
    }
    
    
}

extension TrackersViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
        searchBar.resignFirstResponder() // Скрыть клавиатуру
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        reloadVisibleCategories()
    }
    
}
