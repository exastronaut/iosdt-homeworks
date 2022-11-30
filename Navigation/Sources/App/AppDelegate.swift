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
    private var appCoordinator: AppCoordinator?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        let appCoordinator = AppCoordinator(window: window)

        self.window = window
        self.appCoordinator = appCoordinator

        appCoordinator.start()
        return true
    }
}
