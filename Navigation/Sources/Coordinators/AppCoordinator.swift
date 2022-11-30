//
//  AppCoordinator.swift
//  Navigation
//
//  Created by Artem Sviridov on 27.11.2022.
//

import UIKit

final class AppCoordinator: Coordinator {
    private let window: UIWindow
    private let rootViewController: UINavigationController
    private var logInCoordinator: LogInCoordinator?
    private var mainTabBarCoordinator: MainTabBarCoordinator?

    init(window: UIWindow) {
        self.window = window
        rootViewController = .init()
        rootViewController.navigationBar.isHidden = true
        window.backgroundColor = .systemBackground
    }

    func start() {
        runAuthFlow()
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
    }
}

//MARK: - Private functions 

private extension AppCoordinator {
    func runAuthFlow() {
        let logInCoordinator = LogInCoordinator(presenter: rootViewController, output: self)
        logInCoordinator.start()

        self.logInCoordinator = logInCoordinator
    }

    func runMainFlow() {
        let mainTabBarCoordinator = MainTabBarCoordinator(presenter: rootViewController, output: self)
        mainTabBarCoordinator.start()

        self.mainTabBarCoordinator = mainTabBarCoordinator
    }
}

//MARK: - LogInCoordinatorOutput

extension AppCoordinator: LogInCoordinatorOutput {
    func didFinishAuth() {
        runMainFlow()
        logInCoordinator = nil
    }
}

//MARK: - TabCoordinatorOutput

extension AppCoordinator: MainTabBarCoordinatorOutput {
    func didFinishMain() {
        rootViewController.viewControllers.removeAll()
        runAuthFlow()
        mainTabBarCoordinator = nil
    }
}
