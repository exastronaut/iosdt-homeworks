//
//  InfoViewController.swift
//  Navigation
//
//  Created by Артем Свиридов on 07.03.2022.
//

import UIKit

final class InfoViewController: UIViewController {

    //MARK: - Private

    //MARK: UI

    private lazy var showAlert: CustomButton = {
        let button = CustomButton(title: "Show alert", titleColor: .black)
        button.delegat = self
        return button
    }()

    //MARK: - Override functions

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        setupLayout()
    }

}

//MARK: - Private functions

private extension InfoViewController {

    func setupView() {
        view.backgroundColor = .systemBlue
        title = "Info"
    }

    func setupLayout() {
        view.addSubview(showAlert)

        NSLayoutConstraint.activate([
            showAlert.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            showAlert.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            showAlert.widthAnchor.constraint(equalToConstant: 100),
            showAlert.heightAnchor.constraint(equalToConstant: 20)
        ])
    }

    func showAlertTapped() {
        let alert = UIAlertController(
            title: "Close info",
            message: "Do you close info?",
            preferredStyle: .alert
        )

        let cancelAction = UIAlertAction(
            title: "Cancel",
            style: .cancel,
            handler: nil
        )

        alert.addAction(cancelAction)

        let closeAction = UIAlertAction(
            title: "Close",
            style: .destructive,
            handler: { _ in
                self.dismiss(animated: true, completion: nil)
            }
        )

        alert.addAction(closeAction)

        present(alert, animated: true, completion: nil)
    }

}

//MARK: - CustomButtonProtocol

extension InfoViewController: CustomButtonProtocol {

    func didTapButton() {
        showAlertTapped()
    }

}
