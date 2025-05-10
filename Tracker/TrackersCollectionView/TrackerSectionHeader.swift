//
//  TrackerSectionHeader.swift
//  Tracker
//
//  Created by Marina Kireeva on 03.05.2025.
//

import UIKit

final class TrackerSectionHeader: UICollectionReusableView {
        static let reuseIdentifier = "trackerSectionHeader"

        private let titleLabel = UILabel()

        override init(frame: CGRect) {
            super.init(frame: frame)
            setupUI()
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        private func setupUI() {
            addSubview(titleLabel)
            titleLabel.translatesAutoresizingMaskIntoConstraints = false
            titleLabel.font = UIFont.systemFont(ofSize: 19, weight: .bold)
            titleLabel.textColor = .label

            NSLayoutConstraint.activate([
                titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
                titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
            ])
        }

        func configure(with title: String) {
            titleLabel.text = title
        }
    }

