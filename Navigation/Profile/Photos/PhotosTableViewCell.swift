//
//  PhotosTableViewCell.swift
//  Navigation
//
//  Created by Suharik on 04.04.2022.

import UIKit
import SnapKit
import iOSIntPackage

class PhotosTableViewCell: UITableViewCell {
    
    static let identifire = "PhotosTableViewCell"
    
    private lazy var photosTitle: UILabel = {
        let photosTitle = UILabel()
        photosTitle.numberOfLines = 2
        photosTitle.text = "photosTitle".localized
        photosTitle.textColor = .textColor
        photosTitle.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        return photosTitle
    }()
    
    private lazy var arrowImage: UIImageView = {
        let arrowImage = UIImageView()
        arrowImage.image = UIImage(systemName: "arrow.right.circle.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30))?.withTintColor(.textColor, renderingMode: .alwaysOriginal)
        return arrowImage
    }()
    
    private lazy var photosPreview: PhotosPreview = {
        let photosPreview = PhotosPreview()
        photosPreview.backgroundColor = .imageBackColor
        photosPreview.setupContent()
        return photosPreview
    }()
    
//    private lazy var searchImage: UIImageView = {
//        let searchImage = UIImageView()
//        searchImage.image = UIImage(systemName: "magnifyingglass", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30))?.withTintColor(.textColor, renderingMode: .alwaysOriginal)
//        return searchImage
//    }()
    
//    var searchTextField: UITextField = {
//        let text = UITextField()
//        text.textColor = .textColor
//        text.backgroundColor = .labelBackColor
//        let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 20))
//        text.leftView = paddingView
//        text.leftViewMode = .always
//        text.attributedPlaceholder = NSAttributedString.init(string: "Записи", attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
//        text.isUserInteractionEnabled = false
//        return text
//    }()
    
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
    
    private func setupConstraints(){
        contentView.addSubview(photosTitle)
        contentView.addSubview(arrowImage)
        contentView.addSubview(photosPreview)
//        contentView.addSubview(searchTextField)
//        contentView.addSubview(searchImage)
        
        photosTitle.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(8)
            make.leading.equalToSuperview().offset(8)
        }
        
        arrowImage.snp.makeConstraints{ make in
            make.trailing.equalToSuperview().offset(-8)
            make.height.equalTo(40)
            make.width.equalTo(40)
        }
        
        photosPreview.snp.makeConstraints{ make in
            make.top.equalTo(photosTitle.snp.bottom).offset(8)
            make.bottom.equalToSuperview().offset(-8)
            make.height.equalTo(80)
            make.width.equalToSuperview()
        }
        
//        searchTextField.snp.makeConstraints{ make in
//            make.top.equalTo(photosPreview.snp.bottom).offset(8)
//            make.leading.equalToSuperview()
//            make.trailing.equalToSuperview()
//            make.height.equalTo(40)
//        }
//        
//        searchImage.snp.makeConstraints{ make in
//            make.top.equalTo(photosPreview.snp.bottom).offset(8)
//            make.trailing.equalToSuperview().offset(-8)
//            make.centerY.equalTo(searchTextField).offset(-2)
//        }
    }
}
