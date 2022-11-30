//
//  LogInScreenModuleAssembly.swift
//  Navigation
//
//  Created by Artem Sviridov on 28.11.2022.
//

import UIKit

final class LogInScreenModuleAssembly {
    static func buildModule(moduleOutput: LogInModuleOutput) -> UIViewController {
        let view = LogInScreen()
        let presenter = LogInPresenter(view: view, moduleOutput: moduleOutput)
        view.output = presenter
        
        return view
    }
}
