//
//  PhotosPresenter.swift
//  Navigation
//
//  Created by Artem Sviridov on 30.11.2022.
//

final class PhotosPresenter {

    private unowned let view: PhotosScreenInput
    private weak var moduleOutput: PhotosModuleOutput?

    init(view: PhotosScreenInput,
         moduleOutput: PhotosModuleOutput?) {
        self.view = view
        self.moduleOutput = moduleOutput
    }
}

// MARK: - LogInScreenOutput

extension PhotosPresenter: PhotosScreenOutput {
    func didCloseScreen() {
        moduleOutput?.didCloseScreen()
    }
}
