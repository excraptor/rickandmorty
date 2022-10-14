//
//  EpisodeDetailViewController.swift
//  RickAndMorty
//
//  Created by Balla Tamás on 2022. 10. 11..
//

import Foundation
import UIKit

class EpisodeDetailViewController: UIViewController {

    public weak var coordinator: MainCoordinator?
    private let viewModel: EpisodeViewModel = EpisodeViewModel()
    public var id: Int = 0
    private var characterUrls: [String] = [] {
        didSet {
            viewModel.getCharacters(fromUrls: characterUrls) { characters in
                self.characters = characters
            }
        }
    }
    private var characters: [CharacterModel]? {
        didSet {
            charactersTableView.reloadData()
        }
    }
    
    
    @IBOutlet var airDate: UILabel!
    @IBOutlet var episodeTitle: UILabel!
    @IBOutlet var charactersTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        charactersTableView.delegate = self
        charactersTableView.dataSource = self
        
        title = "Episode details"
    
        viewModel.getEpisodeDetails(id: id) { episode in
            DispatchQueue.main.async {
                self.configure(withData: episode)
                self.id = episode.id
            }
            
        }
    }
    
    private func configure(withData episode: EpisodeModel) {
        let title = "\(episode.name) - \(episode.episode)"
        episodeTitle.text = title
        airDate.text = episode.airDate
        characterUrls = episode.characters
    }
}

extension EpisodeDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let characters = characters else { return  }
        coordinator?.showDetails(forCharacter: characters[indexPath.row].id)
    }
}

extension EpisodeDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.accessibilityTraits = UIAccessibilityTraits.button
        guard let characters = characters else { return UITableViewCell() }
        cell.accessibilityHint = "View details for \(characters[indexPath.row].name)"
        cell.textLabel?.text = characters[indexPath.row].name
        return cell
    }
}
