//
//  CustomTextField+Button.swift
//  Navigation
//
//  Created by Артем Свиридов on 12.07.2022.
//

import UIKit

protocol CustomTextFieldAndButtonProtocol {

    func didTapButton(with text: String?)

}

final class CustomTextFieldAndButton: UIView {

    // MARK: - Delegate

    var delegat: CustomTextFieldAndButtonProtocol?

    // MARK: - Initialization

    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Введите пароль"
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.isSecureTextEntry = true
        textField.delegate = self
        return textField
    }()

    private lazy var button: CustomButton = {
        let button = CustomButton(title: "Check")
        button.delegat = self
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupView()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

// MARK: - Private functions

private extension CustomTextFieldAndButton {

    func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
    }

    func setupLayout() {
        addSubview(textField)
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: topAnchor),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor),
            textField.leadingAnchor.constraint(equalTo: leadingAnchor),
        ])

        addSubview(button)
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: Constants.buttonTopOffset),
            button.bottomAnchor.constraint(equalTo: bottomAnchor),
            button.heightAnchor.constraint(equalToConstant: Constants.buttonHeight),
            button.widthAnchor.constraint(equalToConstant: Constants.buttonWidth),
            button.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
}

// MARK: - Constants

private extension CustomTextFieldAndButton {

    enum Constants {
        static let buttonHeight: CGFloat = 40
        static let buttonWidth: CGFloat = 120
        static let buttonTopOffset: CGFloat = 8
    }
}

// MARK: - CustomButtonProtocol

extension CustomTextFieldAndButton: CustomButtonProtocol {

    func didTapButton() {
        delegat?.didTapButton(with: textField.text)
    }

}

// MARK: - UITextFieldDelegate

extension CustomTextFieldAndButton: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        endEditing(true)
    }

}
