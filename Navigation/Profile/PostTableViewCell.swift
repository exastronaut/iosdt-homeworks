//
//  PostTableViewCell.swift
//  Navigation
//
//  Created by Артем Свиридов on 16.04.2022.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    
    //MARK: - Properties
    private let author: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .black
        label.numberOfLines = 2
        return label
    }()

    private let image: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.backgroundColor = .black
        return image
    }()

    private let descriptionText: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14)
        label.textColor = .systemGray
        label.numberOfLines = 0
        return label
    }()

    private let likes: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16)
        label.textColor = .black
        return label
    }()
    
    private let views: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16)
        label.textColor = .black
        return label
    }()

    //MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        customizeCell()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - Methods
    private func customizeCell() {
        contentView.backgroundColor = .white
    }

    func setupCell(model: PostModel) {
        author.text = model.author
        image.image = UIImage(named: model.image)
        descriptionText.text = model.description
        likes.text = "Likes: \(model.likes)"
        views.text = "Views: \(model.views)"
    }

    private func layout() {
        [author, image, descriptionText, likes, views].forEach { contentView.addSubview($0) }

        let indent: CGFloat = 16

        NSLayoutConstraint.activate([
            author.topAnchor.constraint(equalTo: contentView.topAnchor, constant: indent),
            author.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: indent),
            author.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -indent),

            image.topAnchor.constraint(equalTo: author.bottomAnchor, constant: indent),
            image.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            image.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            image.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

            descriptionText.topAnchor.constraint(equalTo: image.bottomAnchor, constant: indent),
            descriptionText.leadingAnchor.constraint(equalTo: image.leadingAnchor, constant: indent),
            descriptionText.trailingAnchor.constraint(equalTo: image.trailingAnchor, constant: -indent),

            likes.topAnchor.constraint(equalTo: descriptionText.bottomAnchor, constant: indent),
            likes.leadingAnchor.constraint(equalTo: descriptionText.leadingAnchor),
            likes.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -indent),

            views.topAnchor.constraint(equalTo: likes.topAnchor),
            views.trailingAnchor.constraint(equalTo: descriptionText.trailingAnchor),
            views.leadingAnchor.constraint(greaterThanOrEqualTo: likes.trailingAnchor, constant: indent),
            views.bottomAnchor.constraint(equalTo: likes.bottomAnchor)
        ])
    }
}
