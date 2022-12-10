//
//  HistoryTableViewCell.swift
//  Navigation
//
//  Created by Suharik on 30.11.2022.
//

import UIKit
import SnapKit
import iOSIntPackage

class HistoryTableViewCell: UITableViewCell {
    
    static let identifire = "PhotosTableViewCell"
    
    var newsLabel: UILabel = {
        let label = UILabel()
        label.text = "newsTitle".localized
        label.font = .boldSystemFont(ofSize: 18)
        label.textColor = .textColor
        return label
    }()
    
    var forULabel: UILabel = {
        let label = UILabel()
        label.text = "forUTitle".localized
        label.font = .boldSystemFont(ofSize: 18)
        label.textColor = .textColor
        return label
    }()
    
    private lazy var historyPreview: HistoryPreview = {
        let historyPreview = HistoryPreview()
        historyPreview.setupContent()
        return historyPreview
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .backgroundColor
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    private func setupConstraints() {
        contentView.addSubview(newsLabel)
        contentView.addSubview(forULabel)
        contentView.addSubview(historyPreview)
        
        newsLabel.snp.makeConstraints{ make in
            make.top.equalTo(contentView.safeAreaLayoutGuide.snp.top)
            make.leading.equalToSuperview().offset(8)
        }
        
        forULabel.snp.makeConstraints{ make in
            make.top.equalTo(contentView.safeAreaLayoutGuide.snp.top)
            make.leading.equalTo(newsLabel.snp.trailing).offset(16)
        }
        
        historyPreview.snp.makeConstraints{ make in
            make.top.equalTo(newsLabel.snp.bottom).offset(8)
            make.bottom.equalTo(contentView.snp.bottom)
            make.height.equalTo(60)
            make.width.equalTo(contentView.snp.width)
        }
    }
}
