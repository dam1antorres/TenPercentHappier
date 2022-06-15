//
//  Coordinating.swift
//  TenPercentHappier
//
//  Created by Damian on 6/12/22.
//

import Foundation

import Foundation
import UIKit

protocol Coordinating {
    func launch(in window: UIWindow)
    func handleSegue(_ segue: Segue)
}
