//
//  CharacterTableViewCell.swift
//  RickAndMorty
//
//  Created by Balla Tamás on 2022. 10. 10..
//

import UIKit

class CharacterTableViewCell: UITableViewCell {

    @IBOutlet var displayName: UILabel!
    @IBOutlet var status: UILabel!
    @IBOutlet var originName: UILabel!
    
    public func configure(withData data: CharacterListData) {
        displayName.text = data.name
        status.text = data.status
        originName.text = data.origin.name
    }
}
