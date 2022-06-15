//
//  SubtopicCell.swift
//  TenPercentHappier
//
//  Created by Damian on 6/14/22.
//

import Foundation
import Reusable
import UIKit

class SubtopicCell: UITableViewCell, Reusable {
    
    var viewModel: SubtopicCellViewModel? {
        didSet {
            updateUI()
        }
    }
    
    private let titleLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24.0)
        return label
    }()
    
    private let meditationStack: UIStackView = {
       let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 15.0
        return stack
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews()
    }
    
    private var meditationViews: [MeditationView] = [MeditationView]()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews() {
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(12.0)
            make.trailing.equalToSuperview()
        }
        contentView.addSubview(meditationStack)
        meditationStack.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(12.0)
            make.left.equalTo(12.0)
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    private func updateUI() {
        guard let viewModel = viewModel else { return }
        titleLabel.text = viewModel.subtopicTitle
        if let subtopicData = viewModel.subtopicData {
            subtopicData.meditations.forEach {
                let meditationView = MeditationView()
                meditationStack.addArrangedSubview(meditationView)
                meditationView.config = MeditationView.Config(imageUrl: $0.imageURL, meditationTitle: $0.title, teacherName: $0.teacherName)
            }
        }
        
        if let genericMeditations = viewModel.genericMeditations {
            genericMeditations.sorted { (item1, item2) in
                guard let playCount1 = item1.playCount, let playCount2 = item2.playCount else { return false }
                return playCount1 > playCount2
            }.forEach {
                let meditationView = MeditationView()
                meditationViews.append(meditationView)
                meditationView.config = MeditationView.Config(imageUrl: $0.imageURL, meditationTitle: $0.title, teacherName: $0.teacherName)
                meditationStack.addArrangedSubview(meditationView)
            }
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        meditationViews.forEach { $0.prepareForReuse() }
        meditationViews.removeAll()
        meditationStack.arrangedSubviews.forEach { $0.removeFromSuperview() }
    }
    
}
