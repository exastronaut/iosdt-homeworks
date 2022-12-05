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

    override func loadView() {
        super.loadView()

        title = Constants.title
        view = contentView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        output.loadData()
    }
}

extension FeedScreen: FeedTableManagerDelegate {
    func didTapPostCell(_ index: Int) {
        output.didTapCell(index)
    }
}

// MARK: - FeedScreenInput

extension FeedScreen: FeedScreenInput {
    func displayData(_ viewModel: FeedPresenter.ViewModel) {
        contentView.configure(viewModel)
    }
}

// MARK: - Private functions

private extension FeedScreen { }

// MARK: - Constants

private extension FeedScreen {
    enum Constants {
        static let title = "Feed"
    }
}
