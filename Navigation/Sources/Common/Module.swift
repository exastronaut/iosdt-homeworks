//
//  Module.swift
//  Navigation
//
//  Created by Artem Sviridov on 06.12.2022.
//

import UIKit

struct Module<Input> {

    let screen: UIViewController
    let moduleInput: Input

    init(_ screen: UIViewController, _ moduleInput: Input) {
        self.screen = screen
        self.moduleInput = moduleInput
    }

}
