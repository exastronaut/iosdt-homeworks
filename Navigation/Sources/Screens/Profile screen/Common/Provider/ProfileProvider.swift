//
//  ProfileProvider.swift
//  Navigation
//
//  Created by Artem Sviridov on 29.11.2022.
//

protocol ProvidesProfile {
    func getCoreDataDatabase() -> DatabaseCoordinatable
}

final class ProfileProvider {
    private let dataStore: StoresProfile

    init(dataStore: StoresProfile) {
        self.dataStore = dataStore
    }
}

extension ProfileProvider: ProvidesProfile {
    func getCoreDataDatabase() -> DatabaseCoordinatable {
        dataStore.coreDataCoordinator
    }
}
