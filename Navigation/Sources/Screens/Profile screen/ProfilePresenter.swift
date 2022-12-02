//
//  ProfilePresenter.swift
//  Navigation
//
//  Created by Artem Sviridov on 29.11.2022.
//

final class ProfilePresenter {
    private unowned let view: ProfileScreenInput
    private let interactor: ProfileInteractorProtocol
    private weak var moduleOutput: ProfileModuleOutput?

    init(view: ProfileScreenInput,
         interactor: ProfileInteractorProtocol,
         moduleOutput: ProfileModuleOutput?) {
        self.view = view
        self.interactor = interactor
        self.moduleOutput = moduleOutput
    }
}

private extension ProfilePresenter { }

// MARK: - LogInScreenOutput

extension ProfilePresenter: ProfileScreenOutput {
    func didTapPhotosCell() {
        moduleOutput?.didTapPhotosCell()
    }

    func loadData() {
        let response = interactor.getData()
        var viewModel = ViewModel()
        viewModel.append(response)
        view.displayData(viewModel)
    }
}

extension ProfilePresenter {
    typealias Response = [PostModel]
    typealias ViewModel = [[PostModel]]
}
