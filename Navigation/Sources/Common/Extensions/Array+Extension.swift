//
//  Array+Extension.swift
//  Navigation
//
//  Created by Artem Sviridov on 29.11.2022.
//

extension Array {
    subscript (safe index: Int) -> Element? {
        return indices ~= index ? self[index] : nil
    }
}
