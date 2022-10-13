//
//  FavouritesViewController.swift
//  RickAndMorty
//
//  Created by Balla Tamás on 2022. 10. 13..
//

import UIKit

class FavouritesViewController: UIViewController, CoordinatedViewController {
    var coordinator: MainCoordinator?
    var viewModel: CharacterViewModel = CharacterViewModel()
    
    @IBOutlet var tableView: UITableView!
    
    var favourites: [Character]? {
        didSet {
            if let favourites = favourites, favourites.isEmpty {
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
        
        favourites = viewModel.getFavourites()
    }
    
    @objc func removeFromFavourites() {
        print("removed something...")
    }

}

extension FavouritesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favourites?.count ?? 0
    }
}

extension FavouritesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! LabelTableViewCell
        guard let favourites = favourites else { return cell }
        cell.label.text = favourites[indexPath.row].name
        cell.labelIcon.image = UIImage(systemName: "trash")
        let tapGesture = UITapGestureRecognizer (target: self, action: #selector(removeFromFavourites))
        cell.labelIcon.addGestureRecognizer(tapGesture)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let favourites = favourites else { return }
        let characterId = favourites[indexPath.row].id
        coordinator?.showDetails(forCharacter: Int(characterId))
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            guard let favourites = favourites else { return }
            viewModel.removeCharacter(id: Int(favourites[indexPath.row].id))
            self.favourites!.remove(at: indexPath.row)
            print("### favourites.count = \(favourites.count)")
            // Then, delete the row from the table itself
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

