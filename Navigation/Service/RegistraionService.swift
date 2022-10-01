//
//  RegistraionService.swift
//  Navigation
//
//  Created by Артем Свиридов on 25.09.2022.
//

protocol RegistrationServiceProtocol {

    typealias TokenResponse = (Result<String, AppError>) -> Void

    func getToken(login: String, password: String, completion: @escaping TokenResponse) 

}

struct RegistrationService: RegistrationServiceProtocol  {

    func getToken(login: String, password: String, completion: @escaping TokenResponse) {
        if !login.isEmpty && !password.isEmpty {
            completion(.success(.generateToken()))
        } else {
            completion(.failure(.unautorized))
        }
    }

}
