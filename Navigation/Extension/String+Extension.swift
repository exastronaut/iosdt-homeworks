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

    // MARK: - Alert messages

    /// Message with text "Please fill in login and password fields"
    static let errorEmptyFields = "Please fill in login and password fields"

    static let successMessage = "User successfully created!"

    // MARK: FirebaseAuth errors

    /// Error with text "The email address is badly formatted."
    static let error17008 = "The email address is badly formatted."

    /// Error with text "The password is invalid or the user does not have a password."
    static let error17009 =  "The password is invalid or the user does not have a password."

    /// Error with text "There is no user record corresponding to this identifier. The user may have been deleted."
    static let error17011 = "There is no user record corresponding to this identifier. The user may have been deleted."

    // MARK: - Alert titles

    /// Title with text "Error"
    static let errorTitle = "Error"

    /// Title with text "Would you like to sign up?"
    static let signUpTitle = "Would you like to sign up?"

    static let successTitle = "Success"

    // MARK: - Alert action titles

    /// Action title with text "OK"
    static let okAction = "OK"

    /// Action title with text "Cancel"
    static let cancelAction = "Cancel"

    static let signUpAction = "Sign up"

}
