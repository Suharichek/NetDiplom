//
//  ProfileViewModel.swift
//  Navigation
//
//  Created by Suharik on 15.11.2022.
//

import Foundation
import UIKit

final class ProfileViewModel {
    
    public var posts = [
        
        Post (author: "Юлия",
              title: "Finn",
              description: "Finn Mertens (also called Finn the Human, Pen in the original short, and identified as P-G-8-7 Mertens) is the main protagonist in Adventure Time.",
              personalID: "1",
              image: UIImage(named: "Finn")!,
              likes: 200, views: 4000),
        Post (author: "Александр",
              title: "Jake",
              description: "Jake (full title: Jake the Dog) is the deuteragonist of Adventure Time. He is a dog/shape-shifter hybrid, referred to by others as a magical dog, and Finn's constant companion, best friend, and adoptive brother.",
              personalID: "2",
              image: UIImage(named: "Jake")!, likes: 1000, views: 5000),
        Post (author: "Молли",
              title: "Princess Bubblegum",
              description: "Princess Bonnibel Bonnie Bubblegum (often called PB and occasionally Peebles, Bub-Bubs, or P-Bubs) is one of the main characters of the series Adventure Time and first appeared in the animated short.",
              personalID: "3",
              image: UIImage(named: "Princess")!,
              likes: 150, views: 6000),
        Post (author: "Федор",
              title: "BMO",
              description: "BMO (abbreviated from Be MOre, phonetically spelled Beemo, also referred to as Moe Mastro Llabtoof Giovanni Jr. and called the New King of Ooo in the future) is one of the main characters of Adventure Time.",
              personalID: "4",
              image: UIImage(named: "BMO")!,
              likes: 10, views: 300)
    ]
    
    func numberOfRows() -> Int {
        return posts.count
    }
    
    func cellViewModel(forIndexPath indexPath: IndexPath) -> PostTableViewCellViewModel? {
        let post = posts[indexPath.row]
        return PostTableViewCellViewModel(post: post)
    }
}

