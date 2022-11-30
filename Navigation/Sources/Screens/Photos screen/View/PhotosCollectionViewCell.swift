//
//  PhotosCollectionViewCell.swift
//  Navigation
//
//  Created by Артем Свиридов on 01.05.2022.
//

import UIKit

class PhotosCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Properties

    private let image: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleToFill
        return image
    }()

    //MARK: - Lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)

        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - Methods

    func setupCell(model: UIImage) {
        image.image = model
    }

    private func layout() {
        contentView.addSubview(image)

        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: contentView.topAnchor),
            image.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            image.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            image.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
}
