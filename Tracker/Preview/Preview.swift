//
//  Preview.swift
//  Tracker
//
//  Created by Marina Kireeva on 01.05.2025.
//

import SwiftUI
import UIKit

// Обертка для предпросмотра UIViewController
struct CreateTrackerViewControllerWrapper: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> TrackersViewController {
        return TrackersViewController()
    }

    func updateUIViewController(_ uiViewController: TrackersViewController, context: Context) {}
}

struct CreateTrackerViewController_Previews: PreviewProvider {
    static var previews: some View {
        CreateTrackerViewControllerWrapper()
            .edgesIgnoringSafeArea(.all)
    }
}



