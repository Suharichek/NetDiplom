//
//  FavouriteViewController.swift
//  Navigation
//
//  Created by Suharik on 15.11.2022.
//

import UIKit
import SnapKit

class FavouriteViewController: UIViewController {
    
    private weak var coordinator: FavouriteCoordinator?
    private var post: FavouritePostEntity?
    private var favouritePosts = [Post]()
    
    let filterButton = UIBarButtonItem(
        barButtonSystemItem: .search,
        target: self,
        action: #selector(showFilterAlert)
    )
    
    let trashButton = UIBarButtonItem(
        barButtonSystemItem: .trash,
        target: self,
        action: #selector(reloadCoreDataFilesByFetch)
    )
    
    private lazy var filterPredicateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        label.textColor = .textColor
        label.textAlignment = .center
        return label
    }()
    
    private lazy var favouriteTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.separatorInset = .zero
        tableView.backgroundColor = .backgroundColor
        return tableView
    }()
    
    
    init (coordinator: FavouriteCoordinator) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "favouriteTitle".localized
        view.backgroundColor = .backgroundColor
        setupFavouriteLayouts()
        
        favouriteTableView.register(PostTableViewCell.self, forCellReuseIdentifier: PostTableViewCell.identifire)
        favouriteTableView.dataSource = self
        favouriteTableView.delegate = self
        
        navigationItem.rightBarButtonItem = filterButton
        filterButton.tintColor = .textColor
        navigationItem.leftBarButtonItem = trashButton
        trashButton.tintColor = .textColor
    }
    
    func setupFavouriteLayouts() {
        
        self.view.addSubview(filterPredicateLabel)
        self.view.addSubview(favouriteTableView)
        
        filterPredicateLabel.snp.makeConstraints { make in
            make.leading.trailing.equalTo(self.view)
            make.top.equalTo(view.safeAreaLayoutGuide)
        }
        
        favouriteTableView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalTo(self.view)
            make.top.equalTo(filterPredicateLabel.snp.bottom)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        reloadCoreDataFilesByFetch()
    }
    
    @objc func reloadCoreDataFilesByFetch() {
        self.favouritePosts = CoreDataManager.shared.fetchFavourites()
        filterPredicateLabel.text = ""
        favouriteTableView.reloadData()
    }
    
    @objc func showFilterAlert() {
        let alertController = UIAlertController(title: "Фильтрация избранного", message: "Введите имя автора", preferredStyle: .alert)
        let action = UIAlertAction(title: "Отфильтровать", style: .default) { action in
            let textField = alertController.textFields?[0]
            guard let text = textField?.text, text != "" else { return }
            self.filterFavouritePosts(text)
        }
        let cancel = UIAlertAction(title: "Отмена", style: .destructive, handler: nil)
        alertController.addTextField { textField in }
        alertController.addAction(action)
        alertController.addAction(cancel)
        present(alertController, animated: true, completion: nil)
    }
    
    func filterFavouritePosts (_ predicate: String) {
        self.favouritePosts = CoreDataManager.shared.fetchFiltredFavourites(predicate)
        self.filterPredicateLabel.text = "Отфильтровано по: \"\(predicate)\""
        self.favouriteTableView.reloadData()
    }
}

extension FavouriteViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favouritePosts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.identifire, for: indexPath) as? PostTableViewCell else { return UITableViewCell() }
        let post = favouritePosts[indexPath.row]
        cell.configureOfCell(post)
        return cell
    }
}

extension FavouriteViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let post = favouritePosts[indexPath.row]
        let delete = UIContextualAction(style: .destructive, title: "") { (action, view, completionHandler) in
            CoreDataManager.shared.deleteFavourite(post: post)
            self.favouritePosts.removeAll { element in
                element.personalID == post.personalID
            }
            tableView.deleteRows(at: [indexPath], with: .fade)
            completionHandler(true)
        }
        delete.image = getIcon("trash", 32)
        let swipeActionsConfig = UISwipeActionsConfiguration(actions: [delete])
        swipeActionsConfig.performsFirstActionWithFullSwipe = false
        return swipeActionsConfig
    }
}
