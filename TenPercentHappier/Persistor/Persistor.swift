//
//  Persistor.swift
//  TenPercentHappier
//
//  Created by Damian on 6/14/22.
//

import Foundation
import RealmSwift

class Persistor {
    
    let realm = try! Realm()
    
    lazy var persistedTopics: Results<TopicObject> = { self.realm.objects(TopicObject.self) }()
    lazy var persistedSubtopics: Results<SubtopicObject> = { self.realm.objects(SubtopicObject.self) }()
    lazy var persistedMeditations: Results<MeditationObject> = { self.realm.objects(MeditationObject.self) }()
    
    func saveTopics(_ topics: [Topic]) {
        try! realm.write {
            if persistedTopics.isEmpty {
                topics.forEach { realm.add($0.toObject()) }
            }
        }
    }
    
    func saveSubtopics(_ subtopics: [Subtopic]) {
        try! realm.write {
            if persistedSubtopics.isEmpty {
                subtopics.forEach { realm.add($0.toObject()) }
            }
        }
    }
    
    func saveMeditations(_ meditations: [Meditation]) {
        try! realm.write {
            if persistedMeditations.isEmpty {
                meditations.forEach { realm.add($0.toObject()) }
            }
        }
    }
    
    
}
