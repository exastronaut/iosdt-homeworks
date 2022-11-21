//
//  UserDefaultsService.swift
//  Navigation
//
//  Created by Artem Sviridov on 19.11.2022.
//

import Foundation

protocol UserDefaultsServiceProtocol {
    func getUserName() -> String?
    func saveUsername(_ username: String)
}

struct UserDefaultsService {
    private let key = "Username"
}

extension UserDefaultsService: UserDefaultsServiceProtocol {
    func getUserName() -> String? {
        UserDefaults.standard.value(forKey: key) as? String
    }

    func saveUsername(_ username: String) {
        UserDefaults.standard.set(username, forKey: key)
    }
}
