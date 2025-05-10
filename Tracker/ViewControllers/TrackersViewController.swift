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
    
    private var categories: [TrackerCategory] = []
    private var visibleCategories: [TrackerCategory]?
    private let defaultCategory = "Важное"
    
    private let trackersCollectionVC = TrackersCollectionViewController()
    private let createTrackerVC = CreateTrackerViewController()
    
    private let topNavView: UIView = {
        let topNavView = UIView()
        
        return topNavView
    }()
    
    private let plusButton = UIButton()
    private var plusImageView = UIImageView()
    private let datePicker = UIDatePicker()
    private let label = UILabel()
    private let hStack = UIStackView()
    private let searchBar = UISearchBar()
    private var stubView: UIStackView?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(topNavView)
        setupInitialState()
        setupUI()
    }
    
    // MARK: - UI
    private func setupUI() {
        setupTopNavView()
        setupSearchBar()
        setupConstraints()
        
        if !categories.isEmpty {
            showCollection()
        } else {
            stubView = getStubScreen(imageName: "star",
                                     text: "Что будем отслеживать?", view: self.view)
        }
        
    }
    
    private func setupTopNavView() {
        // plusButton
        plusImageView = UIImageView.init(image: UIImage(named: "iconPlus"))
        plusImageView.translatesAutoresizingMaskIntoConstraints = false
        plusButton.addSubview(plusImageView)
        plusButton.translatesAutoresizingMaskIntoConstraints = false
        
        plusButton.addTarget(self, action: #selector(self.plusButtonTapped(_:)), for: .touchUpInside)
        
        // datePicker
        var calendar = Calendar.current
        calendar.firstWeekday = 2  // Установка понедельника первым днем недели
        datePicker.calendar = calendar
        datePicker.preferredDatePickerStyle = .compact
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
        
        topNavView.addSubview(hStack)
        hStack.axis = .horizontal
        hStack.alignment = .center
        hStack.addArrangedSubview(plusButton)
        hStack.addArrangedSubview(datePicker)
        hStack.translatesAutoresizingMaskIntoConstraints = false
        
        topNavView.addSubview(label)
        label.text = "Трекеры"
        label.font = UIFont.systemFont(ofSize: 34, weight: .bold)
        label.textColor = UIColor(named: "Black [day]")
        label.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupSearchBar() {
        topNavView.addSubview(searchBar)
        topNavView.translatesAutoresizingMaskIntoConstraints = false
        
        searchBar.placeholder = "Поиск"
        searchBar.backgroundImage = UIImage() // убираем линии
        searchBar.delegate = self
        searchBar.showsCancelButton = false
        searchBar.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            plusImageView.widthAnchor.constraint(equalToConstant: 19),
            plusImageView.heightAnchor.constraint(equalToConstant: 19),
            plusImageView.centerXAnchor.constraint(equalTo: plusButton.centerXAnchor),
            plusImageView.centerYAnchor.constraint(equalTo: plusButton.centerYAnchor),
            plusButton.widthAnchor.constraint(equalToConstant: 42),
            plusButton.heightAnchor.constraint(equalToConstant: 42),
            
            hStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            hStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 6),
            hStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            hStack.heightAnchor.constraint(equalToConstant: 42),
            
            searchBar.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 7),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            label.topAnchor.constraint(equalTo: hStack.bottomAnchor, constant: 2),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            topNavView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            topNavView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            topNavView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            topNavView.bottomAnchor.constraint(equalTo: searchBar.bottomAnchor),
        ])
    }
    
    private func setupInitialState() {
        // Разбиение на категории
        categories = [
            TrackerCategory(categoryName: "Здоровье", trackers: [
                Tracker.mockList[0], // Пить воду
                Tracker.mockList[1], // Утренние упражнения
                Tracker.mockList[3]  // Медитация
            ]),
            
            TrackerCategory(categoryName: "Учеба", trackers: [
                Tracker.mockList[4] // Подготовка к экзаменам
            ]),
            
            TrackerCategory(categoryName: "Что-то еще", trackers: [
                Tracker.mockList[2], // Чтение книги
                Tracker.mockList[5]  // Прогулки на свежем воздухе
            ])
        ]
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
        
        let category = categories[0]
        let newTracker = Tracker(id: id, title: title, color: color, emoji: emoji, schedule: schedule, completedDays: completedDays)
        let updatedCategory = TrackerCategory(categoryName: category.categoryName,
                                              trackers: category.trackers + [newTracker])
        
        self.categories[0] = updatedCategory
        
        trackersCollectionVC.selectedDate = datePicker.date
        trackersCollectionVC.trackerCategories = self.categories
        trackersCollectionVC.collectionView.reloadData()
    }
    
    private func reloadVisibleCategories() {
        let selectedDate = datePicker.date
        let calendar = Calendar.current
        let filterWeekday = calendar.component(.weekday, from: selectedDate)
        let filterText = (searchBar.text ?? "").lowercased()
        
        visibleCategories = categories.compactMap { category in
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
        let formattedDate = selectedDate.formatted

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
