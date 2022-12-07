//
//  DatabaseCoordinatable.swift
//  Navigation
//
//  Created by Artem Sviridov on 30.11.2022.
//

import Foundation

enum DatabaseError: Error {
    /// Невозможно добавить хранилище.
    case store(model: String)
    /// Не найден momd файл.
    case find(model: String, bundle: Bundle?)
    /// Не найдена модель объекта.
    case wrongModel
    /// Кастомная ошибка.
    case error(desription: String)
    /// Неизвестная ошибка.
    case unknown(error: Error)
}

protocol DatabaseCoordinatable {
    typealias ResultHandler<T> = (Result<[T], DatabaseError>) -> Void

    /// Создание объекта заданного типа.
    func create<T: Storable>(_ model: T.Type, keyedValues: [[String: Any]], completion: @escaping ResultHandler<T>)
    /// Обновление объекта заданного типа с помощью предиката.
    func update<T: Storable>(_ model: T.Type,
                             predicate: NSPredicate?,
                             keyedValues: [String: Any],
                             completion: @escaping ResultHandler<T>)
    /// Удаление объектов заданного типа с помощью предиката.
    func delete<T: Storable>(_ model: T.Type, predicate: NSPredicate?, completion: @escaping ResultHandler<T>)
    /// Удаление всех объектов заданного типа.
    func deleteAll<T: Storable>(_ model: T.Type, completion: @escaping ResultHandler<T>)
    /// Получение объектов заданного типа с помощью предиката.
    func fetch<T: Storable>(_ model: T.Type, predicate: NSPredicate?, completion: @escaping ResultHandler<T>)
    /// Получение объектов заданного типа.
    func fetchAll<T: Storable>(_ model: T.Type, completion: @escaping ResultHandler<T>)
}
