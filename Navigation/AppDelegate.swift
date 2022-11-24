//
//  AppDelegate.swift
//  Navigation
//
//  Created by Артем Свиридов on 04.03.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private let realmCoordinator = RealmCoordinator()
    private let userDefaultsService = UserDefaultsService()

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UINavigationController(rootViewController: AppCoordinator.shared.start())
        window?.makeKeyAndVisible()
        return true
    }

    func applicationWillTerminate(_ application: UIApplication) {
        guard let username = userDefaultsService.getUserName() else { return }

        let predicate = NSPredicate(format: "username == %@", username)
        realmCoordinator.update(
            UserCredentialsRealmModel.self,
            predicate: predicate,
            keyedValues: ["isAuth": false]
        ) { result in
            switch result {
            case .success:
                ()
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
     }
}

