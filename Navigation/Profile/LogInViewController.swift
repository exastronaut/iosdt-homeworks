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
    private let databaseCoordinator: DatabaseCoordinatable

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
        button.addTarget(self, action: #selector(logInAction), for: .touchUpInside)
        button.setBackgroundImage(UIImage(named: "blue_pixel")?.alpha(1), for: .normal)
        button.setBackgroundImage(UIImage(named: "blue_pixel")?.alpha(0.8), for: .disabled)
        button.setBackgroundImage(UIImage(named: "blue_pixel")?.alpha(0.8), for: .selected)
        button.setBackgroundImage(UIImage(named: "blue_pixel")?.alpha(0.8), for: .highlighted)
        return button
    }()

    //MARK: - Initialization

    init(databaseCoordinator: DatabaseCoordinatable = RealmCoordinator()) {
        self.databaseCoordinator = databaseCoordinator
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
    func logInAction() {
        guard let login = logTextField.text,
              let password = passwordTextField.text,
              login.count > 4 && password.count > 4
        else {
            showAlert(title: .minFourCharactersTitle, message: .minFourCharactersMessage)
            resetTextFields()
            return
        }

        let credentials = Credentials(username: login, password: password)
        checkCredentials(credentials)
    }

    private func checkCredentials(_ credentials: Credentials) {
        let predicate = NSPredicate(format: "username == %@", credentials.username)
        databaseCoordinator.fetch(UserCredentialsRealmModel.self, predicate: predicate) { result in
            switch result {
            case .success(let success):
                if success.isEmpty {
                    self.showCreateUserAlert(credentials)
                } else {
                    if credentials.password == success.first?.password {
                        self.goToMainScreen()
                        self.resetTextFields()
                    } else {
                        self.showAlert(title: .wrongPasswordTitle, message: .tryAgainMessage)
                        self.passwordTextField.text = .emptyline
                    }
                }
            case .failure(let failure):
                self.showErrorAlert(with: failure.localizedDescription)
            }
        }
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

    func goToMainScreen() {
        navigationController?.pushViewController(MainTabBarController(), animated: true)
    }

    func resetTextFields() {
        logTextField.text = .emptyline
        passwordTextField.text = .emptyline
    }

    func showErrorAlert(with message: String) {
        showAlert(title: .errorTitle, message: message)
        resetTextFields()
    }

    func showCreateUserAlert(_ credentials: Credentials) {
        let createAction = UIAlertAction(title: "Create", style: .default) { _ in
            self.createUser(with: credentials)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in
            self.resetTextFields()
        }

        showAlert(title: .userNotFoundTitle, message: .userNotFoundMessage, actions: [createAction, cancelAction])
    }

    func createUser(with credentials: Credentials) {
        databaseCoordinator.create(
            UserCredentialsRealmModel.self,
            keyedValues: [credentials.keyedValues]
        ) { result in
            switch result {
            case .success:
                self.passwordTextField.text = .emptyline
            case .failure(let failure):
                self.showErrorAlert(with: failure.localizedDescription)
            }
        }
    }

}

//MARK: - UITextFieldDelegate

extension LogInViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
    }

}
