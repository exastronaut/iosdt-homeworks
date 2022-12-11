//
//  ProfileDataStore.swift
//  Navigation
//
//  Created by Artem Sviridov on 29.11.2022.
//

import Foundation

protocol StoresProfile: AnyObject {
    var coreDataCoordinator: DatabaseCoordinatable { get set }
}

final class ProfileDataStore: StoresProfile {
    lazy var coreDataCoordinator: DatabaseCoordinatable = createDatabaseCoordinator()
}

private extension ProfileDataStore {
    func createDatabaseCoordinator() -> DatabaseCoordinatable {
        let bundle = Bundle.main
        guard let url = bundle.url(forResource: "Database", withExtension: "momd") else {
            fatalError("Can't find Database.xcdatamodelId in main Bundle")
        }

        switch CoreDataCoordinator.create(url: url) {
        case .success(let database):
            return database
        case .failure:
            switch CoreDataCoordinator.create(url: url) {
            case .success(let database):
                return database
            case .failure(let error):
                fatalError("Unable to create CoreData Database. Error - \(error.localizedDescription)")
            }
        }
    }
}
