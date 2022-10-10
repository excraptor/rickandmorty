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
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .cyan
        
        tableView.register(UINib(nibName: "CharacterTableViewCell", bundle: nil), forCellReuseIdentifier: "characterCell")
        
        updateUI()
    }
    
    private func updateUI() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension CharacterViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
}

extension CharacterViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "characterCell", for: indexPath) as! CharacterTableViewCell
        cell.selectionStyle = .blue
        cell.displayName.text = "Test name"
        return cell
    }
}
