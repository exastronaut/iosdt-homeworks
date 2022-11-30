//
//  TabBarPage.swift
//  Navigation
//
//  Created by Artem Sviridov on 28.11.2022.
//

import UIKit

enum TabBarPage {
    case feed
    case profile

    init?(index: Int) {
        switch index {
        case 0:
            self = .feed
        case 1:
            self = .profile
        default:
            return nil
        }
    }

    func pageTitleValue() -> String {
        switch self {
        case .feed:
            return Constants.feedTitle
        case .profile:
            return Constants.profileTitle
        }
    }

    func pageOrderNumber() -> Int {
        switch self {
        case .feed:
            return 0
        case .profile:
            return 1
        }
    }

    func pageIcon() -> UIImage {
        switch self {
        case .feed:
            return Constants.feedIcon
        case .profile:
            return Constants.profileIcon
        }
    }
}

private extension TabBarPage {
    enum Constants {
        static let feedTitle = "Feed"
        static let profileTitle = "Profile"
        static let feedIcon: UIImage = .init(systemName: "house") ?? UIImage()
        static let profileIcon: UIImage = .init(systemName: "person") ?? UIImage()
    }
}
