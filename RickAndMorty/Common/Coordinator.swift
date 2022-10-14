//
//  Coordinator.swift
//  RickAndMorty
//
//  Created by Balla Tamás on 2022. 10. 11..
//

import Foundation
import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set }
    
    func start() -> TabBarController
    func navigateTo(destination vc: CoordinatedViewController)
}

class MainCoordinator: Coordinator {
    var navigationController: UINavigationController
    var splitViewController: UISplitViewController

    init(navigationController: UINavigationController, splitViewController: UISplitViewController) {
        self.navigationController = navigationController
        self.splitViewController = splitViewController
    }

    func start() -> TabBarController {
        let vc = TabBarController()
        vc.coordinator = self
        return vc
    }
    
    func navigateTo(destination vc: CoordinatedViewController) {
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func showDetails(forCharacter id: Int) {
        let vc = CharacterDetailViewController()
        vc.id = id
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
        if splitViewController.viewControllers.count == 2 {
            splitViewController.viewControllers[1]  = navigationController
        }
    }
    
    func showDetails(forEpisode id: Int) {
        let vc = EpisodeDetailViewController()
        vc.id = id
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
}
