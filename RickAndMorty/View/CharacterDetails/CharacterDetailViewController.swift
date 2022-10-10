//
//  CharacterDetailViewController.swift
//  RickAndMorty
//
//  Created by Balla Tamás on 2022. 10. 10..
//

import UIKit

class CharacterDetailViewController: UIViewController {

    @IBOutlet var image: UIImageView!
    @IBOutlet var name: UILabel!
    @IBOutlet var episodesTableView: UITableView!
    @IBOutlet var status: UILabel!
    @IBOutlet var species: UILabel!
    @IBOutlet var origin: UILabel!
    
    var episodes = ["episode1", "episode2", "episode3"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        episodesTableView.delegate = self
        episodesTableView.dataSource = self
    }
    
    public func configure(withData data: CharacterDetailData) {
        image.image = data.image
        name.text = data.name
        status.text = data.status
        species.text = data.species
        origin.text = data.origin.name
    }
}

extension CharacterDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
}

extension CharacterDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = episodes[indexPath.row]
        return cell
    }
}
