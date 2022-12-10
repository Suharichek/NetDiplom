//
//  PostTableViewCell.swift
//  Navigation
//
//  Created by Suharik on 03.04.2022.
//

import UIKit
import SnapKit

class PostTableViewCell: UITableViewCell {
    static let identifire = "PostTableViewCell"
    
    private let contentMyView: UIView = {
        var view = UIView()
        view.backgroundColor = .backgroundColor
        return view
    }()
    
    private let postImage: UIImageView = {
        var postImageView = UIImageView()
        postImageView.contentMode = .scaleAspectFit
        postImageView.backgroundColor = .imageBackColor
        return postImageView
    }()
    
    private lazy var postAuthor: UILabel = {
        let postAuthor = UILabel()
        postAuthor.numberOfLines = 2
        postAuthor.font = UIFont.systemFont(ofSize: 20, weight: .light)
        postAuthor.textColor = .textColor
        return postAuthor
    }()
    
    let postID: UILabel = {
        var postAuthor = UILabel()
        postAuthor.lineBreakMode = .byWordWrapping
        postAuthor.numberOfLines = 0
        postAuthor.font = UIFont.boldSystemFont(ofSize: 20)
        postAuthor.textColor = .textColor
        return postAuthor
    }()
    
    private let postDescription: UILabel = {
        var postDescription = UILabel()
        postDescription.lineBreakMode = .byWordWrapping
        postDescription.numberOfLines = 0
        postDescription.font = .systemFont(ofSize: 14)
        postDescription.textColor = .textColor
        return postDescription
    }()
    
    private let postLikes: UILabel = {
        var postLikes = UILabel()
        postLikes.font = .systemFont(ofSize: 16)
        postLikes.textColor = .textColor
        return postLikes
    }()
    
    var imageLikes: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "heart.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 16))?.withTintColor(.textColor, renderingMode: .alwaysOriginal)
        return image
    }()
    
    private let postViews: UILabel = {
        var postViews = UILabel()
        postViews.font = .systemFont(ofSize: 16)
        postViews.textColor = .textColor
        return postViews
    }()
    
    var imageViews: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "eye.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 16))?.withTintColor(.textColor, renderingMode: .alwaysOriginal)
        return image
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        customizeCell()
        setupContent()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    weak var viewModel: PostTableViewCellViewModel? {
        willSet(viewModel) {
            guard let viewModel = viewModel else { return }
            postAuthor.text = "Автор: \(viewModel.author)"
            postID.text = viewModel.title
            postDescription.text = viewModel.description
            postImage.image = viewModel.image
            postLikes.text = "\(viewModel.likes)"
            postViews.text = "\(viewModel.views)"
        }
    }
    
    public func configureOfCell (_ post: Post) {
        self.postID.text = post.title
        self.postAuthor.text = "Автор: \(post.author)"
        self.postImage.image = post.image
        self.postDescription.text = post.description
        self.postLikes.text = "\(post.likes)"
        self.postViews.text = "\(post.views)"
    }
    
    private func customizeCell() {
        contentView.backgroundColor = .backgroundColor
    }
    
    private func setupContent(){
        contentView.addSubview(contentMyView)
        contentView.addSubview(postAuthor)
        contentView.addSubview(postID)
        contentView.addSubview(postImage)
        contentView.addSubview(postDescription)
        contentView.addSubview(postLikes)
        contentView.addSubview(imageLikes)
        contentView.addSubview(postViews)
        contentView.addSubview(imageViews)
        
        contentMyView.snp.makeConstraints { make in
            make.leading.top.trailing.bottom.equalToSuperview()
        }
        
        postID.snp.makeConstraints { make in
            make.top.equalTo(contentMyView.snp.top).inset(8)
            make.leading.equalTo(contentMyView.snp.leading).inset(16)
        }
        
        postAuthor.snp.makeConstraints { make in
            make.top.equalTo(contentMyView.snp.top).offset(8)
            make.trailing.equalTo(contentMyView.snp.trailing).inset(16)
        }
        
        postImage.snp.makeConstraints { make in
            make.top.equalTo(postAuthor.snp.bottom).offset(8)
            make.leading.equalTo(contentMyView.snp.leading)
            make.width.height.equalTo(contentMyView.snp.width)
        }
        
        postDescription.snp.makeConstraints { make in
            make.top.equalTo(postImage.snp.bottom).offset(16)
            make.leading.equalTo(contentMyView.snp.leading).inset(16)
            make.trailing.equalTo(contentMyView.snp.trailing).inset(16)
        }
        
        imageLikes.snp.makeConstraints { make in
            make.top.equalTo(postDescription.snp.bottom).offset(3)
            make.leading.equalTo(contentMyView.snp.leading).inset(16)
            make.bottom.equalTo(contentMyView.snp.bottom).inset(3)
        }
        
        postLikes.snp.makeConstraints { make in
            make.top.equalTo(postDescription.snp.bottom).offset(3)
            make.leading.equalTo(imageLikes.snp.trailing).inset(-8)
            make.bottom.equalTo(contentMyView.snp.bottom).inset(3)
        }
        
        imageViews.snp.makeConstraints { make in
            make.top.equalTo(postDescription.snp.bottom).offset(3)
            make.trailing.equalTo(postViews.snp.leading).inset(-8)
            make.bottom.equalTo(contentMyView.snp.bottom).inset(3)
        }
        
        postViews.snp.makeConstraints { make in
            make.top.equalTo(postDescription.snp.bottom).offset(3)
            make.trailing.equalTo(contentMyView).inset(16)
            make.bottom.equalTo(contentMyView.snp.bottom).inset(3)
        }
    }
}
