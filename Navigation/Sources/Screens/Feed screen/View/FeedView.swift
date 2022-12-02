//
//  FeedView.swift
//  Navigation
//
//  Created by Artem Sviridov on 29.11.2022.
//

import UIKit

protocol DisplaysFeedView: UIView {
    func configure(_ viewModel: FeedPresenter.ViewModel)
}

final class FeedView: UIView {
    // MARK: - Properties

    private lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.showsVerticalScrollIndicator = false
        table.delegate = tableManager
        table.dataSource = tableManager
        table.separatorStyle = .none
        table.register(PostTableViewCell.self, forCellReuseIdentifier: PostTableViewCell.identifier)
        return table
    }()

    private let tableManager: ManagesFeedTable

    // MARK: - Lifecycle

    init(tableManager: ManagesFeedTable = FeedTableManager(),
         delegate: FeedTableManagerDelegate) {
        self.tableManager = tableManager
        super.init(frame: .zero)

        tableManager.delegate = delegate
        addSubviews()
        makeConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - DisplaysFeedView

extension FeedView: DisplaysFeedView {
    func configure(_ viewModel: FeedPresenter.ViewModel) {
        tableManager.posts = viewModel
        tableView.reloadData()
    }
}

// MARK: - Private functions

private extension FeedView {

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
