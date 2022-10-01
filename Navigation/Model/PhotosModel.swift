//
//  PhotosModel.swift
//  Navigation
//
//  Created by Артем Свиридов on 01.05.2022.
//

import Foundation
import UIKit

struct PhotosModel {
    
    static func makeMockModel() -> [UIImage]? {
        var model = [UIImage]()
        for element in 1...20 {
            guard let image = UIImage(named: "photo\(element)") else { return nil }

            model.append(image)
        }
        return model
    }
}
