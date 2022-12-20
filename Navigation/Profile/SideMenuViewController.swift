//
//  SideMenuViewController.swift
//  Navigation
//
//  Created by Suharik on 24.11.2022.
//

import UIKit
import SnapKit
import FirebaseAuth
import SideMenu

class SideMenuViewController: UIViewController {
    
    var viewModel = ProfileViewModel()
    
    // MARK: - Properties
    
    lazy var faveButton: CustomButton = {
        let button = CustomButton(
            title: "favouriteTitle".localized,
            titleColor: .textColor,
            backColor: .backgroundColor,
            backImage: UIImage(named: "blue_pixel")!
        )
        button.setTitleColor(.textColor, for: .normal)
        return button
    }()
    
    private lazy var faveImage: UIImageView = {
        let logo = UIImageView()
        logo.image = UIImage(systemName: "star.fill")
        logo.tintColor = .textColor
        return logo
    }()
    
    lazy var friendsButton: CustomButton = {
        let button = CustomButton(
            title: "friendsTitle".localized,
            titleColor: .textColor,
            backColor: .backgroundColor,
            backImage: UIImage(named: "blue_pixel")!
        )
        button.setTitleColor(.textColor, for: .normal)
        return button
    }()
    
    private lazy var friendsImage: UIImageView = {
        let logo = UIImageView()
        logo.image = UIImage(systemName: "person.2.fill")
        logo.tintColor = .textColor
        return logo
    }()
    
    lazy var setButton: CustomButton = {
        let button = CustomButton(
            title: "settingsTitle".localized,
            titleColor: .textColor,
            backColor: .backgroundColor,
            backImage: UIImage(named: "blue_pixel")!
        )
        button.setTitleColor(.textColor, for: .normal)
        return button
    }()
    
    private lazy var setImage: UIImageView = {
        let logo = UIImageView()
        logo.image = UIImage(systemName: "gearshape")
        logo.tintColor = .textColor
        return logo
    }()
    
    lazy var exitButton: CustomButton = {
        let button = CustomButton(
            title: "exitTitle".localized,
            titleColor: .textColor,
            backColor: .backgroundColor,
            backImage: UIImage(named: "blue_pixel")!
        )
        button.setTitleColor(.textColor, for: .normal)
        return button
    }()
    
    private lazy var exitImage: UIImageView = {
        let logo = UIImageView()
        logo.image = UIImage(systemName: "bolt.heart")
        logo.tintColor = .textColor
        return logo
    }()
    
    private lazy var alertController: UIAlertController = {
        let alertController = UIAlertController(
            title: "exitTitle".localized,
            message: "profileAlertMessage".localized,
            preferredStyle: .alert)
        let acceptAction = UIAlertAction(title: "profileAcceptTitle".localized, style: .default) { _ in
            do {
                try Auth.auth().signOut()
                self.pushLoginViewController()
                UserDefaults.standard.setValue(true, forKey: "isManuallySignOut")
            } catch {
                print(error.localizedDescription)
            }
        }
        alertController.addAction(acceptAction)
        let declineAction = UIAlertAction(title: "profileDeclineTitle".localized, style: .destructive)
        alertController.addAction(declineAction)
        return alertController
    }()
    

    
    //MARK: Main Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "menu".localized
        view.backgroundColor = .backgroundColor
        setupSideMenuLayouts()
        
        let sideMenuBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close,
                                                    target: self,
                                                    action: #selector(hideSideMenuBar))
        navigationItem.leftBarButtonItem = sideMenuBarButtonItem
        
        faveButton.tapAction = { [weak self] in
            guard let self = self else { return }
            self.faveButtonPressed()
        }
        
        friendsButton.tapAction = { [weak self] in
            guard let self = self else { return }
            self.friendsButtonPressed()
        }
        
        setButton.tapAction = { [weak self] in
            guard let self = self else { return }
            self.setButtonPressed()
        }
        
        exitButton.tapAction = { [weak self] in
            guard let self = self else { return }
            self.exitButtonPressed()
        }
    }
    
    func setupSideMenuLayouts(){
        view.addSubview(faveImage)
        view.addSubview(faveButton)
        view.addSubview(friendsImage)
        view.addSubview(friendsButton)
        view.addSubview(setImage)
        view.addSubview(setButton)
        view.addSubview(exitImage)
        view.addSubview(exitButton)
        
        faveImage.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.width.equalTo(35)
            make.height.equalTo(30)
        }
        
        faveButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(16)
            make.leading.equalTo(faveImage.snp.trailing).offset(16)
            make.height.equalTo(30)
        }
        
        friendsImage.snp.makeConstraints { make in
            make.top.equalTo(faveImage.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.width.equalTo(35)
            make.height.equalTo(30)
        }
        
        friendsButton.snp.makeConstraints { make in
            make.top.equalTo(faveButton.snp.bottom).offset(16)
            make.leading.equalTo(setImage.snp.trailing).offset(16)
            make.height.equalTo(30)
        }
        
        setImage.snp.makeConstraints { make in
            make.top.equalTo(friendsImage.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.width.equalTo(35)
            make.height.equalTo(30)
        }
        
        setButton.snp.makeConstraints { make in
            make.top.equalTo(friendsButton.snp.bottom).offset(16)
            make.leading.equalTo(setImage.snp.trailing).offset(16)
            make.height.equalTo(30)
        }
        
        exitImage.snp.makeConstraints { make in
            make.top.equalTo(setImage.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.width.equalTo(35)
            make.height.equalTo(30)
        }
        
        exitButton.snp.makeConstraints { make in
            make.top.equalTo(setButton.snp.bottom).offset(16)
            make.leading.equalTo(exitImage.snp.trailing).offset(16)
            make.height.equalTo(30)
        }
    }
    
    
    
    //MARK: Added Functions
    
    @objc private func faveButtonPressed() {
        present(FavouriteViewController(coordinator: FavouriteCoordinator()), animated: true, completion: nil)
    }
    
    @objc private func friendsButtonPressed() {
            navigationController?.pushViewController(SecondProfileViewController(viewModel: viewModel), animated: true)
    }
    
    @objc private func setButtonPressed() {
        present(SettingsViewController(), animated: true, completion: nil)
    }
    
    @objc private func exitButtonPressed() {
        present(alertController, animated: true)
    }
    
    @objc private func hideSideMenuBar() {
        dismiss(animated: true, completion: nil)
    }
    
    private func pushLoginViewController() {
        let loginViewController = LogInViewController()
        navigationController?.pushViewController(loginViewController, animated: true)
        loginViewController.navigationItem.setHidesBackButton(true, animated: true)
    }
}
