//
//  FeedScreenModuleAssembly.swift
//  Navigation
//
//  Created by Artem Sviridov on 27.11.2022.
//

import UIKit

final class FeedScreenModuleAssembly {
    static func buildModule(moduleOutput: FeedModuleOutput) -> UIViewController {
        let view = FeedScreen()
        let dataStore = FeedDataStore()
        let provider = FeedProvider(dataStore: dataStore)
        let interactor = FeedInteractor(provider: provider)
        let presenter = FeedPresenter(
            view: view,
            interactor: interactor,
            moduleOutput: moduleOutput
        )
        view.output = presenter

        return view
    }
}
