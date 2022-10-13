//
//  CharactersViewController.swift
//  RickAndMorty
//
//  Created by Balla Tamás on 2022. 10. 10..
//

import Foundation
import UIKit

class CharacterViewController: UIViewController {
    
    private var characterViewModel: CharacterViewModel = CharacterViewModel()
    public weak var coordinator: MainCoordinator?
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    
    private var characterData: Characters? {
        didSet {
            characters = characterData?.results
        }
    }
    private var characters: [CharacterModel]? {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Rick and Morty characters"
        
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        
        let sortMenu = initSortMenu()
        let sortButton = UIBarButtonItem(title: "Menu", image: UIImage(systemName: "list.bullet"), primaryAction: nil, menu: sortMenu)
        sortButton.tintColor = .gray
        navigationItem.rightBarButtonItem = sortButton
        

        
        tableView.register(UINib(nibName: "CharacterTableViewCell", bundle: nil), forCellReuseIdentifier: "characterCell")
        
        characterViewModel.getCharactersFromApi() { [self] data in
            characterData = data
        }
        
        updateUI()
    }
    
    private func updateUI() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.tableView.invalidateIntrinsicContentSize()
        }
    }
    
    private func navigateToDetail() {
        // TODO: implement - but rather implement Coordinator pattern
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
        if ascending {
            characters?.sort() { $0.name < $1.name}
        } else {
            characters?.sort() { $0.name > $1.name}
        }
        updateUI()
    }
    
}

extension CharacterViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let characters = characters else { return 0 }
        return characters.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // TODO: refactor properly
        return 112.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let characterID = characters?[indexPath.row].id
        coordinator?.showDetails(forCharacter: characterID!)
    }
}

extension CharacterViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "characterCell", for: indexPath) as! CharacterTableViewCell
        cell.selectionStyle = .blue
        guard let characters = characters else { return UITableViewCell()}
        let cellData = characters[indexPath.row]
        cell.configure(withData: CharacterListData(name: cellData.name, status: cellData.status, origin: cellData.origin))
        return cell
    }
}

extension CharacterViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        characters = searchText.isEmpty ? characterData?.results : characters?.filter { $0.name.contains(searchText) }
        tableView.reloadData()
    }
}
