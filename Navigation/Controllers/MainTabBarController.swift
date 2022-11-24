//
//  MainTabBarController.swift
//  Navigation
//
//  Created by Артем Свиридов on 04.03.2022.
//

import UIKit

final class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }

    private func setupTabBar() {
        let feedViewController = createNavigationController(
            viewController: FeedViewController(model: FeedModel()),
            itemName: "Feed",
            itemImage: "house",
            tag: 0
        )
        let profileViewController = createNavigationController(
            viewController: ProfileViewController(),
            itemName: "Profile",
            itemImage: "person",
            tag: 1
        )

        viewControllers = [feedViewController, profileViewController]
    }

    private func createNavigationController(viewController: UIViewController,
                                            itemName: String,
                                            itemImage: String,
                                            tag: Int) -> UINavigationController {
        let item = UITabBarItem(
            title: itemName,
            image: UIImage(systemName: itemImage)?.withAlignmentRectInsets(.init(top: 10, left: 0, bottom: 0, right: 0)),
            tag: tag
        )
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.tabBarItem = item

        return navigationController
    }
}
