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
}

protocol ProfileScreenInput: AnyObject {
    func displayData(_ viewModel: ProfilePresenter.ViewModel)
    func displayErrorAlert(_ message: String?)
}
