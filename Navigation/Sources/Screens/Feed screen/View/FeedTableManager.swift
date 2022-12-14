//
//  FeedTableManager.swift
//  Navigation
//
//  Created by Artem Sviridov on 02.12.2022.
//

import UIKit

protocol FeedTableManagerDelegate: AnyObject {
    func didTapPostCell(_ post: PostModel?)
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
        let cell = tableView.cellForRow(at: indexPath) as? PostTableViewCell
        let doubleTap = DoubleTapGestureForPostCell(target: self, action: #selector(doubleTapped))
        doubleTap.numberOfTapsRequired = 2
        doubleTap.cell = cell
        doubleTap.post = posts[safe: indexPath.row]
        cell?.addGestureRecognizer(doubleTap)
        tableView.deselectRow(at: indexPath, animated: true)
    }

    @objc
    func doubleTapped(_ sender: DoubleTapGestureForPostCell) {
        UIView.animate(withDuration: 0.2) {
            sender.cell?.transform = CGAffineTransform(scaleX: 0.97, y: 0.97)
        } completion: { _ in
            UIView.animate(withDuration: 0.2) {
                sender.cell?.transform = .identity
            }
        }
        delegate?.didTapPostCell(sender.post)
    }
}
