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
    var viewModel: CharacterViewModel = CharacterViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        //coordinator = MainCoordinator(navigationController: navigationController!)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let sortMenu = initSortMenu()
        let sortButton = UIBarButtonItem(title: "Menu", image: UIImage(systemName: "list.bullet"), primaryAction: nil, menu: sortMenu)
        sortButton.tintColor = .gray
        navigationItem.rightBarButtonItem = sortButton
        
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
    
    private func initSortMenu() -> UIMenu {
        
        var menuItems: [UIAction] {
            return [
                UIAction(title: "Name ascendig", image: UIImage(systemName: "arrow.down"), handler: { _ in
                    self.sort(ascending: true)
                }),
                UIAction(title: "Name descending", image: UIImage(systemName: "arrow.up"), handler: { _ in
                    self.sort(ascending: false)
                }),
            ]
        }

        var sortMenu: UIMenu {
            return UIMenu(title: "Sort", image: nil, identifier: nil, options: [], children: menuItems)
        }
        return sortMenu
    }
    
    @objc private func sort(ascending: Bool) {
        let characterViewController = (viewControllers![0] as! CharacterViewController)
        if ascending {
            characterViewController.characters?.sort() { $0.name < $1.name}
        } else {
            characterViewController.characters?.sort() { $0.name > $1.name}
        }
        characterViewController.updateUI()
    }
}

extension TabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        //coordinator?.navigateTo(destination: viewController as! CoordinatedViewController)
        print("### navigateto: \(String(describing: viewController))")
    }
}
