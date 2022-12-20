//
//  SecondProfileViewController.swift
//  Navigation
//
//  Created by Suharik on 04.12.2022.
//

import UIKit
import SnapKit

class SecondProfileViewController: UIViewController {
    
    // MARK: - Properties
    private var viewModel: ProfileViewModel?
    let photosViewController = PhotosViewController()
    let secondProfileHeaderView = SecondProfileHeaderView()
    private var cellIndexPathRow = 0
    
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
        view.backgroundColor = .backgroundColor
        self.navigationController?.navigationBar.isHidden = true
        secondProfileHeaderView.messageButton.setTitleColor(.textColor, for: .normal)
        secondProfileHeaderView.callButton.setTitleColor(.textColor, for: .normal)
        
        self.secondProfileHeaderView.backgroundColor = .backgroundColor
        secondProfileHeaderView.setupViews()
        secondProfileHeaderView.fullInfoButton.setTitleColor(.textColor, for: .normal)
        
        self.view.addSubview(tableView)
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: PostTableViewCell.identifire)
        tableView.register(PhotosTableViewCell.self, forCellReuseIdentifier: PhotosTableViewCell.identifire)
        self.tableView.dataSource = self
        self.tableView.delegate = self
        setupProfileLayouts()
        
        secondProfileHeaderView.fullInfoButton.tapAction = { [weak self] in
            guard let self = self else { return }
            self.pushFullInfoVC()
        }
    }
    
    func setupProfileLayouts(){
        view.addSubview(secondProfileHeaderView)
        view.addSubview(tableView)

        secondProfileHeaderView.snp.makeConstraints{ make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.equalTo(view.snp.leading)
            make.trailing.equalTo(view.snp.trailing)
            make.height.equalTo(270)
        }
        
        tableView.snp.makeConstraints{ make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.equalTo(view.snp.leading)
            make.trailing.equalTo(view.snp.trailing)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    init (viewModel: ProfileViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Added Functions
    
    func showPhotosVC() {
        photosViewController.title = "photoTitle".localized
        photosViewController.view.backgroundColor = .backgroundColor
        self.navigationController?.pushViewController(photosViewController, animated: true)
        tabBarController?.tabBar.isHidden = true
    }
    
    func pushFullInfoVC() {
        let fullInfoVC = FullInfoViewController()
        navigationController?.pushViewController(fullInfoVC, animated: true)
    }
    
    @objc private func doubleTap() {
        guard let post = viewModel?.posts[self.cellIndexPathRow] else { return }
        CoreDataManager.shared.saveFavourite(post: post)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
}
// MARK: Extensions

extension SecondProfileViewController: UITableViewDataSource {
    
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

extension SecondProfileViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var view = UIView()
        view = secondProfileHeaderView
        secondProfileHeaderView.fullNameLabel.text = "Абдулил Джахаров"
        secondProfileHeaderView.avatarImageView.image = UIImage(systemName: "12")
        secondProfileHeaderView.statusLabel.text = "Что-то новое"
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        switch section {
        case 0:
            return 270
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
