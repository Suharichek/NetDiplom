//
//  FullInfoViewController.swift
//  Navigation
//
//  Created by Suharik on 16.11.2022.
//

import UIKit

class FullInfoViewController: UIViewController {
    
    // MARK: - Properties
    
    var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "nameLabel".localized
        label.font = .boldSystemFont(ofSize: 18)
        label.textColor = .textColor
        return label
    }()
    
    var nameTextField: UITextField = {
        let text = UITextField()
        text.textColor = .textColor
        text.backgroundColor = .labelBackColor
        let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 20))
        text.leftView = paddingView
        text.leftViewMode = .always
        text.attributedPlaceholder = NSAttributedString.init(string: "Юлия", attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        text.layer.cornerRadius = 10
        text.layer.borderWidth = 1
        text.layer.borderColor = UIColor.textColor.cgColor
        text.clearButtonMode = UITextField.ViewMode.whileEditing
        return text
    }()
    
    var surnameLabel: UILabel = {
        let label = UILabel()
        label.text = "surnameLabel".localized
        label.font = .boldSystemFont(ofSize: 18)
        label.textColor = .textColor
        return label
    }()
    
    var surnameTextField: UITextField = {
        let text = UITextField()
        text.textColor = .textColor
        text.backgroundColor = .labelBackColor
        let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 20))
        text.leftView = paddingView
        text.leftViewMode = .always
        text.attributedPlaceholder = NSAttributedString.init(string: "Сухарева", attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        text.layer.cornerRadius = 10
        text.layer.borderWidth = 1
        text.layer.borderColor = UIColor.textColor.cgColor
        text.clearButtonMode = UITextField.ViewMode.whileEditing
        return text
    }()
    
    var sexLabel: UILabel = {
        let label = UILabel()
        label.text = "sexLabel".localized
        label.font = .boldSystemFont(ofSize: 18)
        label.textColor = .textColor
        return label
    }()
    
    var womenLabel: UILabel = {
        let label = UILabel()
        label.text = "womenLabel".localized
        label.font = .boldSystemFont(ofSize: 18)
        label.textColor = .textColor
        return label
    }()
    
    lazy var womenButton: CustomButton = {
       let button = CustomButton(
           title: "",
           titleColor: .textColor,
           backColor: .buttonColor,
           backImage: UIImage()
       )
       return button
   }()
    
    var menLabel: UILabel = {
        let label = UILabel()
        label.text = "menLabel".localized
        label.font = .boldSystemFont(ofSize: 18)
        label.textColor = .textColor
        return label
    }()
    
    lazy var menButton: CustomButton = {
       let button = CustomButton(
           title: "",
           titleColor: .textColor,
           backColor: .buttonColor,
           backImage: UIImage()
       )
       return button
   }()
    
    var birthLabel: UILabel = {
        let label = UILabel()
        label.text = "birthLabel".localized
        label.font = .boldSystemFont(ofSize: 18)
        label.textColor = .textColor
        return label
    }()
    
    var birthTextField: UITextField = {
        let text = UITextField()
        text.textColor = .textColor
        text.backgroundColor = .labelBackColor
        let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 20))
        text.leftView = paddingView
        text.leftViewMode = .always
        text.attributedPlaceholder = NSAttributedString.init(string: "29.09.2000", attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        text.layer.cornerRadius = 10
        text.layer.borderWidth = 1
        text.layer.borderColor = UIColor.textColor.cgColor
        text.clearButtonMode = UITextField.ViewMode.whileEditing
        return text
    }()
    
    var cityLabel: UILabel = {
        let label = UILabel()
        label.text = "cityLabel".localized
        label.font = .boldSystemFont(ofSize: 18)
        label.textColor = .textColor
        return label
    }()
    
    var cityTextField: UITextField = {
        let text = UITextField()
        text.textColor = .textColor
        text.backgroundColor = .labelBackColor
        let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 20))
        text.leftView = paddingView
        text.leftViewMode = .always
        text.attributedPlaceholder = NSAttributedString.init(string: "Санкт-Петербург", attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        text.layer.cornerRadius = 10
        text.layer.borderWidth = 1
        text.layer.borderColor = UIColor.textColor.cgColor
        text.clearButtonMode = UITextField.ViewMode.whileEditing
        return text
    }()
    
    //MARK: Main Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "infoTitle".localized
        view.backgroundColor = .backgroundColor
        setupFullInfoLayouts()
        selected()
    }
    
    func setupFullInfoLayouts(){
        view.addSubview(nameLabel)
        view.addSubview(nameTextField)
        view.addSubview(surnameLabel)
        view.addSubview(surnameTextField)
        view.addSubview(sexLabel)
        view.addSubview(womenLabel)
        view.addSubview(womenButton)
        view.addSubview(menLabel)
        view.addSubview(menButton)
        view.addSubview(birthLabel)
        view.addSubview(birthTextField)
        view.addSubview(cityLabel)
        view.addSubview(cityTextField)
        
        nameLabel.snp.makeConstraints{ make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(5)
            make.leading.equalToSuperview().offset(16)
            make.height.equalTo(30)
        }
        nameTextField.snp.makeConstraints{ make in
            make.top.equalTo(nameLabel.snp.bottom).offset(5)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(40)
        }
        surnameLabel.snp.makeConstraints{ make in
            make.top.equalTo(nameTextField.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.height.equalTo(30)
        }
        
        surnameTextField.snp.makeConstraints{ make in
            make.top.equalTo(surnameLabel.snp.bottom).offset(5)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(40)
        }
        
        sexLabel.snp.makeConstraints{ make in
            make.top.equalTo(surnameTextField.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.height.equalTo(30)
        }
        
        womenButton.snp.makeConstraints{ make in
            make.top.equalTo(sexLabel.snp.bottom).offset(5)
            make.leading.equalToSuperview().offset(16)
            make.height.equalTo(30)
        }
        
        womenLabel.snp.makeConstraints{ make in
            make.top.equalTo(sexLabel.snp.bottom).offset(5)
            make.leading.equalTo(womenButton.snp.trailing).offset(16)
            make.height.equalTo(30)
        }
        
        menButton.snp.makeConstraints{ make in
            make.top.equalTo(womenButton.snp.bottom).offset(5)
            make.leading.equalToSuperview().offset(16)
            make.height.equalTo(30)
        }
        
        menLabel.snp.makeConstraints{ make in
            make.top.equalTo(womenButton.snp.bottom).offset(5)
            make.leading.equalTo(menButton.snp.trailing).offset(16)
            make.height.equalTo(30)
        }
        
        birthLabel.snp.makeConstraints{ make in
            make.top.equalTo(menLabel.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.height.equalTo(30)
        }
        
        birthTextField.snp.makeConstraints{ make in
            make.top.equalTo(birthLabel.snp.bottom).offset(5)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(40)
        }
        
        cityLabel.snp.makeConstraints{ make in
            make.top.equalTo(birthTextField.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.height.equalTo(30)
        }
        
        cityTextField.snp.makeConstraints{ make in
            make.top.equalTo(cityLabel.snp.bottom).offset(5)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(40)
        }
    }
    
    func selected() {
        if womenButton.isSelected {
            menButton.isSelected = false
        } else {
            womenButton.isSelected = false
            menButton.isSelected = true
        }
    }
}
