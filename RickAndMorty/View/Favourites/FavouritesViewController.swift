//
//  FavouritesViewController.swift
//  RickAndMorty
//
//  Created by Balla Tamás on 2022. 10. 13..
//

import UIKit

class FavouritesViewController: UIViewController, CoordinatedViewController, HasCharacters {
    
    var coordinator: MainCoordinator?
    var viewModel: CharacterViewModel = CharacterViewModel()
    
    @IBOutlet var tableView: UITableView!
    
    var characters: [CharacterModel]? {
        didSet {
            if let favourites = characters, favourites.isEmpty {
                tableView.setNoDataPlaceholder("You don't have any favourite characters yet.")
            } else {
                tableView.removeNoDataPlaceholder()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "LabelTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        
        characters = viewModel.getFavourites()
    }
    
    public func updateUI() {
        tableView.reloadData()
    }

}

extension FavouritesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters?.count ?? 0
    }
}

extension FavouritesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! LabelTableViewCell
        cell.accessibilityTraits = UIAccessibilityTraits.button
        guard let favourites = characters else { return cell }
        cell.label.text = favourites[indexPath.row].name
        cell.accessibilityHint = "View details for \(favourites[indexPath.row].name), or swipe left to remove from favourites"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let favourites = characters else { return }
        let characterId = favourites[indexPath.row].id
        coordinator?.showDetails(forCharacter: Int(characterId))
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let favourites = characters else { return }
            viewModel.removeCharacter(id: Int(favourites[indexPath.row].id))
            self.characters!.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

