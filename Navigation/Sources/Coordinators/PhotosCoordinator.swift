//
//  PhotosCoordinator.swift
//  Navigation
//
//  Created by Artem Sviridov on 30.11.2022.
//

import UIKit

protocol PhotosCoordinatorOutput: AnyObject {
    func didClosePhotosScreen()
}

final class PhotosCoordinator: Coordinator {
    private let presenter: UINavigationController
    private weak var output: PhotosCoordinatorOutput?

    init(presenter: UINavigationController, output: PhotosCoordinatorOutput?) {
        self.presenter = presenter
        self.output = output
    }

    func start() {
        let screen = PhotosScreenModuleAssembly.buildModule(moduleOutput: self)
        presenter.pushViewController(screen, animated: true)
    }
}

// MARK: - PhotosModuleOutput

extension PhotosCoordinator: PhotosModuleOutput {
    func didCloseScreen() {
        output?.didClosePhotosScreen()
    }
}
