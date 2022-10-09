//
//  CheckerService.swift
//  Navigation
//
//  Created by Артем Свиридов on 05.10.2022.
//

import FirebaseAuth

protocol CheckerServiceProtocol {

    typealias Response = (Result<AuthDataResult?, AuthErrorCode>) -> Void

    func checkCredentials(email: String, password: String, completion: @escaping Response)
    func signUp(email: String, password: String, completion: @escaping Response)

}

struct CheckerService: CheckerServiceProtocol {

    func checkCredentials(email: String, password: String, completion: @escaping Response) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let errorCode = error as? AuthErrorCode {
                completion(.failure(errorCode))
            }

            if let result = result {
                completion(.success(result))
            }
        }
    }

    func signUp(email: String, password: String, completion: @escaping Response) {
        Auth.auth().createUser(withEmail: email, password: password) {  result, error in
            if let errorCode = error as? AuthErrorCode {
                completion(.failure(errorCode))
            }

            if let result {
                completion(.success(result))
            }
        }
    }

}

