//
//  SubtopicsViewController.swift
//  TenPercentHappier
//
//  Created by Damian on 6/12/22.
//

import Foundation
import UIKit

class SubtopicsViewController: BaseViewController {
    
    enum Sections: Int,  CaseIterable {
        case subtopics, genericMeditations
    }
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(headerFooterViewType: TopicsTableViewHeader.self)
        tableView.register(cellType: SubtopicCell.self)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 233.0
        tableView.separatorStyle = .none
        tableView.estimatedSectionHeaderHeight = 180.0
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.backgroundColor = .white
        return tableView
    }()
    
    private let subtopicsViewModel: SubtopicsViewModel
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        setupBindings()
    }
    
    init(viewModel: SubtopicsViewModel) {
        self.subtopicsViewModel = viewModel
        super.init(viewModel: viewModel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews() {
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupBindings() {
        
    }
}

extension SubtopicsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let section = Sections(rawValue: section) else { return nil }
        switch section {
        case .subtopics:
            let view = tableView.dequeueReusableHeaderFooterView(TopicsTableViewHeader.self)
            view?.title = subtopicsViewModel.topicTitle
            view?.subtopicDescription = subtopicsViewModel.topicDescription
            return view
        case .genericMeditations:
            return nil
        }
    }
}

extension SubtopicsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        Sections.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = Sections(rawValue: section) else { return 0 }
        switch section {
        case .subtopics:
            return subtopicsViewModel.subtopicsData.count
        case .genericMeditations:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = Sections(rawValue: indexPath.section) else { return UITableViewCell() }
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: SubtopicCell.self)
        switch section {
        case .subtopics:
            let viewModel = subtopicsViewModel.getCellViewModel(index: indexPath.row)
            cell.viewModel = viewModel
        case .genericMeditations:
            let viewModel = subtopicsViewModel.getViewModelForGenericMeditations()
            cell.viewModel = viewModel
        }
        return cell
    }
    
}
