//
//  UIViewController+Extension.swift
//  Navigation
//
//  Created by Артем Свиридов on 25.09.2022.
//

import UIKit

extension UIViewController {
    func showAlert(with title: String? = nil, message: String? = nil) {
        let alertTitle: String = title ?? "Error"
        let alertMessage: String = message ?? "Unknown error"
        let alert = UIAlertController(title: alertTitle,
                                      message: alertMessage,
                                      preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alert.addAction(action)

        present(alert, animated: true)
    }
}
