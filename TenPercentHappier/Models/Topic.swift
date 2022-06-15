//
//  Topic.swift
//  TenPercentHappier
//
//  Created by Damian on 6/12/22.
//

import Foundation

struct Topic: Decodable {
    let uuid: String
    let title: String
    let position: Int
    let meditations: [String]
    let featured: Bool
    let color: String
    let description: String
    
    init(uuid: String,
         title: String,
         position: Int,
         meditations: [String],
         featured: Bool,
         color: String,
         description: String) {
        self.uuid = uuid
        self.title = title
        self.position = position
        self.meditations = meditations
        self.featured = featured
        self.color = color
        self.description = description
    }
}

extension Topic {
    func toObject() -> TopicObject {
        let object = TopicObject()
        object.uuid = uuid
        object.title = title
        object.position = position
        meditations.forEach { object.meditations.append($0) }
        object.featured = featured
        object.color = color
        object.topicDescription = description
        return object
    }
}
