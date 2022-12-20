//
//  FeedViewController.swift
//  Navigation
//
//  Created by Suharik on 11.03.2022.
//

import UIKit
import SnapKit
import FirebaseAuth

class FeedViewController: UIViewController, UITextFieldDelegate {
    
    //MARK: Properties
    private var viewModel: ProfileViewModel?
    let historyTableViewCell = HistoryTableViewCell()
    private var cellIndexPathRow = 0
    
    private lazy var searchBarButtonItem = UIBarButtonItem(
        image: UIImage(systemName: "magnifyingglass")?.withRenderingMode(.automatic),
        style: .plain,
        target: self,
        action: #selector(showSideMenuBar)
    )
    
    private lazy var ringBarButtonItem = UIBarButtonItem(
        image: UIImage(systemName: "bell.fill")?.withRenderingMode(.automatic),
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
        self.navigationItem.title = "mainTitle".localized
        view.backgroundColor = .backgroundColor
        
        navigationItem.rightBarButtonItems = [searchBarButtonItem,ringBarButtonItem]
        searchBarButtonItem.tintColor = .textColor
        ringBarButtonItem.tintColor = .textColor
        
        tableView.register(HistoryTableViewCell.self, forCellReuseIdentifier: HistoryTableViewCell.identifire)
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: PostTableViewCell.identifire)
        self.tableView.dataSource = self
        self.tableView.delegate = self
        setupFeedLayouts()
    }
    
    private func setupFeedLayouts() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints{ make in
            make.top.leading.trailing.bottom.equalToSuperview()
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
    
    @objc private func doubleTap() {
        guard let post = viewModel?.posts[self.cellIndexPathRow] else { return }
        CoreDataManager.shared.saveFavourite(post: post)
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        switch response.actionIdentifier {
        case UNNotificationDefaultActionIdentifier:
            print("Ни одна из кнопок не нажата")
        case "Показать":
            print("Была нажата кнопка Показать")
        case "Спрятать":
            print("Была нажата кнопка Спрятать")
        default:
            print("Была нажата кнопка")
        }
        completionHandler()
    }

    @objc private func showSideMenuBar() {
        
    }
}

//MARK:Extensions

extension FeedViewController: UITableViewDataSource {
    
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
            let cell = tableView.dequeueReusableCell(withIdentifier: HistoryTableViewCell.identifire, for: indexPath) as! HistoryTableViewCell
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

extension FeedViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard indexPath.section == 0 else {return}
    }
}

