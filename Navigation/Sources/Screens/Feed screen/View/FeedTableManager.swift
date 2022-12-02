//
//  FeedTableManager.swift
//  Navigation
//
//  Created by Artem Sviridov on 02.12.2022.
//

import UIKit

protocol FeedTableManagerDelegate: AnyObject {
    func didTapPostCell()
}

protocol ManagesFeedTable: UITableViewDataSource, UITableViewDelegate {
    var posts: FeedPresenter.ViewModel { get set }
    var delegate: FeedTableManagerDelegate? { get set }
}

final class FeedTableManager: NSObject, ManagesFeedTable {
    var posts: FeedPresenter.ViewModel = .init()
    weak var delegate: FeedTableManagerDelegate?

    func tableView(_: UITableView, numberOfRowsInSection section: Int) -> Int {
        posts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let post = posts[safe: indexPath.row] else {
            return UITableViewCell()
        }

        let postCell = tableView.dequeueReusableCell(
            withIdentifier: PostTableViewCell.identifier,
            for: indexPath
        ) as? PostTableViewCell

        postCell?.setupCell(model: post)
        return postCell ?? UITableViewCell()
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

