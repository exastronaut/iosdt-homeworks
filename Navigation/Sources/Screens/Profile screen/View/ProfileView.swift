//
//  ProfileView.swift
//  Navigation
//
//  Created by Artem Sviridov on 29.11.2022.
//

import UIKit

protocol DisplaysProfileView: UIView {
    func configure(_ viewModel: ProfilePresenter.ViewModel)
}

final class ProfileView: UIView {
    // MARK: - Properties

    private lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.showsVerticalScrollIndicator = false
        table.delegate = tableManager
        table.dataSource = tableManager
        table.separatorStyle = .none
        table.register(PhotosTableViewCell.self, forCellReuseIdentifier: PhotosTableViewCell.identifier)
        table.register(ProfilePostTableViewCell.self, forCellReuseIdentifier: ProfilePostTableViewCell.identifier)
        return table
    }()

    private let tableManager: ManagesProfileTable

    // MARK: - Lifecycle

    init(tableManager: ManagesProfileTable = ProfileTableManager(),
         delegate: ProfileTableManagerDelegate) {
        self.tableManager = tableManager
        super.init(frame: .zero)
        
        tableManager.delegate = delegate
        tableManager.headerView.delegate = self
        addSubviews()
        makeConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ProfileView: ProfileHeaderViewDelegate {
    func didTapAvatar() {
        tableView.isScrollEnabled = false
        tableManager.delegate?.didTapAvatar()
    }

    func didTapCloseButton() {
        tableView.isScrollEnabled = true
        tableManager.delegate?.didTapCloseButton()
    }
}

// MARK: - DisplaysProfileView

extension ProfileView: DisplaysProfileView {
    func configure(_ viewModel: ProfilePresenter.ViewModel) {
        tableManager.posts = viewModel
        tableView.reloadData()
    }
}

// MARK: - Private functions

private extension ProfileView {
    func addSubviews() {
        addSubview(tableView)
    }

    func makeConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

// MARK: - Constants

private extension ProfileView {
    enum Constants { }
}


