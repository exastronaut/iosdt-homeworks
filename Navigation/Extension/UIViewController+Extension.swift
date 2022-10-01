//
//  UIViewController+Extension.swift
//  Navigation
//
//  Created by Артем Свиридов on 25.09.2022.
//

import UIKit

extension UIViewController {

    func showAlert(for type: AppError) {
        var message = ""

        switch type {
        case .unautorized:
            message = "Please log in"
        case .notFound:
            message = "Token not found"
        case .noConnection:
            message = "Please try again later"
        }

        let alert = UIAlertController(title: "Error",
                                      message: message,
                                      preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alert.addAction(action)

        present(alert, animated: true)
    }
    
}
