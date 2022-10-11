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
    
    private var characterData: Characters? {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Rick and Morty characters"
        
        tableView.delegate = self
        tableView.dataSource = self
        
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
}

extension CharacterViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let characterData = characterData else { return 0 }
        return characterData.results.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // TODO: refactor properly
        return 112.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let characterID = characterData?.results[indexPath.row].id
        coordinator?.showDetails(forCharacter: characterID!)
    }
}

extension CharacterViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "characterCell", for: indexPath) as! CharacterTableViewCell
        cell.selectionStyle = .blue
        guard let characterData = characterData else { return UITableViewCell()}
        let cellData = characterData.results[indexPath.row]
        cell.configure(withData: CharacterListData(name: cellData.name, status: cellData.status, origin: cellData.origin))
        return cell
    }
}
