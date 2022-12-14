//
//  ProfilePresenter.swift
//  Navigation
//
//  Created by Artem Sviridov on 29.11.2022.
//

import Dispatch

final class ProfilePresenter {
    private unowned let view: ProfileScreenInput
    private let interactor: ProfileInteractorProtocol
    private weak var moduleOutput: ProfileModuleOutput?
    private var viewModel = ViewModel()

    init(view: ProfileScreenInput,
         interactor: ProfileInteractorProtocol,
         moduleOutput: ProfileModuleOutput?) {
        self.view = view
        self.interactor = interactor
        self.moduleOutput = moduleOutput
    }
}

// MARK: - Private functions

private extension ProfilePresenter { }

// MARK: - ProfileModuleInput

extension ProfilePresenter: ProfileModuleInput {
    func update(with post: PostModel) {
        interactor.checkPostInDatabase(post) { [weak self] response, error in
            guard let self = self else { return }

            if response {
                self.viewModel.insert(post, at: 0)
                self.view.displayData(self.viewModel)
                self.interactor.addPostInDatabase(post) { response, error in
                    if let message = error {
                        self.view.displayErrorAlert(message)
                    }
                }
            } else if let message = error {
                self.view.displayErrorAlert(message)
            }
        }
    }
}

// MARK: - ProfileScreenOutput

extension ProfilePresenter: ProfileScreenOutput {
    func didTapCancelBarButton() {
        view.configureCancelBarButton(false)
        view.displayData(viewModel)
    }

    func didTapSearchBarButton() {
        view.displaySerachAlert()
    }

    func didTapSearchAlertButton(_ text: String) {
        let filteredViewModel = viewModel.filter { post in
            let separatedStringWithAuthorName = post.author.components(separatedBy: .whitespaces)
            return separatedStringWithAuthorName.contains { $0.uppercased() == text.uppercased() }
        }
        if !filteredViewModel.isEmpty {
            view.displayData(filteredViewModel)
            view.configureCancelBarButton(true)
        } else {
            view.displayWarningAlert(with: "No results found", message: "Please try again")
        }
    }

    func removePostFromDatabase(_ post: PostModel?) {
        guard let removedPost = post else { return }

        interactor.deletePostFromDatabase(removedPost) { [weak self] response, error in
            guard let self = self else { return }

            if response {
                self.viewModel.removeAll { $0.uid == removedPost.uid }
                self.view.displayData(self.viewModel)
            } else if let message = error {
                self.view.displayErrorAlert(message)
            }
        }
    }

    func didTapPhotosCell() {
        moduleOutput?.didTapPhotosCell()
    }

    func loadData() {
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
        interactor.getPostsFromDatabase { [weak self] response, message in
            guard message == nil else {
                self?.view.displayErrorAlert(message)
                dispatchGroup.leave()
                return
            }

            let posts = response.reversed()
            self?.viewModel.append(contentsOf: posts)
            dispatchGroup.leave()
        }

        dispatchGroup.notify(queue: .main) {
            self.view.displayData(self.viewModel)
        }
    }
}

extension ProfilePresenter {
    typealias ViewModel = [PostModel]
}
