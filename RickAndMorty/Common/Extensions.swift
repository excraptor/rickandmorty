//
//  Extensions.swift
//  RickAndMorty
//
//  Created by Balla Tamás on 2022. 10. 13..
//

import Foundation
import UIKit

extension UITableView {
    func setNoDataPlaceholder(_ message: String) {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        label.text = message
        label.sizeToFit()
        label.textAlignment = .center
        label.textColor = .gray
        label.numberOfLines = 0

        self.isScrollEnabled = false
        self.backgroundView = label
        self.separatorStyle = .none
    }
    
    func removeNoDataPlaceholder() {
            self.isScrollEnabled = true
            self.backgroundView = nil
            self.separatorStyle = .singleLine
        }
}
