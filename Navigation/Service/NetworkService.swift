//
//  NetworkService.swift
//  Navigation
//
//  Created by Артем Свиридов on 01.10.2022.
//

import Foundation

struct NetworkService {

    static func request(for stringURL: String) {
        guard let url = URL(string: stringURL) else { return }

        let session = URLSession.shared
        let task =  session.dataTask(with: url) { data, response, error in
            if let data = data, let string = String(data: data, encoding: .utf8) {
                print(string)
            }
            if let response = response as? HTTPURLResponse {
                print("Status Code: \(response.statusCode), Headers: \(response.allHeaderFields)")
            }
            if let error = error {
                print(error.localizedDescription)
            }
        }

        task.resume()
    }

}
