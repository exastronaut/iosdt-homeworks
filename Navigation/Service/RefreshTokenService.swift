//
//  RefreshTokenService.swift
//  Navigation
//
//  Created by Артем Свиридов on 25.09.2022.
//

protocol RefreshTokenServiceProtocol {

    typealias TokenResponse = (Result<String, AppError>) -> Void

    func refreshToken(oldToken: String?, completion: @escaping TokenResponse)

}

struct RefreshTokenService: RefreshTokenServiceProtocol  {

    func refreshToken(oldToken: String?, completion: @escaping TokenResponse) {
        if oldToken != nil {
            completion(.success(.generateToken()))
        } else {
            completion(.failure(.notFound))
        }
    }

}
