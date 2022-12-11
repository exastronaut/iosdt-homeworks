//
//  FeedCoordinator.swift
//  Navigation
//
//  Created by Artem Sviridov on 29.11.2022.
//

import UIKit

protocol FeedCoordinatorOutput: AnyObject {
    func didTapButton()
    func didTapCell(with post: PostModel)
}

final class FeedCoordinator: Coordinator {
    private let presenter: UINavigationController
    private weak var output: FeedCoordinatorOutput?

    init(presenter: UINavigationController, output: FeedCoordinatorOutput?) {
        self.presenter = presenter
        self.output = output
    }

    func start() {
        let screen = FeedScreenModuleAssembly.buildModule(moduleOutput: self)
        presenter.pushViewController(screen, animated: true)
    }
}

// MARK: - LogInModuleOutput

extension FeedCoordinator: FeedModuleOutput {
    func didTapCell(_ post: PostModel) {
        output?.didTapCell(with: post)
    }

    func didTapButton() {
        output?.didTapButton()
    }
}
