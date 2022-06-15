//
//  Subtopic.swift
//  TenPercentHappier
//
//  Created by Damian on 6/12/22.
//

import Foundation
import RealmSwift

struct Subtopic: Decodable, Hashable {
    let uuid: String
    let parent_topic_uuid: String
    let title: String
    let position: Int
    let meditations: [String]
    
    init(uuid: String, parentTopicUUID: String, title: String, position: Int, meditations: [String]) {
        self.uuid = uuid
        self.parent_topic_uuid = parentTopicUUID
        self.title = title
        self.position = position
        self.meditations = meditations
    }
}

extension Subtopic {
    func toObject() -> Object {
        let object = SubtopicObject()
        object.uuid = uuid
        object.parent_topic_uuid = parent_topic_uuid
        object.title = title
        object.position = position
        meditations.forEach { object.meditations.append($0) }
        return object
    }
}
