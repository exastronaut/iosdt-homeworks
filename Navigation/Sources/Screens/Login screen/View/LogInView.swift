//
//  LogInView.swift
//  Navigation
//
//  Created by Artem Sviridov on 29.11.2022.
//

import UIKit

protocol LogInViewDelegate: AnyObject {
    func didTapLogInButton()
    func didTapReturn()
}

final class LogInView: UIView {
    // MARK: - Properties

    weak var delegate: LogInViewDelegate?

    private let logoImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = Constants.logoImage
        return image
    }()

    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.layer.backgroundColor = UIColor.systemGray6.cgColor
        stack.layer.borderColor = UIColor.lightGray.cgColor
        stack.distribution = .fillEqually
        stack.layer.borderWidth = 0.5
        stack.layer.cornerRadius = 10
        stack.layer.masksToBounds = true
        stack.axis = .vertical
        return stack
    }()

    private lazy var loginTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = .systemFont(ofSize: 16)
        textField.placeholder = Constants.loginPlaceholder
        textField.textColor = .black
        textField.autocapitalizationType = .none
        textField.ident(size: 10)
        textField.delegate = self
        return textField
    }()

    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = .systemFont(ofSize: 16)
        textField.placeholder = Constants.passwordPlaceholder
        textField.textColor = .black
        textField.autocapitalizationType = .none
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 0.5
        textField.ident(size: 10)
        textField.delegate = self
        textField.isSecureTextEntry = true
        return textField
    }()

    private lazy var logInButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.setTitle(Constants.logInButtonTitle, for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(showProfile), for: .touchUpInside)
        button.setBackgroundImage(Constants.logInButtonBackgroundImage.alpha(1), for: .normal)
        button.setBackgroundImage(Constants.logInButtonBackgroundImage.alpha(0.8), for: .disabled)
        button.setBackgroundImage(Constants.logInButtonBackgroundImage.alpha(0.8), for: .selected)
        button.setBackgroundImage(Constants.logInButtonBackgroundImage.alpha(0.8), for: .highlighted)
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

//MARK: - UITextFieldDelegate

extension LogInView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        delegate?.didTapReturn()
        return true
    }
}

// MARK: - Private functions

private extension LogInView {
    @objc
    func showProfile() {
        delegate?.didTapLogInButton()
    }

    func addSubviews() {
        [logoImage, stackView, logInButton].forEach { addSubview($0) }
        [loginTextField, passwordTextField].forEach { stackView.addArrangedSubview($0) }
    }

    func makeConstraints() {
        NSLayoutConstraint.activate([
            logoImage.topAnchor.constraint(equalTo: topAnchor),
            logoImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            logoImage.heightAnchor.constraint(equalToConstant: 100),
            logoImage.widthAnchor.constraint(equalToConstant: 100),

            stackView.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: 120),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            stackView.heightAnchor.constraint(equalToConstant: 100),

            logInButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 16),
            logInButton.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            logInButton.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            logInButton.heightAnchor.constraint(equalToConstant: 50),
            logInButton.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

// MARK: - Constants

private extension LogInView {
    enum Constants {
        static let logInButtonTitle = "Log In"
        static let logInButtonBackgroundImage: UIImage = .init(named: "blue_pixel") ?? .init()
        static let passwordPlaceholder = "Password"
        static let loginPlaceholder = "Email or phone"
        static let logoImage: UIImage = .init(named: "logo") ?? .init()
    }
}
