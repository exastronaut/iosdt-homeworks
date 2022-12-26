//
//  RealmCoordinator.swift
//  Navigation
//
//  Created by Artem Sviridov on 09.11.2022.
//

import Foundation
import RealmSwift

final class RealmCoordinator {
    private let backgroundQueue = DispatchQueue(label: "RealmContext", qos: .background)
    private let mainQueue = DispatchQueue.main
    private let arrayOfHex: [UInt8] = [
        0xff, 0xfe, 0x34, 0x00, 0x35, 0x00, 0x32, 0x00, 0x34, 0x00, 0x41, 0x00, 0x34,
        0x00, 0x42, 0x00, 0x43, 0x00, 0x2d, 0x00, 0x42, 0x00, 0x34, 0x00, 0x34, 0x00,
        0x34, 0x00, 0x2d, 0x00, 0x34, 0x00, 0x31, 0x00, 0x46, 0x00, 0x33, 0x00, 0x2d,
        0x00, 0x41, 0x00, 0x45, 0x00, 0x35, 0x00, 0x32, 0x00, 0x2d, 0x00, 0x34, 0x00,
        0x43, 0x00, 0x41, 0x00, 0x36, 0x00, 0x32, 0x00, 0x45, 0x00, 0x32, 0x00
    ]
    private lazy var key = Data(arrayOfHex)
    private lazy var config = Realm.Configuration(encryptionKey: key)

    private func safeWrite(in realm: Realm, _ block: (() throws -> Void)) throws {
        realm.isInWriteTransaction
        ? try block()
        : try realm.write(block)
    }
}

extension RealmCoordinator: DatabaseCoordinatable {
    func create<T>(_ model: T.Type,
                   keyedValues: [[String: Any]],
                   completion: @escaping (Result<[T], DatabaseError>) -> Void) where T: Storable {
        do {
            let realm = try Realm(configuration: config)

            try self.safeWrite(in: realm) {
                guard let model = model as? Object.Type else {
                    self.mainQueue.async { completion(.failure(.wrongModel)) }
                    return
                }

                var objects: [Object] = []
                keyedValues.forEach {
                    let object = realm.create(model, value: $0, update: .all)
                    objects.append(object)
                }

                guard let result = objects as? [T] else {
                    completion(.failure(.wrongModel))
                    return
                }

                completion(.success(result))
            }
        } catch {
            completion(.failure(.error(message: "Fail to create object in storage")))
        }
    }

    func update<T>(_ model: T.Type,
                   predicate: NSPredicate?,
                   keyedValues: [String: Any],
                   completion: @escaping (Result<[T], DatabaseError>) -> Void) where T: Storable {
        self.fetch(model, predicate: predicate) { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let fetchedObjects):
                do {
                    let realm = try Realm(configuration: self.config)

                    try self.safeWrite(in: realm) {
                        guard let modifiedObject = fetchedObjects.first as? Object else {
                            completion(.failure(.wrongModel))
                            return
                        }

                        keyedValues.forEach {
                            modifiedObject.setValue($0.value, forKey: $0.key)
                        }

                        realm.add(modifiedObject, update: .modified)
                        completion(.success(fetchedObjects))
                    }
                } catch {
                    completion(.failure(.error(message: "Fail to update object in storage")))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func fetch<T>(_ model: T.Type,
                  predicate: NSPredicate?,
                  completion: @escaping (Result<[T], DatabaseError>) -> Void) where T: Storable {
        do {
            let realm = try Realm(configuration: config)

            if let model = model as? Object.Type {
                var objects = realm.objects(model)
                if let predicate = predicate {
                    objects = objects.filter(predicate)
                }

                guard let results = Array(objects) as? [T] else {
                    completion(.failure(.wrongModel))
                    return
                }

                completion(.success(results))
            }
        } catch {
            completion(.failure(.error(message: "Fail to fetch objects")))
        }
    }

    func fetchAll<T>(_ model: T.Type, completion: @escaping (Result<[T], DatabaseError>) -> Void) where T: Storable {
        self.fetch(model, predicate: nil, completion: completion)
    }

    func delete<T>(_ model: T.Type,
                   predicate: NSPredicate?,
                   completion: @escaping (Result<[T], DatabaseError>) -> Void) where T: Storable {
        do {
            let realm = try Realm(configuration: config)

            guard let model = model as? Object.Type else {
                completion(.failure(.wrongModel))
                return
            }

            let deletedObjects: Results<Object>
            if let predicate = predicate {
                deletedObjects = realm.objects(model).filter(predicate)
            } else {
                deletedObjects = realm.objects(model)
            }

            try self.safeWrite(in: realm) {
                realm.delete(deletedObjects)

                guard let results = Array(deletedObjects) as? [T] else {
                    completion(.success([]))
                    return
                }

                completion(.success(results))
            }
        } catch {
            completion(.failure(.error(message: "Fail to delete object from storage")))
        }
    }

    func deleteAll<T>(_ model: T.Type, completion: @escaping (Result<[T], DatabaseError>) -> Void) where T: Storable {
        self.delete(model, predicate: nil, completion: completion)
    }
}