//
//  TopicObject.swift
//  TenPercentHappier
//
//  Created by Damian on 6/14/22.
//

import Foundation
import RealmSwift

class TopicObject: Object {
    @objc dynamic var uuid = ""
    @objc dynamic var title = ""
    @objc dynamic var position = 0
    var meditations = List<String>()
    @objc dynamic var featured = false
    @objc dynamic var color = ""
    @objc dynamic var topicDescription = ""
}
