//
//  CharacterDetailViewController.swift
//  RickAndMorty
//
//  Created by Balla Tamás on 2022. 10. 10..
//

import UIKit

class CharacterDetailViewController: UIViewController {
    
    public weak var coordinator: MainCoordinator?
    private var viewModel: CharacterViewModel = CharacterViewModel()
    public var id: Int = 0

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
        
        viewModel.getSingleCharacterFromApi(withID: id) { [self] data in
            configure(withData: CharacterDetailData(name: data.name, status: data.status, species: data.species, origin: data.origin, imageURL: data.image))
        }
    }
    
    public func configure(withData data: CharacterDetailData) {
        viewModel.getImage(fromUrl: data.imageURL) { imageData in
            DispatchQueue.main.async {
                self.image.image = imageData
            }
        }
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
