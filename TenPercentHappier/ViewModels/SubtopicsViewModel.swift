//
//  SubtopicsViewModel.swift
//  TenPercentHappier
//
//  Created by Damian on 6/12/22.
//

import Foundation

class SubtopicsViewModel: ViewModel {
    let topic: Topic
    let subtopicsData: [SubtopicData]
    let meditations: [Meditation]
    
    init(topic: Topic, subtopicsData: [SubtopicData], meditations: [Meditation], coordinator: Coordinating) {
        self.topic = topic
        self.subtopicsData = subtopicsData
        self.meditations = meditations
        super.init(coordinator: coordinator)
    }
    
    var topicTitle: String {
        topic.title
    }
    
    var topicDescription: String {
        topic.description
    }
    
    func getCellViewModel(index: Int) -> SubtopicCellViewModel {
        let data = subtopicsData[index]
        let viewModel = SubtopicCellViewModel(subtopicData: data, genericMeditations: nil)
        return viewModel
    }
    
    func getViewModelForGenericMeditations() -> SubtopicCellViewModel {
        let viewModel = SubtopicCellViewModel(subtopicData: nil, genericMeditations: meditations)
        return viewModel
    }
}
