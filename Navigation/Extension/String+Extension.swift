//
//  String+Extension.swift
//  Navigation
//
//  Created by Артем Свиридов on 25.09.2022.
//

import Foundation

extension String {

    static func generateToken() -> String {
        UUID().uuidString
    }

}
