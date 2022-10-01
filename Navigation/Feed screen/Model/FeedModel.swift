//
//  FeedModel.swift
//  Navigation
//
//  Created by Артем Свиридов on 14.07.2022.
//

import UIKit

struct FeedModel {

    var password: String = "password"

    var isTrue: Bool? {
        didSet {
            guard let isTrue = isTrue else { return }

            if isTrue {
                NotificationCenter.default.post(name: .myEvent, object: true)
            } else {
                NotificationCenter.default.post(name: .myEvent, object: false)
            }
        }
    }

    mutating func check(word: String) {
        if word == password {
            isTrue = true
        } else {
            isTrue = false
        }
    }

}

extension NSNotification.Name {

    static let myEvent = NSNotification.Name(rawValue: "myEvent")

}
