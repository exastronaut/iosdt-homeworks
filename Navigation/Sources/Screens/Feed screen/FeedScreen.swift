//
//  FeedViewController.swift
//  Navigation
//
//  Created by Артем Свиридов on 04.03.2022.
//

import UIKit

final class FeedScreen: UIViewController {
    var output: FeedScreenOutput!

    private lazy var contentView: FeedView = {
        let view = FeedView()
        view.delegate = self
        return view
    }()

    override func loadView() {
        super.loadView()

        title = Constants.title
        view = contentView
    }
}

// MARK: - FeedViewDelegate

extension FeedScreen: FeedViewDelegate {
    func didTapButton() {
        output.didTapButton()
    }
}

// MARK: - FeedScreenInput

extension FeedScreen: FeedScreenInput { }

// MARK: - Private functions

private extension FeedScreen { }

// MARK: - Constants

private extension FeedScreen {
    enum Constants {
        static let title = "Feed"
    }
}
