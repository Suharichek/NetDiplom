//
//  SettingsViewController.swift
//  Navigation
//
//  Created by Suharik on 03.12.2022.
//

import UIKit

class SettingsViewController: UIViewController {
    
    var profileLabel: UILabel = {
        let label = UILabel()
        label.text = "Настройки"
        label.font = .boldSystemFont(ofSize: 24)
        label.textColor = .textColor
        return label
    }()
    
    var infoLabel: UILabel = {
        let label = UILabel()
        label.text = "Основная информация"
        label.font = .boldSystemFont(ofSize: 18)
        label.textColor = .textColor
        return label
    }()
    
    var contactLabel: UILabel = {
        let label = UILabel()
        label.text = "Контакты"
        label.font = .boldSystemFont(ofSize: 18)
        label.textColor = .textColor
        return label
    }()
    
    var interestLabel: UILabel = {
        let label = UILabel()
        label.text = "Интересы"
        label.font = .boldSystemFont(ofSize: 18)
        label.textColor = .textColor
        return label
    }()
    
    var eduLabel: UILabel = {
        let label = UILabel()
        label.text = "Образование"
        label.font = .boldSystemFont(ofSize: 18)
        label.textColor = .textColor
        return label
    }()
    
    var careerLabel: UILabel = {
        let label = UILabel()
        label.text = "Карьера"
        label.font = .boldSystemFont(ofSize: 18)
        label.textColor = .textColor
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundColor
        setupSettingsLayouts()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if #available(iOS 15.0, *) {
        } else {
            self.view.frame = CGRect(x: 0, y: UIScreen.main.bounds.height / 5 * 3, width: self.view.bounds.width, height: UIScreen.main.bounds.height / 5 * 3)
            self.view.layer.cornerRadius = 20
            self.view.layer.masksToBounds = true
        }
    }
    
    func setupSettingsLayouts(){
        view.addSubview(profileLabel)
        view.addSubview(infoLabel)
        view.addSubview(contactLabel)
        view.addSubview(interestLabel)
        view.addSubview(eduLabel)
        view.addSubview(careerLabel)
        
        profileLabel.snp.makeConstraints{ make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(5)
            make.leading.equalToSuperview().offset(16)
            make.height.equalTo(30)
        }
        infoLabel.snp.makeConstraints{ make in
            make.top.equalTo(profileLabel.snp.bottom).offset(5)
            make.leading.equalToSuperview().offset(16)
            make.height.equalTo(30)
        }
        
        contactLabel.snp.makeConstraints{ make in
            make.top.equalTo(infoLabel.snp.bottom).offset(5)
            make.leading.equalToSuperview().offset(16)
            make.height.equalTo(30)
        }
        
        interestLabel.snp.makeConstraints{ make in
            make.top.equalTo(contactLabel.snp.bottom).offset(5)
            make.leading.equalToSuperview().offset(16)
            make.height.equalTo(30)
        }
        
        eduLabel.snp.makeConstraints{ make in
            make.top.equalTo(interestLabel.snp.bottom).offset(5)
            make.leading.equalToSuperview().offset(16)
            make.height.equalTo(30)
        }
        
        careerLabel.snp.makeConstraints{ make in
            make.top.equalTo(eduLabel.snp.bottom).offset(5)
            make.leading.equalToSuperview().offset(16)
            make.height.equalTo(30)
        }
    }
}
