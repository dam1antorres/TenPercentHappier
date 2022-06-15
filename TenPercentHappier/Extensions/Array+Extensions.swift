//
//  Array+Extensions.swift
//  TenPercentHappier
//
//  Created by Damian on 6/14/22.
//

import Foundation
import RealmSwift
import Realm

extension Results where Element: TopicObject {
    func toModelArray() -> [Topic] {
        self.map { Topic(uuid: $0.uuid, title: $0.title, position: $0.position, meditations: $0.meditations.map { $0 }, featured: $0.featured, color: $0.color, description: $0.topicDescription) }
    }
}

extension Results where Element == SubtopicObject {
    func toModelArray() -> [Subtopic] {
        self.map { Subtopic(uuid: $0.uuid, parentTopicUUID: $0.parent_topic_uuid, title: $0.title, position: $0.position, meditations: $0.meditations.map { $0 }) }
    }
}

extension Results where Element == MeditationObject {
    func toModelArray() -> [Meditation] {
        self.map { Meditation(uuid: $0.uuid, title: $0.title, teacherName: $0.teacherName, imageURL: $0.imageURL, playCount: $0.playCount) }
    }
}
