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
    private weak var profileModuleInput: ProfileModuleInput?

    init(presenter: UINavigationController, output: ProfileCoordinatorOutput?) {
        self.presenter = presenter
        self.output = output
    }

    func start() {
        let module = ProfileScreenModuleAssembly.buildModule(moduleOutput: self)
        profileModuleInput = module.moduleInput
        presenter.pushViewController(module.screen, animated: true)
    }

    func update(with post: PostModel) {
        profileModuleInput?.update(with: post)
    }
}

// MARK: - ProfileModuleOutput

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
