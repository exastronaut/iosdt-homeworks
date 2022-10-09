//
//  UIViewController+Extension.swift
//  Navigation
//
//  Created by Артем Свиридов on 25.09.2022.
//

import UIKit

extension UIViewController {

    func showAlert(with title: String,
                   for errorMessage: String,
                   actions: [UIAlertAction]? = nil) {
        let alert = UIAlertController(title: title,
                                      message: errorMessage,
                                      preferredStyle: .alert)
        if actions == nil {
            let action = UIAlertAction(title: .okAction, style: .default)
            alert.addAction(action)
        } else {
            actions?.forEach { alert.addAction($0) }
        }

        present(alert, animated: true)
    }
    
}
