//
//  SubtopicObject.swift
//  TenPercentHappier
//
//  Created by Damian on 6/14/22.
//

import Foundation
import RealmSwift

class SubtopicObject: Object {
    @objc dynamic var uuid = ""
    @objc dynamic var parent_topic_uuid = ""
    @objc dynamic var title = ""
    @objc dynamic var position = 0
    var meditations = List<String>()
}
