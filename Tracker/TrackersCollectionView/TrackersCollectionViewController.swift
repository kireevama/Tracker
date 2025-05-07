//
//  TrackersCollectionViewController.swift
//  Tracker
//
//  Created by Marina Kireeva on 02.05.2025.
//

import UIKit

class TrackersCollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var selectedDate = Date()
    var trackerCategories: [TrackerCategory]? = nil
    private var completedTrackers: [TrackerRecord] = []
//    private var trackerId: UUID?
    
    private let layout = UICollectionViewFlowLayout()
    lazy var collectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.cellReuseIdentifier)
        collectionView.register(TrackerSectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: TrackerSectionHeader.reuseIdentifier)

    }

    private func setupUI() {
        
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 7
        let itemSize = getItemSize()
        layout.itemSize = CGSize(width: itemSize, height: itemSize - 19)
        layout.sectionInset = UIEdgeInsets(top: 12, left: 0, bottom: 0, right: 0)
        
        view.addSubview(collectionView)
       
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 16),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
        ])
    }
    
    private func getItemSize() -> CGFloat {
        let padding: CGFloat = 16
        let spacing: CGFloat = 7
        let itemSize = (view.bounds.width - padding * 2 - spacing) / 2
        
        return itemSize
    }
    

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        trackerCategories?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        trackerCategories?[section].trackers.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.cellReuseIdentifier, for: indexPath) as? CollectionViewCell,
                  let tracker = trackerCategories?[indexPath.section].trackers[indexPath.item] else {
            print("TrackersCollectionViewController: error creating a cell \(indexPath)")

                return UICollectionViewCell()
            }
        
        let isCompletedToday = isTrackerCompletedToday(id: tracker.id)
        let completedDays = completedTrackers.filter { $0.id == tracker.id }.count
        
        cell.configure(with: tracker,
                       isCompletedToday: isCompletedToday,
                       completedDays: completedDays,
                       indexPath: indexPath)
        
        cell.delegate = self
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader,
                  let header = collectionView.dequeueReusableSupplementaryView(
                    ofKind: kind,
                    withReuseIdentifier: TrackerSectionHeader.reuseIdentifier,
                    for: indexPath) as? TrackerSectionHeader,
                  let title = trackerCategories?[indexPath.section].categoryName else {
                return UICollectionReusableView()
            }

            header.configure(with: title)
        
            return header
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int) -> CGSize {
        let itemSize = getItemSize()
        return CGSize(width: itemSize, height: 18)
    }
    
    private func isTrackerCompletedToday(id: UUID) -> Bool {
        completedTrackers.contains { trackerRecord in
            let isSameDate = Calendar.current.isDate(trackerRecord.date, inSameDayAs: selectedDate)
            return trackerRecord.id == id && isSameDate
        }
    }
    
    
}

extension TrackersCollectionViewController: TrackerCellDelegate {
    func completedTracker(id: UUID, at indexPath: IndexPath) {
        let trackerRecord = TrackerRecord(id: id, date: selectedDate)
        completedTrackers.append(trackerRecord)
        
        collectionView.reloadItems(at: [indexPath])
    }
    
    func uncompletedTracker(id: UUID, at indexPath: IndexPath) {
        completedTrackers.removeAll { trackerRecord in
            let isSameDate = Calendar.current.isDate(trackerRecord.date, inSameDayAs: selectedDate)
            return trackerRecord.id == id && isSameDate
        }
        
        collectionView.reloadItems(at: [indexPath])
    }
}
