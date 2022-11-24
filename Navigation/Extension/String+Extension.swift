//
//  String+Extension.swift
//  Navigation
//
//  Created by Артем Свиридов on 25.09.2022.
//

import Foundation

extension String {

    static func generateToken() -> String {
        UUID().uuidString
    }

    static let emptyline = ""
    static let errorTitle = "Error"
    static let minFourCharactersTitle = "Warring"
    static let minFourCharactersMessage = "The password and login must contain at least four characters"
    static let tryAgainMessage = "Please try again"
    static let userNotFoundTitle = "User not found"
    static let userNotFoundMessage = "Create a new user?"
    static let wrongPasswordTitle = "Wrong password"

}
