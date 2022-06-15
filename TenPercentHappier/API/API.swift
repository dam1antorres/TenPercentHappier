//
//  API.swift
//  TenPercentHappier
//
//  Created by Damian on 6/12/22.
//

import Foundation

import Foundation

class API {

    enum APIError: LocalizedError {
        case invalidUrl
        case unknownError
    }

    struct Constants {
        static let topics = "https://tenpercent-interview-project.s3.amazonaws.com/topics.json"
        static let subtopics = "https://tenpercent-interview-project.s3.amazonaws.com/subtopics.json"
        static let mediations = "https://tenpercent-interview-project.s3.amazonaws.com/meditations.json"
    }


    private let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        return decoder
    }()
    

    func fetchTopics() async throws -> [Topic] {
        guard let url = URL(string: Constants.topics) else {
            throw APIError.invalidUrl
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        let status = (response as? HTTPURLResponse)?.statusCode
        
        if let status = status, (200..<300).contains(status) {
            let topicList = try decoder.decode(TopicsList.self, from: data)
            return topicList.topics
        } else {
            throw APIError.unknownError
        }
    }
    
    func fetchSubtopics() async throws -> [Subtopic] {
        guard let url = URL(string: Constants.subtopics) else {
            throw APIError.invalidUrl
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        let status = (response as? HTTPURLResponse)?.statusCode
        
        if let status = status, (200..<300).contains(status) {
            let subtopicsList = try decoder.decode(SubtopicsList.self, from: data)
            return subtopicsList.subtopics
        } else {
            throw APIError.unknownError
        }
    }
    
    func fetchMeditations() async throws -> [Meditation] {
        guard let url = URL(string: Constants.mediations) else {
            throw APIError.invalidUrl
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        let status = (response as? HTTPURLResponse)?.statusCode
        
        if let status = status, (200..<300).contains(status) {
            let meditationsList = try decoder.decode(MeditationsList.self, from: data)
            return meditationsList.meditations
        } else {
            throw APIError.unknownError
        }
    }
    
    func fetchData() async throws -> MeditationData {
        async let topics = fetchTopics()
        async let subtopics = fetchSubtopics()
        async let meditations = fetchMeditations()
        
        return try await MeditationData(topics: topics,
                                        subtopics: subtopics,
                                        meditations: meditations)
    }
    

}
