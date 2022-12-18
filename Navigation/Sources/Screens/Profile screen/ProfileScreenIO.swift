//
//  ProfileScreenIO.swift
//  Navigation
//
//  Created by Artem Sviridov on 29.11.2022.
//

protocol ProfileScreenOutput: AnyObject {
    func loadData()
    func didTapPhotosCell()
    func removePostFromDatabase(_ post: PostModel?)
    func didTapSearchBarButton()
    func didTapSearchAlertButton(_ text: String)
    func didTapCancelBarButton()
}

protocol ProfileScreenInput: AnyObject {
    func displayData(_ viewModel: ProfilePresenter.ViewModel)
    func displayErrorAlert(_ message: String?)
    func displaySerachAlert()
    func displayWarningAlert(with title: String, message: String)
    func configureCancelBarButton(_ isEnabled: Bool)
}
