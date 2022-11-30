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

    private lazy var contentView: DisplaysProfileView = ProfileView(delegate: self)
    
    //MARK: - Lifecycle

    override func loadView() {
        super.loadView()

        view = contentView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        output.loadData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isHidden = true
    }
}

extension ProfileScreen: ProfileTableManagerDelegate {
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
    func displayData(_ viewModel: ProfilePresenter.ViewModel) {
        contentView.configure(viewModel)
    }
}

//MARK: - Private functions

private extension ProfileScreen { }
