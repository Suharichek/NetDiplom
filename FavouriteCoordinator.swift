//
//  FavouriteCoordinator.swift
//  Navigation
//
//  Created by Suharik on 15.11.2022.
//

import Foundation
import UIKit

final class FavouriteCoordinator {
    func showDetail(coordinator: FavouriteCoordinator) -> UIViewController {
        let viewController = FavouriteViewController(coordinator: coordinator)
        viewController.view.backgroundColor = .secondarySystemGroupedBackground
        viewController.title = "Favourite posts"
        return viewController
    }
}
