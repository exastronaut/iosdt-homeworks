//
//  UserCredentialRealmModel.swift
//  Navigation
//
//  Created by Artem Sviridov on 09.11.2022.
//

import Foundation
import RealmSwift

final class UserCredentialsRealmModel: Object {
    @objc dynamic var username: String = ""
    @objc dynamic var password: String = ""

    override static func primaryKey() -> String? {
        return "username"
    }

    convenience init(credentials: Credentials) {
        self.init()
        self.username = credentials.username
        self.password = credentials.password
    }
}
