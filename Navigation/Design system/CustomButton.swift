//
//  CustomButton.swift
//  Navigation
//
//  Created by Артем Свиридов on 10.07.2022.
//

import UIKit

protocol CustomButtonProtocol {

    func didTapButton()

}

final class CustomButton: UIView {

    // MARK: - Delegate

    var delegat: CustomButtonProtocol?

    // MARK: - Private

    // MARK: Variables

    private var title: String
    private var titleColor: UIColor

    // MARK: UI

    private lazy var button: UIButton = {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.setTitleColor(titleColor, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()

    // MARK: - Initialization

    init(title: String, titleColor: UIColor = .white) {
        self.title = title
        self.titleColor = titleColor
        super.init(frame: .zero)

        setupView()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

// MARK: - Private functions

private extension CustomButton {

    @objc
    func buttonTapped() {
        delegat?.didTapButton()
    }

    func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
    }

    func setupLayout() {
        addSubview(button)
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: topAnchor),
            button.bottomAnchor.constraint(equalTo: bottomAnchor),
            button.trailingAnchor.constraint(equalTo: trailingAnchor),
            button.leadingAnchor.constraint(equalTo: leadingAnchor),
        ])
    }
}
