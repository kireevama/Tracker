//
//  CollectionViewCell.swift
//  Tracker
//
//  Created by Marina Kireeva on 02.05.2025.
//

import UIKit

protocol TrackerCellDelegate: AnyObject {
    func completedTracker(id: UUID, at indexPath: IndexPath)
    func uncompletedTracker(id: UUID, at indexPath: IndexPath)
}

final class CollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    static let cellReuseIdentifier = "trackerCollectionViewCell"
    private let emojiLabel = UILabel()
    private let titleLabel = UILabel()
    private let dayCountLabel = UILabel()
    private let plusButton = UIButton()
    private let backgroundCardView = UIView()
    
    weak var delegate: TrackerCellDelegate?
    private var isCompletedToday = false
    private var trackerId: UUID?
    private var indexPath: IndexPath?
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI
    private func setupUI() {
        // emojiLabel
        emojiLabel.textAlignment = .center
        emojiLabel.layer.cornerRadius = 12
        emojiLabel.layer.masksToBounds = true
        emojiLabel.backgroundColor = UIColor(named: "White [alpha 30]")
        emojiLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // titleLabel
        titleLabel.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        titleLabel.textColor = UIColor(named: "White [day]")
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 2
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // backgroundCardView
        contentView.addSubview(backgroundCardView)
        backgroundCardView.translatesAutoresizingMaskIntoConstraints = false
        backgroundCardView.addSubview(emojiLabel)
        backgroundCardView.addSubview(titleLabel)
        backgroundCardView.clipsToBounds = true
        backgroundCardView.layer.cornerRadius = 16
        
        // dayCountLabel
        dayCountLabel.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        dayCountLabel.textColor = UIColor(named: "Black [day]")
        dayCountLabel.textAlignment = .left
        dayCountLabel.numberOfLines = 1
        dayCountLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // plusButton
        plusButton.layer.cornerRadius = 17
        plusButton.clipsToBounds = true
        plusButton.backgroundColor = UIColor(named: "White [day]")
        plusButton.translatesAutoresizingMaskIntoConstraints = false
        plusButton.addTarget(self, action: #selector(trackButtonTapped), for: .touchUpInside)
        
        // hStack
        let hStack = UIStackView()
        hStack.addArrangedSubview(dayCountLabel)
        hStack.addArrangedSubview(plusButton)
        hStack.axis = .horizontal
        hStack.alignment = .center
        hStack.translatesAutoresizingMaskIntoConstraints = false
        
        // mainStack
        let mainStack = UIStackView()
        mainStack.addArrangedSubview(backgroundCardView)
        mainStack.addArrangedSubview(hStack)
        contentView.addSubview(mainStack)
        mainStack.axis = .vertical
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            backgroundCardView.topAnchor.constraint(equalTo: contentView.topAnchor),
            backgroundCardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            backgroundCardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            backgroundCardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -58),
            
            emojiLabel.heightAnchor.constraint(equalToConstant: 24),
            emojiLabel.widthAnchor.constraint(equalToConstant: 24),
            emojiLabel.topAnchor.constraint(equalTo: backgroundCardView.topAnchor, constant: 12),
            emojiLabel.leadingAnchor.constraint(equalTo: backgroundCardView.leadingAnchor, constant: 12),
            
            titleLabel.leadingAnchor.constraint(equalTo: backgroundCardView.leadingAnchor, constant: 12),
            titleLabel.bottomAnchor.constraint(equalTo: backgroundCardView.bottomAnchor, constant: -12),
            
            plusButton.centerYAnchor.constraint(equalTo: hStack.centerYAnchor),
            plusButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            plusButton.widthAnchor.constraint(equalToConstant: 34),
            plusButton.heightAnchor.constraint(equalToConstant: 34),
            dayCountLabel.leadingAnchor.constraint(equalTo: hStack.leadingAnchor, constant: 0),
            dayCountLabel.centerYAnchor.constraint(equalTo: hStack.centerYAnchor),
            
            hStack.topAnchor.constraint(equalTo: backgroundCardView.bottomAnchor, constant: 0),
            hStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            hStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            hStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            
            mainStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            mainStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            mainStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            mainStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            
        ])
    }
    
    // MARK: - Properties
    
    func configure(with tracker: Tracker, isCompletedToday: Bool, completedDays: Int ,indexPath: IndexPath) {
        titleLabel.text = tracker.title
        backgroundCardView.backgroundColor = tracker.color
        plusButton.tintColor = tracker.color
        emojiLabel.text = tracker.emoji
        dayCountLabel.text = "\(completedDays) \(getDayLabel(for: completedDays))"
        
        self.isCompletedToday = isCompletedToday
        self.indexPath = indexPath
        self.trackerId = tracker.id
        
        if isCompletedToday {
            plusButton.backgroundColor = tracker.color
            plusButton.alpha = 0.3
            plusButton.setImage(UIImage(named: "DoneButton"), for: .normal)
        } else {
            plusButton.backgroundColor = UIColor(named: "White [day]")
            plusButton.alpha = 1
            plusButton.setImage(UIImage(named: "PropertyPlus")?.withRenderingMode(.alwaysTemplate), for: .normal)
        }
        
    }
    
    
    private func getDayLabel(for days: Int) -> String {
        switch days {
        case 1: return "день"
        case 2...4: return "дня"
        default: return "дней"
        }
    }
    
    @objc private func trackButtonTapped() {
        guard let trackerId = trackerId,
        let indexPath = indexPath
        else {
            assertionFailure("CollectionViewCell: not received trackerId or indexPath")
            return }
        
        if isCompletedToday {
            delegate?.uncompletedTracker(id: trackerId, at: indexPath)
        } else {
            delegate?.completedTracker(id: trackerId, at: indexPath)
        }
    }
    
    
}


