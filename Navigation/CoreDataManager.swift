//
//  CoreDataManager.swift
//  Navigation
//
//  Created by Suharik on 15.11.2022.
//

import UIKit
import CoreData

final class CoreDataManager {
    
    static let shared = CoreDataManager()
    private let persistentContainer: NSPersistentContainer
    private let fetchRequest: NSFetchRequest<FavouritePostEntity>
    private lazy var context = persistentContainer.viewContext
    
    private lazy var saveContext: NSManagedObjectContext = {
        let saveContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        saveContext.persistentStoreCoordinator = self.persistentContainer.persistentStoreCoordinator
        saveContext.mergePolicy = NSOverwriteMergePolicy
        return saveContext
    }()
    
    private init() {
        let container = NSPersistentContainer(name: "FavouritePostModel")
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Неудалось загрузить постоянное хранилище: \(error)")
            }
        }
        self.persistentContainer = container
        self.fetchRequest = FavouritePostEntity.fetchRequest()
    }
    
    func fetchFavourites() -> [Post] {
        var fetchedPosts = [Post]()
        var favouritePosts = [FavouritePostEntity]()
        do {
            favouritePosts = try context.fetch(fetchRequest)
            for favourite in favouritePosts {
                let image = UIImage(data: favourite.image ?? Data()) ?? UIImage()
                let post = Post(
                    author: favourite.author ?? "",
                    title: favourite.title ?? "",
                    description: favourite.text ?? "",
                    personalID: favourite.id ?? "", image: image,
                    likes: Int(favourite.likes),
                    views: Int(favourite.views))
                fetchedPosts.append(post)
            }
        } catch let error {
            print(error)
        }
        fetchRequest.predicate = nil
        return fetchedPosts
    }
    
    func fetchFiltredFavourites(_ author: String) -> [Post] {
        let predicate = NSPredicate(format: "author = %@", author)
        fetchRequest.predicate = predicate
        return fetchFavourites()
    }
    
    func saveFavourite (post: Post) {
        let favouritePosts = fetchFavourites()
        if favouritePosts.contains(where: { $0.personalID == post.personalID }) {
            print("Пост уже добавлен в избранное")
            return
        } else {
            saveContext.perform {
                let newFavourite = FavouritePostEntity(context: self.saveContext)
                newFavourite.title = post.title
                newFavourite.author = post.author
                newFavourite.text = post.description
                newFavourite.likes = Int64(post.likes)
                newFavourite.views = Int64(post.views)
                newFavourite.image =  post.image.pngData()
                newFavourite.id = post.personalID
                do {
                    try self.saveContext.save()
                    print("Сохранено: \(post.title)")
                } catch let error {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func deleteFavourite (post: Post) {
        var favouritePosts = [FavouritePostEntity]()
        do {
            favouritePosts = try saveContext.fetch(fetchRequest)
            
            saveContext.perform {
                for favourite in favouritePosts {
                    if post.personalID == favourite.id {
                        self.saveContext.delete(favourite)
                        do {
                            try self.saveContext.save()
                            print("Удалено: \(post.title)")
                        } catch let error {
                            print(error.localizedDescription)
                        }
                    }
                }
            }
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    public func removeFromCoreData() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "FavouritePostEntity")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try context.execute(deleteRequest)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
}
