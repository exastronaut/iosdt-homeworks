//
//  PostViewController.swift
//  Navigation
//
//  Created by Артем Свиридов on 04.03.2022.
//

import UIKit

class PostViewController: UIViewController {

    init(post: Post) {
        super.init(nibName: nil, bundle: nil)

        title = post.title
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemGreen

        let barButtonItem = UIBarButtonItem(image: UIImage(systemName: "info.circle"), style: .plain, target: self, action: #selector(showInfoTapped))

        navigationItem.rightBarButtonItem = barButtonItem
    }

    @objc func showInfoTapped() {
        let infoViewController = InfoViewController()
        let navigationController = UINavigationController(rootViewController: infoViewController)
        
        present(navigationController, animated: true, completion: nil)
    }

}
