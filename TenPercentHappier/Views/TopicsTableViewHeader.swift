//
//  TopicsTableViewHeader.swift
//  TenPercentHappier
//
//  Created by Damian on 6/12/22.
//

import Foundation
import Reusable
import SnapKit
import UIKit

class TopicsTableViewHeader: UITableViewHeaderFooterView, Reusable {
    
    private let label: UILabel =  {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 32.0)
        label.text = "Topics"
        return label
    }()
    
    private let descriptionLabel: UILabel = {
       let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    var title: String = "" {
        didSet {
            label.text = title
        }
    }
    
    var subtopicDescription: String = "" {
        didSet {
            descriptionLabel.text = subtopicDescription
            label.snp.remakeConstraints { make in
                make.top.equalTo(8.0)
                make.leading.equalTo(16.0)
            }
            contentView.addSubview(descriptionLabel)
            descriptionLabel.snp.makeConstraints { make in
                make.top.equalTo(label.snp.bottom).offset(28.0)
                make.leading.equalToSuperview().offset(15.0)
                make.trailing.equalToSuperview().offset(-15.0)
                make.bottom.equalToSuperview().offset(-15.0)
            }
        }
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupSubviews()
        let background = UIView()
        background.backgroundColor = .lightGray.withAlphaComponent(0.10)
        backgroundView = background
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews() {
        contentView.addSubview(label)
        label.snp.makeConstraints { make in
            make.top.equalTo(8.0)
            make.leading.equalTo(16.0)
            make.bottom.equalTo(-8.0)
        }
    }
    
}
