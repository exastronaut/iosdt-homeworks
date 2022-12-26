//
//  ProfileScreen.swift
//  Navigation
//
//  Created by Артем Свиридов on 04.03.2022.
//

import UIKit

final class ProfileScreen: UIViewController {
    //MARK: - Properties
    
    var output: ProfileScreenOutput!

    private lazy var searchBarButton: UIBarButtonItem = {
        let barButton = UIBarButtonItem(systemItem: .search)
        barButton.target = self
        barButton.action = #selector(searchAction)
        return barButton
    }()

    private lazy var cancelBarButton: UIBarButtonItem = {
        let barButton = UIBarButtonItem(systemItem: .cancel)
        barButton.target = self
        barButton.action = #selector(cancelAction)
        barButton.isEnabled = false
        return barButton
    }()

    private lazy var contentView: DisplaysProfileView = ProfileView(delegate: self)
    
    //MARK: - Lifecycle

    override func loadView() {
        super.loadView()

        view = contentView
        navigationItem.rightBarButtonItem = cancelBarButton
        navigationItem.leftBarButtonItem = searchBarButton
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        output.loadData()
    }
}

extension ProfileScreen: ProfileTableManagerDelegate {
    func removePostFromDatabase(_ post: PostModel?) {
        output.removePostFromDatabase(post)
    }

    func didTapPhotosCell() {
        output.didTapPhotosCell()
    }

    func didTapAvatar() {
        tabBarController?.tabBar.isHidden = true
    }

    func didTapCloseButton() {
        tabBarController?.tabBar.isHidden = false
    }
}

//MARK: - ProfileScreenInput

extension ProfileScreen: ProfileScreenInput {
    func displayWarningAlert(with title: String, message: String) {
        showAlert(with: title, message: message)
    }

    func configureCancelBarButton(_ isEnabled: Bool) {
        cancelBarButton.isEnabled = isEnabled
    }

    func displaySerachAlert() {
        configureSearchAlert()
    }

    func displayErrorAlert(_ message: String?) {
        showAlert(message: message)
    }

    func displayData(_ viewModel: ProfilePresenter.ViewModel) {
        searchBarButton.isEnabled = viewModel.isEmpty ? false : true
        contentView.configure(viewModel)
    }
}

//MARK: - Private functions

private extension ProfileScreen {
    @objc
    func searchAction() {
        output.didTapSearchBarButton()
    }

    @objc
    func cancelAction() {
        output.didTapCancelBarButton()
    }

    func configureSearchAlert() {
        let alert = UIAlertController(
            title: "Search for posts by author",
            message: nil,
            preferredStyle: .alert
        )
        let action = UIAlertAction(title: "Search", style: .default) { _ in
            guard let text = alert.textFields?.first?.text,
                  !text.isEmpty
            else { return }

            self.output.didTapSearchAlertButton(text)
        }

        alert.addTextField { textField in
            textField.placeholder =  "Enter the author name"
        }
        alert.addAction(action)
        
        present(alert, animated: true)
    }
}
