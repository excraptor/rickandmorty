//
//  CoordinatedViewController.swift
//  RickAndMorty
//
//  Created by Balla Tamás on 2022. 10. 13..
//

import Foundation
import UIKit

protocol CoordinatedViewController: UIViewController {
    var coordinator: MainCoordinator? { get set }
}
