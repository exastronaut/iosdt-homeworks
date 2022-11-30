//
//  ProfileInteractor.swift
//  Navigation
//
//  Created by Artem Sviridov on 29.11.2022.
//

protocol ProfileInteractorProtocol: AnyObject {
    func getData() -> ProfilePresenter.Response
}

final class ProfileInteractor {
    private let provider: ProvidesProfile

    init(provider: ProvidesProfile) {
        self.provider = provider
    }
}

// MARK: - ProfileInteractorProtocol

extension ProfileInteractor: ProfileInteractorProtocol {
    func getData() -> ProfilePresenter.Response {
        provider.getPostModels()
    }
}
