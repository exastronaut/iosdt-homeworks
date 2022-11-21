//
//  AppCoordinator.swift
//  Navigation
//
//  Created by Artem Sviridov on 19.11.2022.
//

import UIKit

final class AppCoordinator {

    static let shared = AppCoordinator()
    private let userDefaultsService = UserDefaultsService()
    private let realmCoordinator = RealmCoordinator()
    private var state: State = .auth

    // MARK: - Initialization

    private init() { }

    func start() -> UIViewController {
        guard let username = userDefaultsService.getUserName() else {
            return runAuthFlow()
        }

        let predicate = NSPredicate(format: "username == %@", username)
        realmCoordinator.fetch(UserCredentialsRealmModel.self, predicate: predicate) { result in
            switch result {
            case .success(let success):
                if success.isEmpty {
                    self.state = .auth
                } else {
                    if let isAuth = success.first?.isAuth, isAuth {
                        self.state = .main
                    } else {
                        self.state = .auth
                    }
                }
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }

        return state == .auth ? runAuthFlow(username: username) : runMainFlow()
    }

}


// MARK: - Private functions

private extension AppCoordinator {

    func runAuthFlow(username: String? = nil) -> UIViewController {
        let loginScreen = LogInViewController(username: username)
        return loginScreen
    }
    
    func runMainFlow()  -> UIViewController {
        let mainScreen = MainTabBarController()
        return mainScreen
    }

}

extension AppCoordinator {
    enum State {
        case auth
        case main
    }
}
