//
//  ProfileTableManager.swift
//  Navigation
//
//  Created by Artem Sviridov on 29.11.2022.
//

import UIKit

protocol ProfileTableManagerDelegate: AnyObject {
    func didTapPhotosCell()
    func didTapAvatar()
    func didTapCloseButton()
}

protocol ManagesProfileTable: UITableViewDataSource, UITableViewDelegate {
    var posts: ProfilePresenter.ViewModel { get set }
    var delegate: ProfileTableManagerDelegate? { get set }
    var headerView: ProfileHeaderView { get set }
}

final class ProfileTableManager: NSObject, ManagesProfileTable {
    var headerView: ProfileHeaderView = .init()
    var posts: ProfilePresenter.ViewModel = .init()
    weak var delegate: ProfileTableManagerDelegate?

    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }

    func tableView(_: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return posts[safe: 0]?.count ?? 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let post = posts[safe: 0]?[safe: indexPath.row] else {
            return UITableViewCell()
        }

        if indexPath.section == 0 {
            let photosCell = tableView.dequeueReusableCell(
                withIdentifier: PhotosTableViewCell.identifier,
                for: indexPath
            )

            return photosCell
        } else {
            let postCell = tableView.dequeueReusableCell(
                withIdentifier: PostTableViewCell.identifier,
                for: indexPath
            ) as? PostTableViewCell

            postCell?.setupCell(model: post)
            return postCell ?? UITableViewCell()
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         UITableView.automaticDimension
     }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        section == 0 ? headerView : nil
     }

     func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
         section == 0 ? 204 : 0
     }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            delegate?.didTapPhotosCell()
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
