//
//  Coordinator.swift
//  TenPercentHappier
//
//  Created by Damian on 6/12/22.
//

import Foundation
import UIKit

class Coordinator: Coordinating {

    private var contentViewController: UIViewController?
    private var mainNavigationController: UINavigationController? {
        return contentViewController as? UINavigationController
    }

    func launch(in window: UIWindow) {
        setupAppearance()
        contentViewController = UINavigationController(rootViewController: TopicsViewController(viewModel: TopicsViewModel(coordinator: self)))
        window.rootViewController = contentViewController
    }

    private func setupAppearance() {
        let navBarAppearance = UINavigationBar.appearance(whenContainedInInstancesOf: [UINavigationController.self])
        navBarAppearance.prefersLargeTitles = false
        navBarAppearance.isTranslucent = true
        navBarAppearance.setBackgroundImage(UIImage(), for: .default)
        navBarAppearance.barTintColor = .white
        navBarAppearance.shadowImage = UIImage()
        navBarAppearance.backIndicatorImage = UIImage(systemName: "chevron.left")?.withRenderingMode(.alwaysOriginal)
    }

    func handleSegue(_ segue: Segue) {
        switch segue {
        case .subtopics(let segue): handleSubtopicsSegue(segue)
        }
    }
    
    private func handleSubtopicsSegue(_ segue: SubtopicsSegue) {
        switch segue {
        case .subtopics(let topic, let subtopicData, let meditations):
            showSubtopicsScreen(with: topic, subtopicData, meditations)
        case .back:
            mainNavigationController?.popViewController(animated: true)
        }
    }
    
    private func showSubtopicsScreen(with topic: Topic, _ subtopicData: [SubtopicData], _ meditations: [Meditation]) {
        let viewModel = SubtopicsViewModel(topic: topic, subtopicsData: subtopicData, meditations: meditations, coordinator: self)
        let viewController = SubtopicsViewController(viewModel: viewModel)
        mainNavigationController?.pushViewController(viewController, animated: true)
    }

}

