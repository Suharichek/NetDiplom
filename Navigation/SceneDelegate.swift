//
//  SceneDelegate.swift
//  Navigation
//
//  Created by Suharik on 11.03.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    private var viewModel = ProfileViewModel()
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = createTabBarController()
        window?.makeKeyAndVisible()
        DispatchQueue.global().async {
            createPhotosArray()
            createHistoryArray()
        }
    }
    
    func createFeedViewController() -> UINavigationController {
        let feedViewController = FeedViewController(viewModel: viewModel)
        feedViewController.tabBarItem = UITabBarItem(title: "mainTitle".localized, image: UIImage(systemName: "doc.richtext"), tag: 0)
        return UINavigationController(rootViewController: feedViewController)
    }
    func createLoginViewController() -> UINavigationController {
        let logInViewController = LogInViewController()
        let inspector = MyLoginFactory.shared.returnLoginInspector()
        logInViewController.delegate = inspector
        logInViewController.tabBarItem = UITabBarItem(title: "profileTitle".localized, image: UIImage(systemName: "person.circle"), tag: 1)
        return UINavigationController(rootViewController: logInViewController)
    }
    
    func createFavouriteViewController() -> UINavigationController {
        let coordinator = FavouriteCoordinator()
        let favouriteViewController: UIViewController = FavouriteViewController(coordinator: coordinator)
        favouriteViewController.tabBarItem = UITabBarItem(title: "favouriteTitle".localized, image: UIImage(systemName: "heart.text.square.fill"), tag: 0)
        return UINavigationController(rootViewController: favouriteViewController)
    }
    
    func createLocationViewController() -> UINavigationController {
        let locationViewController = LocationViewController()
        locationViewController.tabBarItem = UITabBarItem(title: "locationTitle".localized, image: UIImage(systemName: "map.fill"), tag: 0)
        return UINavigationController(rootViewController: locationViewController)
    }
    
    func createTabBarController() -> UITabBarController {
        let tabBarController = UITabBarController()
        UITabBar.appearance().backgroundColor = .white
        tabBarController.viewControllers = [createLoginViewController(), createFeedViewController(), createFavouriteViewController(), createLocationViewController()]
        return tabBarController
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        
    }
}

public extension String {
    var localized: String {
        NSLocalizedString(self, comment: "")
    }
}

public extension UIViewController {
    
    func getIcon (_ name: String, _ size: CGFloat) -> UIImage {
        UIImage(systemName: name, withConfiguration: UIImage.SymbolConfiguration(pointSize: size))?.withTintColor(.white, renderingMode: .alwaysOriginal) ?? UIImage()
    }
}

