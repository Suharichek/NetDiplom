//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Suharik on 14.03.2022.
//

import UIKit
import SnapKit
import iOSIntPackage

class ProfileHeaderView: UIView {
    static let identifire = "ProfileHeaderView"
    private var status: String = ""
    
    var avatarImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage()
        image.layer.cornerRadius = 60
        image.layer.borderWidth = 3
        image.layer.borderColor = UIColor.textColor.cgColor
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.isUserInteractionEnabled = true
        return image
    }()
    
    var fullNameLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = .boldSystemFont(ofSize: 18)
        label.textColor = .textColor
        return label
    }()
    
    public lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.text = "statusTitle".localized
        label.numberOfLines = 2
        label.textColor = .textColor
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    lazy var fullInfoButton: CustomButton = {
        let button = CustomButton(
            title: "fullInfoTitle".localized,
            titleColor: .textColor,
            backColor: .backgroundColor,
            backImage: UIImage(named: "blue_pixel")!
        )
        return button
    }()
    
    lazy var editButton: CustomButton = {
        let button = CustomButton(
            title: "editTitle".localized,
            titleColor: .textColor,
            backColor: .buttonColor,
            backImage: UIImage(named: "blue_pixel")!
        )
        return button
    }()
    
    public lazy var postsLabel: UILabel = {
        let label = UILabel()
        label.text = "postsLabel".localized
        label.numberOfLines = 2
        label.textColor = .textColor
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    public lazy var subLabel: UILabel = {
        let label = UILabel()
        label.text = "subLabel".localized
        label.numberOfLines = 2
        label.textColor = .textColor
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    public lazy var followerLabel: UILabel = {
        let label = UILabel()
        label.text = "followerLabel".localized
        label.numberOfLines = 2
        label.textColor = .textColor
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    var postImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage()
        image.image = UIImage(systemName: "square.and.pencil", withConfiguration: UIImage.SymbolConfiguration(pointSize: 40))?.withTintColor(.textColor, renderingMode: .alwaysOriginal)
        return image
    }()
    
    public lazy var postLabel: UILabel = {
        let label = UILabel()
        label.text = "postLabel".localized
        label.numberOfLines = 2
        label.textColor = .textColor
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    var historyImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage()
        image.image = UIImage(systemName: "camera", withConfiguration: UIImage.SymbolConfiguration(pointSize: 40))?.withTintColor(.textColor, renderingMode: .alwaysOriginal)
        return image
    }()
    
    public lazy var historyLabel: UILabel = {
        let label = UILabel()
        label.text = "historyLabel".localized
        label.numberOfLines = 2
        label.textColor = .textColor
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    var photoImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage()
        image.image = UIImage(systemName: "photo", withConfiguration: UIImage.SymbolConfiguration(pointSize: 40))?.withTintColor(.textColor, renderingMode: .alwaysOriginal)
        return image
    }()
    
    public lazy var photoLabel: UILabel = {
        let label = UILabel()
        label.text = "photoLabel".localized
        label.numberOfLines = 2
        label.textColor = .textColor
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    func setupViews(){
        self.addSubview(avatarImageView)
        self.addSubview(fullNameLabel)
        self.addSubview(statusLabel)
        self.addSubview(fullInfoButton)
        self.addSubview(editButton)
        
        self.addSubview(postsLabel)
        self.addSubview(subLabel)
        self.addSubview(followerLabel)
        
        self.addSubview(postImageView)
        self.addSubview(postLabel)
        self.addSubview(historyImageView)
        self.addSubview(historyLabel)
        self.addSubview(photoImageView)
        self.addSubview(photoLabel)
        
        
        avatarImageView.snp.makeConstraints{ make in
            make.top.leading.equalToSuperview().offset(16)
            make.height.equalTo(120)
            make.width.equalTo(120)
        }
        
        fullNameLabel.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(27)
            make.leading.equalToSuperview().offset(150)
        }
        
        statusLabel.snp.makeConstraints{ make in
            make.bottom.equalTo(fullInfoButton.snp.top).offset(-16)
            make.leading.equalToSuperview().offset(150)
            make.height.equalTo(30)
        }
        
        fullInfoButton.snp.makeConstraints{ make in
            make.bottom.equalTo(editButton.snp.top).offset(-16)
            make.leading.equalToSuperview().offset(150)
            make.height.equalTo(30)
        }
        
        editButton.snp.makeConstraints{ make in
            make.top.equalTo(avatarImageView.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(50)
        }
        
        postsLabel.snp.makeConstraints{ make in
            make.top.equalTo(editButton.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.height.equalTo(40)
        }
        
        subLabel.snp.makeConstraints{ make in
            make.top.equalTo(editButton.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
            make.height.equalTo(40)
        }
        
        followerLabel.snp.makeConstraints{ make in
            make.top.equalTo(editButton.snp.bottom).offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(40)
        }
        
        postImageView.snp.makeConstraints{ make in
            make.top.equalTo(postsLabel.snp.bottom).offset(16)
            make.centerX.equalTo(postsLabel)
            make.height.equalTo(30)
            make.width.equalTo(30)
        }
        
        postLabel.snp.makeConstraints{ make in
            make.top.equalTo(postImageView.snp.bottom).offset(4)
            make.centerX.equalTo(postImageView)
            make.height.equalTo(15)
        }
        
        historyImageView.snp.makeConstraints{ make in
            make.top.equalTo(subLabel.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
            make.height.equalTo(30)
            make.width.equalTo(35)
        }
        
        historyLabel.snp.makeConstraints{ make in
            make.top.equalTo(historyImageView.snp.bottom).offset(4)
            make.centerX.equalToSuperview()
            make.height.equalTo(15)
        }
        
        photoImageView.snp.makeConstraints{ make in
            make.top.equalTo(followerLabel.snp.bottom).offset(16)
            make.centerX.equalTo(followerLabel)
            make.height.equalTo(30)
            make.width.equalTo(30)
        }
        
        photoLabel.snp.makeConstraints{ make in
            make.top.equalTo(photoImageView.snp.bottom).offset(4)
            make.centerX.equalTo(photoImageView)
            make.height.equalTo(15)
        }
    }
}

