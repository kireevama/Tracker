//
//  Tracker.swift
//  Tracker
//
//  Created by Marina Kireeva on 25.04.2025.
//

import UIKit

struct Tracker {
    let id: UUID
    let title: String
    let color: UIColor
    let emoji: String
    let schedule: Set<WeekDay>?
    let completedDays: Int
}
