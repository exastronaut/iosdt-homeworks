//
//  InfoViewController.swift
//  Navigation
//
//  Created by Артем Свиридов on 07.03.2022.
//

import UIKit

final class InfoViewController: UIViewController {
    //MARK: - Private

    //MARK: Variables

    //MARK: UI

    //MARK: - Initialization

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - Override functions

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        makeConstraint()
    }
}

//MARK: - Private functions

private extension InfoViewController {
    func setupView() {
        view.backgroundColor = .systemBlue
        title = Constants.title
    }

    func makeConstraint() { }
}

//MARK: - Constants

private extension InfoViewController {
    enum Constants {
        static let title = "Info"
    }
}
