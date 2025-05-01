//
//  HabitTableViewCell.swift
//  Tracker
//
//  Created by Marina Kireeva on 30.04.2025.
//

import UIKit

class HabitTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    static let cellReuseIdentifier = "habitTableViewCell"
    
    let titleLabel = UILabel()
    let valueLabel = UILabel()
    let cellImageView = UIImageView()
    let separatorView = UIView()
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: HabitTableViewCell.cellReuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI
    private func setupUI() {
        
        // titleLabel
        contentView.addSubview(titleLabel)
        titleLabel.font = .systemFont(ofSize: 17, weight: .regular)
        titleLabel.textColor = UIColor(named: "Black [day]")
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // valueLabel
        contentView.addSubview(valueLabel)
        valueLabel.font = .systemFont(ofSize: 17, weight: .regular)
        valueLabel.textColor = UIColor(named: "Gray")
        valueLabel.textAlignment = .center
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // imageView
        cellImageView.image = UIImage(named: "Chevron")
        cellImageView.translatesAutoresizingMaskIntoConstraints = false
        
        
        // vStack
        let vStack = UIStackView(arrangedSubviews: [titleLabel, valueLabel])
        vStack.axis = .vertical
        vStack.alignment = .leading
        vStack.spacing = 2
        vStack.translatesAutoresizingMaskIntoConstraints = false
        
        // hStack
        let hStack = UIStackView(arrangedSubviews: [vStack, cellImageView])
        contentView.addSubview(hStack)
        hStack.axis = .horizontal
        hStack.alignment = .center
        hStack.translatesAutoresizingMaskIntoConstraints = false
        
        // separatorView
        contentView.addSubview(separatorView)
        separatorView.backgroundColor = UIColor(named: "Gray")
        separatorView.translatesAutoresizingMaskIntoConstraints = false
            
            
        
        NSLayoutConstraint.activate([
            cellImageView.heightAnchor.constraint(equalToConstant: 24),
            cellImageView.widthAnchor.constraint(equalToConstant: 24),
            
            vStack.widthAnchor.constraint(lessThanOrEqualToConstant: 270),
            hStack.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            hStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            hStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            separatorView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            separatorView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            separatorView.topAnchor.constraint(equalTo: contentView.topAnchor),
            separatorView.heightAnchor.constraint(equalToConstant: 0.5)
        ])
    }
    
    // MARK: - Metods
    func configure(title: String, value: String?, isShowseparator: Bool) {
        titleLabel.text = title
        
        if value == nil { valueLabel.isHidden = true
        } else {
            valueLabel.text = value
        }
        
        if !isShowseparator {
            separatorView.isHidden = true
        }
    }
    
}
