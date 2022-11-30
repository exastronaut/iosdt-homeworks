//
//  LogInCoordinator.swift
//  Navigation
//
//  Created by Artem Sviridov on 28.11.2022.
//

import UIKit

protocol LogInCoordinatorOutput: AnyObject {
    func didFinishAuth()
}

final class LogInCoordinator: Coordinator {
    private let presenter: UINavigationController
    private weak var output: LogInCoordinatorOutput?

    init(presenter: UINavigationController, output: LogInCoordinatorOutput?) {
        self.presenter = presenter
        self.output = output
    }

    func start() {
        let screen = LogInScreenModuleAssembly.buildModule(moduleOutput: self)
        presenter.pushViewController(screen, animated: true)
    }
}

// MARK: - LogInModuleOutput

extension LogInCoordinator: LogInModuleOutput {
    func didTapLogInButton() {
        output?.didFinishAuth()
    }
}
