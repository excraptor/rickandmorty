//
//  PlaceholderViewController.swift
//  RickAndMorty
//
//  Created by Balla Tamás on 2022. 10. 14..
//

import UIKit

class PlaceholderViewController: UIViewController {
    
    let placeholderImage: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        imageView.image = UIImage(named: "rickandmorty")
        imageView.contentMode = .scaleAspectFill
        imageView.alpha = 0.2
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.placeholderImage.backgroundColor = .green
        
        view.addSubview(placeholderImage)
        view.sendSubviewToBack(placeholderImage)
    }
}
