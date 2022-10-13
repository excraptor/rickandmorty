//
//  TabBarController.swift
//  RickAndMorty
//
//  Created by Balla Tamás on 2022. 10. 13..
//

import Foundation
import UIKit

class TabBarController: UITabBarController {
    
    var coordinator: MainCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        //coordinator = MainCoordinator(navigationController: navigationController!)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let characterTabVC = CharacterViewController()
        characterTabVC.coordinator = coordinator
        let characterTabItem = UITabBarItem(title: "Characters", image: UIImage(systemName: "person.3"), selectedImage: UIImage(systemName: "person.3.fill"))
        characterTabVC.tabBarItem = characterTabItem
        
        let favouritesTabVC = FavouritesViewController()
        favouritesTabVC.coordinator = coordinator
        let favouritesTabItem = UITabBarItem(title: "Favourites", image: UIImage(systemName: "bookmark"), selectedImage: UIImage(systemName: "bookmark.fill"))
        favouritesTabVC.tabBarItem = favouritesTabItem
        
        viewControllers = [characterTabVC, favouritesTabVC]
    }
}

extension TabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        //coordinator?.navigateTo(destination: viewController as! CoordinatedViewController)
        print("### navigateto: \(String(describing: viewController))")
    }
}
