//
//  TopicsViewController.swift
//  TenPercentHappier
//
//  Created by Damian on 6/12/22.
//

import Foundation
import Reusable
import SnapKit
import UIKit
import RealmSwift

class TopicsViewController: BaseViewController {
    
    private let persistor = Persistor()
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(cellType: TopicCell.self)
        tableView.register(headerFooterViewType: TopicsTableViewHeader.self)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .white
        return tableView
    }()
    
    private let topicsViewModel: TopicsViewModel
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        setupBindings()
        topicsViewModel.fetchMeditationData()
        print(Realm.Configuration.defaultConfiguration.fileURL!)
    }
    
    init(viewModel: TopicsViewModel) {
        self.topicsViewModel = viewModel
        super.init(viewModel: viewModel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupBindings() {
        topicsViewModel.$topics
            .receive(on: DispatchQueue.main)
            .dropFirst()
            .sink(receiveValue: { [weak self] topics in
                guard let self = self else { return }
                self.persistor.saveTopics(topics)
                self.tableView.reloadData()
            })
            .store(in: &bag)
        
        topicsViewModel.$subtopics
            .receive(on: DispatchQueue.main)
            .dropFirst()
            .sink(receiveValue: { [weak self] subtopics in
                guard let self = self else { return }
                self.persistor.saveSubtopics(subtopics)
            })
            .store(in: &bag)
        
        topicsViewModel.$meditations
            .receive(on: DispatchQueue.main)
            .dropFirst()
            .sink(receiveValue: { [weak self] meditations in
                guard let self = self else { return }
                self.persistor.saveMeditations(meditations)
            })
            .store(in: &bag)
    }
}

extension TopicsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        topicsViewModel.handleCellTap(index: indexPath.row)
    }
}

extension TopicsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return topicsViewModel.topics.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: TopicCell.self)
        let viewModel = TopicCellViewModel(topic: topicsViewModel.topics[indexPath.row])
        cell.viewModel = viewModel
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(TopicsTableViewHeader.self)
        view?.title = "Topics"
        return view
    }
}
