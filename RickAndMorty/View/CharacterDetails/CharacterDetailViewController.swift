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
    
    var episodeUrls: [String] = [] {
        didSet {
            viewModel.getEpisodes(urls: episodeUrls) { data in
                self.episodes = data
            }
        }
    }
    var episodes: [EpisodeModel]? {
        didSet {
            episodesTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        episodesTableView.delegate = self
        episodesTableView.dataSource = self
        
        title = "Character details"
        
        viewModel.getSingleCharacterFromApi(withID: id) { [self] data in
            DispatchQueue.main.async {
                self.configure(withData: CharacterDetailData(name: data.name, status: data.status, species: data.species, origin: data.origin, imageURL: data.image))
                self.episodeUrls = data.episode
            }
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
        return episodes?.count ?? 0
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        coordinator?.showDetails(forEpisode: episodes![indexPath.row].id)
    }
}

extension CharacterDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "Loading..."
        guard let episodes = episodes else { return cell }
        cell.textLabel?.text = episodes[indexPath.row].name
        return cell
    }
}
