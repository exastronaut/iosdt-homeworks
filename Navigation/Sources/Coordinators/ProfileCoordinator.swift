//
//  ProfileCoordinator.swift
//  Navigation
//
//  Created by Artem Sviridov on 29.11.2022.
//

import UIKit

protocol ProfileCoordinatorOutput: AnyObject { }

final class ProfileCoordinator: Coordinator {
    private let presenter: UINavigationController
    private weak var output: ProfileCoordinatorOutput?
    private var photosCoordinator: PhotosCoordinator?

    init(presenter: UINavigationController, output: ProfileCoordinatorOutput?) {
        self.presenter = presenter
        self.output = output
    }

    func start() {
        let screen = ProfileScreenModuleAssembly.buildModule(moduleOutput: self)
        presenter.pushViewController(screen, animated: true)
    }
}

// MARK: - LogInModuleOutput

extension ProfileCoordinator: ProfileModuleOutput {
    func didTapPhotosCell() {
        let photosCoordinator = PhotosCoordinator(presenter: presenter, output: self)
        photosCoordinator.start()

        self.photosCoordinator = photosCoordinator
    }
}

// MARK: - PhotosCoordinatorOutput

extension ProfileCoordinator: PhotosCoordinatorOutput {
    func didClosePhotosScreen() {
        photosCoordinator = nil
    }
}
