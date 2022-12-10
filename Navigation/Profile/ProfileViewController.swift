//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Suharik on 11.03.2022.
//

import UIKit
import SnapKit
import FirebaseAuth
import SideMenu

class ProfileViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: - Properties
    private var viewModel: ProfileViewModel?
    let photosViewController = PhotosViewController()
    let profileHeaderView = ProfileHeaderView()
    var userService: UserService
    var fullName: String
    private var cellIndexPathRow = 0
    
    private lazy var sideMenuBarButtonItem = UIBarButtonItem(
        image: UIImage(systemName: "sidebar.right")?.withRenderingMode(.automatic),
        style: .plain,
        target: self,
        action: #selector(showSideMenuBar)
    )
    
    lazy var tableView: UITableView = {
        var tableView = UITableView()
        tableView.backgroundColor = .backgroundColor
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    } ()
    
    //MARK: Main Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "profileTitle".localized
        view.backgroundColor = .backgroundColor
        
        self.navigationItem.rightBarButtonItem  = sideMenuBarButtonItem
        sideMenuBarButtonItem.tintColor = .textColor
        
        self.profileHeaderView.backgroundColor = .backgroundColor
        profileHeaderView.setupViews()
        profileHeaderView.fullInfoButton.setTitleColor(.textColor, for: .normal)
        profileHeaderView.editButton.setTitleColor(.textColor, for: .normal)
        
        let menuRightNavigationController = SideMenuNavigationController(rootViewController: SideMenuViewController())
        SideMenu.SideMenuManager.default.rightMenuNavigationController = menuRightNavigationController
        SideMenu.SideMenuManager.default.addPanGestureToPresent(toView: self.navigationController!.navigationBar)
        SideMenuManager.default.addPanGestureToPresent(toView: self.navigationController!.view)
        menuRightNavigationController.presentationStyle = .menuSlideIn
        
        self.view.addSubview(tableView)
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: PostTableViewCell.identifire)
        tableView.register(PhotosTableViewCell.self, forCellReuseIdentifier: PhotosTableViewCell.identifire)
        self.tableView.dataSource = self
        self.tableView.delegate = self
        setupProfileLayouts()
        
        profileHeaderView.fullInfoButton.tapAction = { [weak self] in
            guard let self = self else { return }
            self.pushFullInfoVC()
        }
        profileHeaderView.editButton.tapAction = { [weak self] in
            guard let self = self else { return }
            self.pushFullInfoVC()
        }
    }
    
    init (userService: UserService, name: String, viewModel: ProfileViewModel) {
        self.userService = userService
        self.fullName = name
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupProfileLayouts(){
        view.addSubview(profileHeaderView)
        view.addSubview(tableView)
        
        profileHeaderView.snp.makeConstraints{ make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.equalTo(view.snp.leading)
            make.trailing.equalTo(view.snp.trailing)
            make.height.equalTo(340)
        }
        
        tableView.snp.makeConstraints{ make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.equalTo(view.snp.leading)
            make.trailing.equalTo(view.snp.trailing)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    //MARK: Added Functions
    
    func showPhotosVC() {
        photosViewController.title = "photoTitle".localized
        photosViewController.view.backgroundColor = .backgroundColor
        self.navigationController?.pushViewController(photosViewController, animated: true)
        tabBarController?.tabBar.isHidden = true
    }
    
    @objc private func showSideMenuBar() {
        present(SideMenuManager.default.rightMenuNavigationController!, animated: true, completion: nil)
    }
    
    func pushFullInfoVC() {
        let fullInfoVC = FullInfoViewController()
        navigationController?.pushViewController(fullInfoVC, animated: true)
    }
    
    func presentLogin() {
        present(LogInViewController(), animated: true, completion: nil)
    }
    
    @objc private func doubleTap() {
        guard let post = viewModel?.posts[self.cellIndexPathRow] else { return }
        CoreDataManager.shared.saveFavourite(post: post)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
        self.navigationController?.navigationBar.isHidden = false
    }
}
// MARK: Extensions

extension ProfileViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0:
            return 1
        case 1:
            return viewModel?.numberOfRows() ?? 0
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: PhotosTableViewCell.identifire, for: indexPath) as! PhotosTableViewCell
            return cell
            
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PostTableViewCell.self), for: indexPath) as? PostTableViewCell
            let recognizer = UITapGestureRecognizer(target: self, action: #selector(self.doubleTap))
            recognizer.numberOfTapsRequired = 2
            guard let tableViewCell = cell, let viewModel = viewModel else { return UITableViewCell() }
            let cellViewModel = viewModel.cellViewModel(forIndexPath: indexPath)
            tableViewCell.viewModel = cellViewModel
            
            tableViewCell.addGestureRecognizer(recognizer)
            return tableViewCell
            
        default:
            return UITableViewCell()
        }
    }
}

extension ProfileViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var view = UIView()
        view = profileHeaderView
        let currentUser = userService.userIdentify(name: fullName)
        profileHeaderView.fullNameLabel.text = currentUser?.fullName
        profileHeaderView.avatarImageView.image = currentUser?.avatar
        profileHeaderView.statusLabel.text = currentUser?.status
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        switch section {
        case 0:
            return 340
        case 1:
            return 1
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard indexPath.section == 0 else {return}
        showPhotosVC()
    }
}

extension UIViewController {
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
