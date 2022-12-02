//
//  ProfileProvider.swift
//  Navigation
//
//  Created by Artem Sviridov on 29.11.2022.
//

protocol ProvidesProfile {
    func getPostModels() -> [PostModel]
}

final class ProfileProvider {
    private let dataStore: StoresProfile

    init(dataStore: StoresProfile) {
        self.dataStore = dataStore
    }
}

extension ProfileProvider: ProvidesProfile {
    func getPostModels() -> [PostModel] {
        dataStore.postModels
    }
}
