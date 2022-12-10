//
//  SecondProfileHeaderView.swift
//  Navigation
//
//  Created by Suharik on 04.12.2022.
//

import UIKit
import SnapKit
import iOSIntPackage

class SecondProfileHeaderView: UIView {
    static let identifire = "SecondProfileHeaderView"
    private var status: String = ""
    
    var avatarImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "Finn")
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
    
    lazy var messageButton: CustomButton = {
        let button = CustomButton(
            title: "messageTitle".localized,
            titleColor: .textColor,
            backColor: .buttonColor,
            backImage: UIImage(named: "blue_pixel")!
        )
        return button
    }()
    
    lazy var callButton: CustomButton = {
        let button = CustomButton(
            title: "callTitle".localized,
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
    
    func setupViews(){
        self.addSubview(avatarImageView)
        self.addSubview(fullNameLabel)
        self.addSubview(statusLabel)
        self.addSubview(fullInfoButton)

        self.addSubview(messageButton)
        self.addSubview(callButton)
        
        self.addSubview(postsLabel)
        self.addSubview(subLabel)
        self.addSubview(followerLabel)
        
        
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
            make.bottom.equalTo(messageButton.snp.top).offset(-16)
            make.leading.equalToSuperview().offset(150)
            make.height.equalTo(30)
        }
        
        messageButton.snp.makeConstraints{ make in
            make.top.equalTo(avatarImageView.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.width.equalTo(160)
            make.height.equalTo(50)
        }
        
        callButton.snp.makeConstraints{ make in
            make.top.equalTo(avatarImageView.snp.bottom).offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.width.equalTo(160)
            make.height.equalTo(50)
        }
        
        postsLabel.snp.makeConstraints{ make in
            make.top.equalTo(messageButton.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.height.equalTo(40)
        }
        
        subLabel.snp.makeConstraints{ make in
            make.top.equalTo(messageButton.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
            make.height.equalTo(40)
        }
        
        followerLabel.snp.makeConstraints{ make in
            make.top.equalTo(messageButton.snp.bottom).offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(40)
        }
    }
}

