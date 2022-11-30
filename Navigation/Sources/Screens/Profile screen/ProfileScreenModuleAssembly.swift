//
//  ProfileScreenModuleAssembly.swift
//  Navigation
//
//  Created by Artem Sviridov on 28.11.2022.
//

import UIKit

final class ProfileScreenModuleAssembly {
    static func buildModule(moduleOutput: ProfileModuleOutput) -> UIViewController {
        let view = ProfileScreen()
        let dataStore = ProfileDataStore()
        let provider = ProfileProvider(dataStore: dataStore)
        let interactor = ProfileInteractor(provider: provider)
        let presenter = ProfilePresenter(
            view: view,
            interactor: interactor,
            moduleOutput: moduleOutput
        )
        view.output = presenter

        return view
    }
}
