//
//  TopicCellViewModel.swift
//  TenPercentHappier
//
//  Created by Damian on 6/12/22.
//

import Foundation
import UIKit

class TopicCellViewModel {
    
    private let topic: Topic
    
    init(topic: Topic) {
        self.topic = topic
    }
    
    var title: String {
        topic.title
    }
    
    var numOfMeditations: String {
        "\(topic.meditations.count) Meditations"
    }
    
    var barColor: UIColor {
        UIColor(hex: topic.color) ?? .black
    }

}
