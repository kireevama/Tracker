//
//  TrackerMock.swift
//  Tracker
//
//  Created by Marina Kireeva on 10.05.2025.
//

import UIKit

extension Tracker {
    static let mockList: [Tracker] = [
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
}
