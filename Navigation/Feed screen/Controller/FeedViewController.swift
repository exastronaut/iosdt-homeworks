//
//  FeedViewController.swift
//  Navigation
//
//  Created by Артем Свиридов on 04.03.2022.
//

import UIKit

final class FeedViewController: UIViewController {

    // MARK: - Private

    // MARK: Variables

    private let post = Post(title: Constants.postTitle)
    private var model: FeedModel

    // MARK: UI

    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = Constants.spacing
        return stack
    }()

    private lazy var showFirstPost: CustomButton = {
        let button = CustomButton(title: Constants.firstPost)
        button.delegat = self
        return button
    }()

    private lazy var showSecondPost: CustomButton = {
        let button = CustomButton(title: Constants.secondPost)
        button.delegat = self
        return button
    }()

    private let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var customTextFieldAndButton: CustomTextFieldAndButton = {
        let customView = CustomTextFieldAndButton()
        customView.delegat = self
        return customView
    }()

    // MARK: - Initialization

    init(model: FeedModel) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Override functions

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        setuplayout()
    }

}

// MARK: - Private functions

private extension FeedViewController {

    @objc
    func configureLabel(_ notification: NSNotification) {
        guard let isTrue = notification.object as? Bool else { return }

        if isTrue {
            label.text = Constants.true
            label.backgroundColor = .systemGreen
        } else {
            label.text = Constants.false
            label.backgroundColor = .systemOrange
        }
    }

    func setupView() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(configureLabel),
            name: .myEvent,
            object: nil
        )

        view.backgroundColor = .systemPink
        title = Constants.title
    }

    func setuplayout() {
        [stackView, label, customTextFieldAndButton].forEach { view.addSubview($0) }

        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])

        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.heightAnchor.constraint(equalToConstant: Constants.labelHeight)
        ])

        NSLayoutConstraint.activate([
            customTextFieldAndButton.topAnchor.constraint(equalTo: label.bottomAnchor, constant: Constants.customViewTopOffset),
            customTextFieldAndButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])

        [showFirstPost, showSecondPost].forEach { stackView.addArrangedSubview($0) }
    }

}

// MARK: - Constants

private extension FeedViewController {

    enum Constants {
        static let title = "Feed"
        static let postTitle = "Post Title"
        static let firstPost = "Post Title"
        static let secondPost = "Post Title"
        static let `true` = "True"
        static let `false` = "False"
        static let labelHeight: CGFloat = 40
        static let customViewTopOffset: CGFloat = 8
        static let spacing: CGFloat = 10
    }
}

// MARK: - CustomButtonProtocol

extension FeedViewController: CustomButtonProtocol {

    func didTapButton() {
        let postViewController = PostViewController(post: post)
        navigationController?.pushViewController(postViewController, animated: true)
    }

}

// MARK: - CustomTextFieldAndButtonProtocol

extension FeedViewController: CustomTextFieldAndButtonProtocol {

    func didTapButton(with text: String?) {
        guard let text = text,
              !text.isEmpty
        else { return }

        model.check(word: text)
    }

}
