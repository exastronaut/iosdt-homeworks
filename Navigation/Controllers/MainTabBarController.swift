//
//  MainTabBarController.swift
//  Navigation
//
//  Created by Артем Свиридов on 04.03.2022.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }

    private func setupTabBar() {
        let feedViewController = createNavigationController(
            viewController: FeedViewController(model: FeedModel()),
            itemName: "Feed",
            itemImage: "house"
        )
        let logInViewController = createNavigationController(
            viewController: LogInViewController(),
            itemName: "Profile",
            itemImage: "person"
        )

        viewControllers = [feedViewController, logInViewController]
    }

    private func createNavigationController(viewController: UIViewController, itemName: String, itemImage: String) -> UINavigationController {
        let item = UITabBarItem(title: itemName,
                                image: UIImage(systemName: itemImage)?.withAlignmentRectInsets(.init(top: 10, left: 0, bottom: 0, right: 0)),
                                tag: 0)
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.tabBarItem = item

        return navigationController
    }
}
