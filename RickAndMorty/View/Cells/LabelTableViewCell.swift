//
//  LabelTableViewCell.swift
//  RickAndMorty
//
//  Created by Balla Tamás on 2022. 10. 13..
//

import UIKit

class LabelTableViewCell: UITableViewCell {

   
    @IBOutlet var label: UILabel!
    
    override class func awakeFromNib() {
        super.awakeFromNib()
        
        
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame.size.width = UIScreen.main.bounds.width
        self.contentView.layoutIfNeeded()
    }
    
}
