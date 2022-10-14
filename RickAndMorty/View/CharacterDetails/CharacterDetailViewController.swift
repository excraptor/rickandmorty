//
//  CharacterDetailViewController.swift
//  RickAndMorty
//
//  Created by Balla Tamás on 2022. 10. 10..
//

import UIKit

class CharacterDetailViewController: UIViewController, CoordinatedViewController {
    
    public weak var coordinator: MainCoordinator?
    private var viewModel: CharacterViewModel = CharacterViewModel()
    public var id: Int = 0
    private var characterModel: CharacterModel?

    @IBOutlet var image: UIImageView!
    @IBOutlet var name: UILabel!
    @IBOutlet var episodesTableView: UITableView!
    @IBOutlet var status: UILabel!
    @IBOutlet var species: UILabel!
    @IBOutlet var origin: UILabel!
    @IBOutlet var scroller: UIScrollView!
    
    private var isFavourite: Bool = false {
        didSet {
            navigationItem.rightBarButtonItem!.image = isFavourite ? UIImage(systemName: "heart.fill") :  UIImage(systemName: "heart")
        }
    }
    
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
        scroller.isScrollEnabled = true
        let screenBounds = UIScreen.main.bounds
        
        let contentRect: CGRect = scroller.subviews.reduce(into: .zero) { rect, view in
            rect = rect.union(view.frame)
        }
        let heightDiff = abs(contentRect.size.height - screenBounds.height)
        let scrollViewHeight = heightDiff > 400 ? contentRect.size.height : contentRect.size.height + (400-heightDiff)
        scroller.contentSize = CGSize(width: UIScreen.main.bounds.width, height: scrollViewHeight)
        
        title = "Character details"
        let favouritesButton = UIBarButtonItem(image: UIImage(systemName: "heart"), style: .plain, target: self, action: #selector(favouritesPressed))
        favouritesButton.tintColor = .red
        navigationItem.rightBarButtonItem = favouritesButton
        isFavourite = viewModel.isFavourite(id: id)
        
        viewModel.getSingleCharacterFromApi(withID: id) { [self] data in
            DispatchQueue.main.async {
                self.characterModel = data
                self.configure(withData: CharacterDetailData(name: data.name, status: data.status!, species: data.species!, origin: data.origin!, imageURL: data.image!))
                self.episodeUrls = data.episode!
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
    
    @objc private func favouritesPressed() {
        guard let characterModel = characterModel else { return }

        isFavourite.toggle()
        viewModel.toggleFavourite(character: characterModel, isFavourite: isFavourite)
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
        guard let episodes = episodes else { return cell }
        cell.textLabel?.text = episodes[indexPath.row].name
        return cell
    }
}
