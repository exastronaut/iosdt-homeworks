//
//  FeedProvider.swift
//  Navigation
//
//  Created by Artem Sviridov on 05.12.2022.
//

protocol ProvidesFeed {
    func getPostModels() -> [PostModel]
}

final class FeedProvider {
    private let dataStore: StoresFeed

    init(dataStore: StoresFeed) {
        self.dataStore = dataStore
    }
}

extension FeedProvider: ProvidesFeed {
    func getPostModels() -> [PostModel] {
        dataStore.postModels
    }
}
