//
//  HistoryCollectionViewCell.swift
//  Navigation
//
//  Created by Suharik on 30.11.2022.
//

import UIKit
import SnapKit
import iOSIntPackage

class HistoryCollectionViewCell: UICollectionViewCell {
    static let identifire = "HistoryCollectionViewCell"
    
    private let history: UIImageView = {
        let history = UIImageView()
        return history
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        contentView.layer.cornerRadius = frame.width/2
        contentView.layer.borderWidth = 2
        contentView.layer.borderColor = UIColor.textColor.cgColor
        contentView.clipsToBounds = true
        HistoryPreviewLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func HistoryPreviewLayout() {
        contentView.addSubview(history)
        history.snp.makeConstraints { make in
            make.width.height.equalTo(contentView)
        }
    }
    
    func configure(image: UIImage) {
        self.history.image = image
    }
}
