//
//  PhotosViewController.swift
//  Navigation
//
//  Created by Артем Свиридов on 01.05.2022.
//

import UIKit
import iOSIntPackage

final class PhotosViewController: UIViewController {

    //MARK: - Properties

    private let imageProcessor = ImageProcessor()
    private let photosModel = PhotosModel.makeMockModel()
    private var images = [UIImage]()

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(
            PhotosCollectionViewCell.self,
            forCellWithReuseIdentifier: PhotosCollectionViewCell.identifier
        )
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()

    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        setupLayout()
        configurePhotos()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.navigationBar.isHidden = false
    }

}

//MARK: - Private functions

private extension PhotosViewController {

    func configurePhotos() {
        guard let photos = photosModel else { return }

        let start = DispatchTime.now()

        imageProcessor.processImagesOnThread(
            sourceImages: photos,
            filter: .chrome,
            qos: .background
        ) { cgImages in

            cgImages.forEach { cgImage in
                self.images.append(UIImage(cgImage: cgImage!))
            }

            let end = DispatchTime.now()

            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }

            let timeInterval = Double(end.uptimeNanoseconds - start.uptimeNanoseconds) / 1_000_000_000
            print(timeInterval)
        }
    }

    func setupView() {
        view.backgroundColor = .systemBackground
        title = "Photo Gallery"
    }

    func setupLayout() {
        view.addSubview(collectionView)

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

}

//MARK: - UICollectionViewDataSource

extension PhotosViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        images.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: PhotosCollectionViewCell.identifier,
            for: indexPath
        ) as! PhotosCollectionViewCell

        cell.setupCell(model: images[indexPath.row])

        return cell
    }

}

//MARK: - UICollectionViewDelegateFlowLayout

extension PhotosViewController: UICollectionViewDelegateFlowLayout {

    private var sideInset: CGFloat { return 8 }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let width = (collectionView.bounds.width - 4 * sideInset) / 3
        return CGSize(width: width, height: width)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        sideInset
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        sideInset
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        UIEdgeInsets(top: sideInset, left: sideInset, bottom: sideInset, right: sideInset)
    }

}
