//
//  MeditationObject.swift
//  TenPercentHappier
//
//  Created by Damian on 6/14/22.
//

import Foundation
import RealmSwift

class MeditationObject: Object {
    @objc dynamic var uuid = ""
    @objc dynamic var title = ""
    @objc dynamic var teacherName = ""
    @objc dynamic var imageURL = ""
    @objc dynamic var playCount = 0
}
