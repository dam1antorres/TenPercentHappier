//
//  TopicsViewModel.swift
//  TenPercentHappier
//
//  Created by Damian on 6/12/22.
//

import Foundation

class TopicsViewModel: ViewModel {
    
    private let api = API()
    private let persistor = Persistor()
    @Published var topics: [Topic] = []
    @Published var subtopics: [Subtopic] = []
    @Published var meditations: [Meditation] = []
    @Published var fetchError: Error?
    
    func fetchMeditationData() {
        Task {
            do {
                let data = try await api.fetchData()
                self.topics = data.topics.filter { $0.featured }.filter { $0.meditations.count != 0 }.sorted {
                    $0.position < $1.position
                }
                self.subtopics = data.subtopics
                self.meditations = data.meditations
            } catch {
                DispatchQueue.main.async {
                    self.topics = self.persistor.persistedTopics.toModelArray()
                    self.subtopics = self.persistor.persistedSubtopics.toModelArray()
                    self.meditations = self.persistor.persistedMeditations.toModelArray()
                    self.fetchError = error
                }
            }
        }
    }
    
    func handleCellTap(index: Int) {
        let topic = topics[index]
        let filteredSubtopics = subtopics.filter { $0.parent_topic_uuid == topic.uuid }
        let subtopicData = filteredSubtopics.map { SubtopicData(subtopic: $0, meditations: getMeditationsFrom($0)) }
        coordinator.handleSegue(.subtopics(.subtopics(topic: topic, subtopics: subtopicData, meditations: getMeditationsFrom(topic))))
    }
     
    private func getMeditationsFrom(_ subtopic: Subtopic) -> [Meditation] {
        let subtopicMeditations = subtopic.meditations
        var foundMeditations = [Meditation]()
        subtopicMeditations.forEach { sub in
            let filteredMeditations = meditations.filter { $0.uuid == sub }
            if filteredMeditations.count > 0 {
                foundMeditations.append(filteredMeditations[0])
            }
        }
        return foundMeditations
    }
    
    private func getMeditationsFrom(_ topic: Topic) -> [Meditation] {
        let topicMeditations = topic.meditations
        var foundMeditations = [Meditation]()
        topicMeditations.forEach { sub in
            let filteredMeditations = meditations.filter { $0.uuid == sub }
            if filteredMeditations.count > 0 {
                foundMeditations.append(filteredMeditations[0])
            }
        }
        return foundMeditations
    }
}
