//
//  UITextField+Extension.swift
//  Navigation
//
//  Created by Артем Свиридов on 30.03.2022.
//

import UIKit

extension UITextField {
    func ident(size: CGFloat) {
        leftView = UIView(frame: CGRect(origin: .zero, size: CGSize(width: size, height: self.frame.height)))
        leftViewMode = .always
    }
}
