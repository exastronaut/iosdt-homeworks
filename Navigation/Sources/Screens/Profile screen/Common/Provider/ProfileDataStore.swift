//
//  ProfileDataStore.swift
//  Navigation
//
//  Created by Artem Sviridov on 29.11.2022.
//

import CoreData
import Foundation

protocol StoresProfile: AnyObject {
    var coreDataCoordinator: DatabaseCoordinatable { get set }
    var container: NSPersistentContainer? { get set }
}

final class ProfileDataStore: StoresProfile {
    lazy var coreDataCoordinator: DatabaseCoordinatable = createDatabaseCoordinator()
    var container: NSPersistentContainer?

    init() {
        createContainer { container in
            self.container = container
        }
    }
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

    func createContainer(completion: @escaping (NSPersistentContainer) -> Void) {
        let container = NSPersistentContainer(name: "Database")
        container.loadPersistentStores { _, error in
            guard error == nil else {
                fatalError("Failed to load store.")
            }

            completion(container)
        }
    }
}
