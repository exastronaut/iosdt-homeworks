//
//  UIImage+Extension.swift
//  Navigation
//
//  Created by Артем Свиридов on 01.04.2022.
//

import UIKit

extension UIImage {
    func alpha(_ value: CGFloat) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        draw(at: CGPoint.zero, blendMode: .normal, alpha: value)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
}
