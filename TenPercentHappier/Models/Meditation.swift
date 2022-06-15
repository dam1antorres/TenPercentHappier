//
//  Meditation.swift
//  TenPercentHappier
//
//  Created by Damian on 6/12/22.
//

import Foundation
import RealmSwift

struct Meditation: Decodable {
    let uuid: String
    let title: String
    let teacherName: String
    let imageURL: String
    let playCount: Int?
    
    public enum CodingKeys: String, CodingKey {
        case uuid
        case title
        case teacherName = "teacher_name"
        case imageURL = "image_url"
        case playCount = "play_count"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        uuid = try values.decode(String.self, forKey: .uuid)
        title = try values.decode(String.self, forKey: .title)
        teacherName = try values.decode(String.self, forKey: .teacherName)
        imageURL = try values.decode(String.self, forKey: .imageURL)
        playCount = try? values.decodeIfPresent(Int.self, forKey: .playCount) ?? 0
    }
    
    init(uuid: String, title: String, teacherName: String, imageURL: String, playCount: Int?) {
        self.uuid = uuid
        self.title = title
        self.teacherName = teacherName
        self.imageURL = imageURL
        self.playCount = playCount
    }
}

extension Meditation {
    func toObject() -> Object {
        let object = MeditationObject()
        object.uuid = uuid
        object.title = title
        object.teacherName = teacherName
        object.imageURL = imageURL
        object.playCount = playCount ?? 0
        return object
    }
}
