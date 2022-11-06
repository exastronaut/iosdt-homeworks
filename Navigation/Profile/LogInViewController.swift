//
//  LoginViewController.swift
//  Navigation
//
//  Created by Артем Свиридов on 29.03.2022.
//

import UIKit

final class LogInViewController: UIViewController {

    //MARK: - Properties

    private let notificationCenter = NotificationCenter.default

    private let scrollView: UIScrollView =  {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    private let contentView: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIView())

    private let logoImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "logo")
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

    private lazy var logTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = .systemFont(ofSize: 16)
        textField.placeholder = "Email or phone"
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
        textField.placeholder = "Password"
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
        button.setTitle("Log In", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(showProfile), for: .touchUpInside)
        button.setBackgroundImage(UIImage(named: "blue_pixel")?.alpha(1), for: .normal)
        button.setBackgroundImage(UIImage(named: "blue_pixel")?.alpha(0.8), for: .disabled)
        button.setBackgroundImage(UIImage(named: "blue_pixel")?.alpha(0.8), for: .selected)
        button.setBackgroundImage(UIImage(named: "blue_pixel")?.alpha(0.8), for: .highlighted)
        return button
    }()

    //MARK: - Initialization

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        customizeView()
        layout()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        notificationCenter.addObserver(
            self,
            selector: #selector(keyboardShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        
        notificationCenter.addObserver(
            self,
            selector: #selector(keyboardHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        notificationCenter.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        notificationCenter.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)

    }
    //MARK: - Methods

    @objc private func keyboardShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey]
                               as? NSValue)?.cgRectValue {
            scrollView.contentInset.bottom = keyboardSize.height
            scrollView.verticalScrollIndicatorInsets = UIEdgeInsets(top: 0,
                                                                    left: 0,
                                                                    bottom: keyboardSize.height,
                                                                    right: 0)
        }
    }

    @objc
    private func keyboardHide() {
        scrollView.contentInset = .zero
        scrollView.verticalScrollIndicatorInsets = .zero
    }

    @objc
    func showProfile() {
        guard let login = logTextField.text,
              let password = passwordTextField.text
        else { return }

        getUserToken(login: login, password: password)
    }


    private func customizeView() {
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = true
    }

    private func layout() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        [logoImage, stackView, logInButton].forEach { contentView.addSubview($0) }
        [logTextField, passwordTextField].forEach { stackView.addArrangedSubview($0) }

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

            logoImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 120),
            logoImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            logoImage.heightAnchor.constraint(equalToConstant: 100),
            logoImage.widthAnchor.constraint(equalToConstant: 100),

            stackView.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: 120),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            stackView.heightAnchor.constraint(equalToConstant: 100),

            logInButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 16),
            logInButton.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            logInButton.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            logInButton.heightAnchor.constraint(equalToConstant: 50),
            logInButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
}

private extension LogInViewController {

    func getUserToken(login: String, password: String) {
        goToNextScreen()
    }

    func goToNextScreen() {
        let profileViewController = ProfileViewController()
        navigationController?.pushViewController(profileViewController, animated: true)
    }

}

//MARK: - UITextFieldDelegate

extension LogInViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
    }



}
