//
//  Segues.swift
//  TenPercentHappier
//
//  Created by Damian on 6/12/22.
//

import Foundation

enum Segue {
    case subtopics(SubtopicsSegue)
}

enum SubtopicsSegue {
    case back
    case subtopics(topic: Topic, subtopics: [SubtopicData], meditations: [Meditation])
}
