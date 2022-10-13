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
    
    func start()
    func navigateTo(destination vc: CoordinatedViewController)
}

class MainCoordinator: Coordinator {
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let vc = TabBarController()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
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
    }
    
    func showDetails(forEpisode id: Int) {
        let vc = EpisodeDetailViewController()
        vc.id = id
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
}
