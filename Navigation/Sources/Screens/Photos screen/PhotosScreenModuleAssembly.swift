//
//  PhotosScreenModuleAssembly.swift
//  Navigation
//
//  Created by Artem Sviridov on 30.11.2022.
//

import UIKit

final class PhotosScreenModuleAssembly {
    static func buildModule(moduleOutput: PhotosModuleOutput) -> UIViewController {
        let view = PhotosScreen()
        let presenter = PhotosPresenter(view: view, moduleOutput: moduleOutput)
        view.output = presenter

        return view
    }
}
