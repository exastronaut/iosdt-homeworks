//
//  FeedView.swift
//  Navigation
//
//  Created by Artem Sviridov on 29.11.2022.
//

import UIKit

protocol FeedViewDelegate: AnyObject {
    func didTapButton()
}

final class FeedView: UIView {
    // MARK: - Properties

    weak var delegate: FeedViewDelegate?

    private lazy var button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(Constants.title, for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.addTarget(nil, action: #selector(buttonAction), for: .touchUpInside)
        return button
    }()

    // MARK: - Lifecycle

    init() {
        super.init(frame: .zero)

        addSubviews()
        makeConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Private functions + Constants

private extension FeedView {
    @objc
    func buttonAction() {
        delegate?.didTapButton()
    }

    func addSubviews() {
        addSubview(button)
    }

    func makeConstraints() {
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: centerXAnchor),
            button.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }

    enum Constants {
        static let title = "Tap"
    }
}
