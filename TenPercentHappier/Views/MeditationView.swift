//
//  MeditationView.swift
//  TenPercentHappier
//
//  Created by Damian on 6/14/22.
//

import Foundation
import Kingfisher
import UIKit

class MeditationView: UIView {
    
    struct Config {
        let imageUrl: String
        let meditationTitle: String
        let teacherName: String
    }
    
    private let imageView = UIImageView()
    private let meditationTitleLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16.0)
        return label
    }()
    private let teacherNameLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12.0)
        label.textColor = .lightGray
        return label
    }()
    private let meditationInfoStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        return stack
    }()
    
    var config: Config? {
        didSet {
            updateUI()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.layer.cornerRadius = 6.0
        imageView.clipsToBounds = true
    }
    
    private func setupSubviews() {
        addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.top.equalToSuperview()
            make.height.equalTo(50.0)
            make.width.equalTo(50.0)
        }
        addSubview(meditationInfoStack)
        meditationInfoStack.snp.makeConstraints { make in
            make.left.equalTo(imageView.snp.right).offset(10.0)
            make.centerY.equalToSuperview()
        }
        [meditationTitleLabel, teacherNameLabel].forEach { meditationInfoStack.addArrangedSubview($0) }
    }
    
    override var intrinsicContentSize: CGSize {
        CGSize(width: Double.greatestFiniteMagnitude, height: 50.0)
    }
    
    private func updateUI() {
        guard let config = config else { return }
        imageView.kf.setImage(with: URL(string: config.imageUrl), placeholder: UIImage(named: "blue_tile"))
        meditationTitleLabel.text = config.meditationTitle
        teacherNameLabel.text = config.teacherName
    }
    
    func prepareForReuse() {
        imageView.image = nil
        meditationTitleLabel.text = ""
        teacherNameLabel.text = ""
    }
    
}
