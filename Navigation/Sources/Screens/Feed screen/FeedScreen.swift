//
//  FeedViewController.swift
//  Navigation
//
//  Created by Артем Свиридов on 04.03.2022.
//

import UIKit

final class FeedScreen: UIViewController {
    var output: FeedScreenOutput!

    private lazy var contentView: FeedView = .init(delegate: self)
    private lazy var logOutButton: UIBarButtonItem = {
        let barButton = UIBarButtonItem(
            image: UIImage(systemName: "door.right.hand.open"),
            style: .done,
            target: self,
            action: #selector(logOutAction)
        )
        return barButton
    }()

    override func loadView() {
        super.loadView()

        title = Constants.title
        view = contentView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.leftBarButtonItem = logOutButton
    }
}

extension FeedScreen: FeedTableManagerDelegate {
    func didTapPostCell() { print("tap") }
}

// MARK: - FeedScreenInput

extension FeedScreen: FeedScreenInput { }

// MARK: - Private functions

private extension FeedScreen {
    @objc
    func logOutAction() {
        output.didTapButton()
    }
}

// MARK: - Constants

private extension FeedScreen {
    enum Constants {
        static let title = "Feed"
    }
}
