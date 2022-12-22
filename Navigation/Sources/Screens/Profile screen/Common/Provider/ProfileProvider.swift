//
//  ProfileProvider.swift
//  Navigation
//
//  Created by Artem Sviridov on 29.11.2022.
//

import CoreData

protocol ProvidesProfile {
    func getCoreDataDatabase() -> DatabaseCoordinatable
    func getContext() -> NSManagedObjectContext?
}

final class ProfileProvider {
    private let dataStore: StoresProfile

    init(dataStore: StoresProfile) {
        self.dataStore = dataStore
    }
}

extension ProfileProvider: ProvidesProfile {
    func getContext() -> NSManagedObjectContext? {
        dataStore.container.map { $0.viewContext }
    }

    func getCoreDataDatabase() -> DatabaseCoordinatable {
        dataStore.coreDataCoordinator
    }
}
