//
//  TopicCell.swift
//  TenPercentHappier
//
//  Created by Damian on 6/12/22.
//

import Foundation
import Reusable
import SnapKit
import UIKit

class TopicCell: UITableViewCell, Reusable {
    
    private let containerView: UIView = {
       let view = UIView()
        view.layer.borderWidth = 2.0
        view.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.3).cgColor
        view.layer.cornerRadius = 3.0
        view.clipsToBounds = true
        return view
    }()
    
    private let colorBar: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        return view
    }()
    
    private let labelStack: UIStackView = {
       let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 4.0
        return stack
    }()
    
    private let topicTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18.0)
        return label
    }()
    
    private let numOfMeditationsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14.0)
        label.textColor = .lightGray
        return label
    }()

    
    var viewModel: TopicCellViewModel? {
        didSet {
            updateUI()
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews()
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews() {
        
        contentView.addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.left.equalTo(16.0)
            make.top.equalTo(10.0)
            make.right.equalTo(-16.0)
            make.bottom.equalTo(-10.0)
        }
        
        containerView.addSubview(colorBar)
        colorBar.snp.makeConstraints { make in
            make.left.top.bottom.equalToSuperview()
            make.width.equalTo(12.0)
        }
        
        containerView.addSubview(labelStack)
        labelStack.snp.makeConstraints { make in
            make.left.equalTo(colorBar.snp.right).offset(12.0)
            make.top.equalTo(20.0)
            make.bottom.equalTo(-16.0)
        }
        
        [topicTitle, numOfMeditationsLabel].forEach { labelStack.addArrangedSubview($0) }
    }
    
    private func updateUI() {
        guard let viewModel = viewModel else { return }
        colorBar.backgroundColor = viewModel.barColor
        topicTitle.text = viewModel.title
        numOfMeditationsLabel.text = viewModel.numOfMeditations
    }
    
}
