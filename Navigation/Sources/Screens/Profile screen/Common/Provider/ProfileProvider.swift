//
//  ProfileProvider.swift
//  Navigation
//
//  Created by Artem Sviridov on 29.11.2022.
//

protocol ProvidesProfile {
    func getPostModels() -> [ProfilePostModel]
}

final class ProfileProvider {
    private let dataStore: StoresProfile

    init(dataStore: StoresProfile) {
        self.dataStore = dataStore
    }
}

extension ProfileProvider: ProvidesProfile {
    func getPostModels() -> [ProfilePostModel] {
        dataStore.postModels
    }
}
