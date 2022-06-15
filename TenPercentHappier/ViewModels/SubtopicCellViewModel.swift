//
//  SubtopicCellViewModel.swift
//  TenPercentHappier
//
//  Created by Damian on 6/14/22.
//

import Foundation

class SubtopicCellViewModel {

    let subtopicData: SubtopicData?
    let genericMeditations: [Meditation]?
    
    init(subtopicData: SubtopicData?, genericMeditations: [Meditation]?) {
        self.subtopicData = subtopicData
        self.genericMeditations = genericMeditations
    }
    
    var subtopicTitle: String {
        subtopicData?.subtopic.title ?? "Meditations"
    }
    
    var subtopicMeditations: [Meditation]? {
        subtopicData?.meditations
    }
    
}
