//
//  FeedInteractor.swift
//  Navigation
//
//  Created by Artem Sviridov on 05.12.2022.
//

protocol FeedInteractorProtocol: AnyObject {
    func getData() -> FeedPresenter.Response
}

final class FeedInteractor {
    private let provider: ProvidesFeed

    init(provider: ProvidesFeed) {
        self.provider = provider
    }
}

// MARK: - FeedInteractorProtocol

extension FeedInteractor: FeedInteractorProtocol {
    func getData() -> FeedPresenter.Response {
        provider.getPostModels()
    }
}
