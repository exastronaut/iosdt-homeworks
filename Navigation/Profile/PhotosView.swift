//
//  PhotosView.swift
//  Navigation
//
//  Created by Артем Свиридов on 30.04.2022.
//

import UIKit

class PhotosView: UIView {

    //MARK: - Properties
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 8
        stack.distribution = .fillEqually
        return stack
    }()

    private lazy var photo1: UIImageView = getImageView(image: "photo1")
    private lazy var photo2: UIImageView = getImageView(image: "photo2")
    private lazy var photo3: UIImageView = getImageView(image: "photo3")
    private lazy var photo4: UIImageView = getImageView(image: "photo4")


    //MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - Methods
    private func getImageView(image: String) -> UIImageView {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.layer.cornerRadius = 6
        view.image = UIImage(named: image)
        return view
    }

    private func layout() {
        addSubview(stackView)
        [photo1, photo2, photo3, photo4].forEach { stackView.addArrangedSubview($0) }

        let height: CGFloat = (UIScreen.main.bounds.width - 48) / 4

        stackView.addArrangedSubview(photo1)
        stackView.addArrangedSubview(photo2)
        stackView.addArrangedSubview(photo3)
        stackView.addArrangedSubview(photo4)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.heightAnchor.constraint(equalToConstant: height)
        ])
    }
}
