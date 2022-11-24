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

        let alert = UIAlertController(title: .errorTitle,
                                      message: message,
                                      preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alert.addAction(action)

        present(alert, animated: true)
    }

    func showAlert(title: String,
                   message: String,
                   actions: [UIAlertAction]? = nil) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        if actions == nil {
            let action = UIAlertAction(title: "OK", style: .default)
            alert.addAction(action)
        } else {
            actions?.forEach { alert.addAction($0) }
        }

        present(alert, animated: true)
    }
    
}
