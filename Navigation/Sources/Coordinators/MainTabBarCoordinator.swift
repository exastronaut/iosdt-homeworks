//
//  TabCoordinator.swift
//  Navigation
//
//  Created by Artem Sviridov on 28.11.2022.
//

import UIKit

protocol MainTabBarCoordinatorOutput: AnyObject {
    func didFinishMain()
}

final class MainTabBarCoordinator: Coordinator {
    private let presenter: UINavigationController
    private let tabBarController: UITabBarController
    private weak var output: MainTabBarCoordinatorOutput?
    private var feedCoordinator: FeedCoordinator?
    private var profileCoordinator: ProfileCoordinator?
    
    init(presenter: UINavigationController, output: MainTabBarCoordinatorOutput?) {
        self.presenter = presenter
        self.output = output

        tabBarController = .init()
    }

    func start() {
        let pages: [TabBarPage] = [.feed, .profile].sorted {
            $0.pageOrderNumber() < $1.pageOrderNumber()
        }
        let controllers = pages.map { getTabController($0) }
        prepareTabBarController(with: controllers)
    }
}

// MARK: - Private functions

private extension MainTabBarCoordinator {
    func prepareTabBarController(with controllers: [UINavigationController]) {
        tabBarController.setViewControllers(controllers, animated: true)
        tabBarController.selectedIndex = TabBarPage.feed.pageOrderNumber()
        presenter.viewControllers = [tabBarController]
    }

    func getTabController(_ page: TabBarPage) -> UINavigationController {
        let navigationController = UINavigationController()
        navigationController.tabBarItem =  UITabBarItem(
            title: page.pageTitleValue(),
            image: page.pageIcon(),
            tag: page.pageOrderNumber()
        )

        switch page {
        case .feed:
            let feedCoordinator = FeedCoordinator(presenter: navigationController, output: self)
            feedCoordinator.start()

            self.feedCoordinator = feedCoordinator
        case .profile:
            let profileCoordinator = ProfileCoordinator(presenter: navigationController, output: self)
            profileCoordinator.start()

            self.profileCoordinator = profileCoordinator
        }

        return navigationController
    }
}

// MARK: - FeedCoordinatorOutput

extension MainTabBarCoordinator: FeedCoordinatorOutput {
    func didTapCell(with post: PostModel) {
        profileCoordinator?.update(with: post)
    }

    func didTapButton() {
        output?.didFinishMain()
    }
}

// MARK: - ProfileCoordinatorOutput

extension MainTabBarCoordinator: ProfileCoordinatorOutput { }
