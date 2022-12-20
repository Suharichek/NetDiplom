//
//  PostTableViewCellViewModel.swift
//  Navigation
//
//  Created by Suharik on 15.11.2022.
//

import Foundation
import UIKit

public class PostTableViewCellViewModel {
    
    var post: Post
    
    var author: String {
        return post.author
    }
    
    var title: String {
        return post.title
    }
    
    var description: String {
        return post.description
    }
    
    var image: UIImage {
        return post.image
    }
    
    var likes: Int {
        return post.likes
    }
    
    var views: Int {
        return post.views
    }
    
    init(post: Post) {
        self.post = post
    }
}
