//
//  Credentials.swift
//  Navigation
//
//  Created by Artem Sviridov on 14.11.2022.
//

struct Credentials {

     let username: String
     var password: String

    var keyedValues: [String: Any] {
        return [
            "username": self.username,
            "password": self.password
        ]
    }
 }
