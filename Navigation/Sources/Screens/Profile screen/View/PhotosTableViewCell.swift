//
//  PhotosTableViewCell.swift
//  Navigation
//
//  Created by Артем Свиридов on 29.04.2022.
//

import UIKit

class PhotosTableViewCell: UITableViewCell {

    //MARK: - Properties
    private let title: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textColor = .black
        label.text = "Photos"
        return label
    }()

    private let arrow: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(systemName: "arrow.right")
        return image
    }()

    private let photosView: PhotosView = {
        let view = PhotosView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    //MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - Methods
    private func layout() {
        [title, arrow, photosView].forEach { contentView.addSubview($0) }

        let indent: CGFloat = 12

        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: contentView.topAnchor, constant: indent),
            title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: indent),

            arrow.centerYAnchor.constraint(equalTo: title.centerYAnchor),
            arrow.leadingAnchor.constraint(greaterThanOrEqualTo: title.trailingAnchor),
            arrow.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -indent),

            photosView.topAnchor.constraint(equalTo: title.bottomAnchor, constant: indent),
            photosView.leadingAnchor.constraint(equalTo: title.leadingAnchor),
            photosView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -indent),
            photosView.trailingAnchor.constraint(equalTo: arrow.trailingAnchor)
        ])
    }
}
