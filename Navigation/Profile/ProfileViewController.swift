//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Артем Свиридов on 04.03.2022.
//
import UIKit

final class ProfileViewController: UIViewController {

    //MARK: - Properties

    private var timer: Timer?
    private let refreshTokenService: RefreshTokenServiceProtocol
    private let userDefaultsService: UserDefaultsServiceProtocol
    private let posts = PostModel.makeMockModel()
    private let profileHeader = ProfileHeaderView()
    private var isAvatarOpen = false

    private lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.delegate = self
        table.dataSource = self
        table.register(PhotosTableViewCell.self, forCellReuseIdentifier: PhotosTableViewCell.identifier)
        table.register(PostTableViewCell.self, forCellReuseIdentifier: PostTableViewCell.identifier)
        return table
    }()

    //MARK: - Initialization

    init(
        refreshTokenService: RefreshTokenServiceProtocol,
        userDefaultsService: UserDefaultsServiceProtocol
    ) {
        self.refreshTokenService = refreshTokenService
        self.userDefaultsService = userDefaultsService
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        disableTimer()
    }

    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        customizeView()
        layout()
        setupGesture()
        createTimer()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }

    //MARK: - Methods

    private func customizeView() {
        view.backgroundColor = .systemBackground
    }

    private func layout() {
        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

}

//MARK: - Private functions

private extension ProfileViewController {

    func createTimer() {
        let queue = DispatchQueue(label: "ru.exastronaut.concurrent-queue", attributes: .concurrent)

        let workItem = DispatchWorkItem {
            self.timer = Timer.scheduledTimer(timeInterval: 300,
                                              target: self,
                                              selector: #selector(self.refreshToken),
                                              userInfo: nil,
                                              repeats: true)
            self.timer?.tolerance = 0.2

            guard let timer = self.timer else {
                self.disableTimer()
                return
            }

            RunLoop.current.add(timer, forMode: .common)
            RunLoop.current.run()
        }

        queue.async(execute: workItem)
    }

    @objc
    func refreshToken() {
        do {
            let token = try userDefaultsService.getUserToken()
            getNewToken(token)
        } catch {
            DispatchQueue.main.async {
                self.showAlert(for: .notFound)
            }
        }
    }

    func getNewToken(_ token: String) {
        refreshTokenService.refreshToken(oldToken: token) { [weak self] result in
            switch result {
            case .success(let token):
                self?.userDefaultsService.saveUserToken(token)
            case .failure:
                DispatchQueue.main.async {
                    self?.showAlert(for: .noConnection)
                }
            }
        }
    }

    func disableTimer() {
        timer?.invalidate()
        timer = nil
    }

}

//MARK: - UITableViewDelegate

extension ProfileViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 { return profileHeader }
        else { return nil }
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 { return 204 }
        else { return 0 }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0, !isAvatarOpen {
            let photosViewController = PhotosViewController()
            navigationController?.pushViewController(photosViewController, animated: true)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }

}

//MARK: - UITableViewDataSource

extension ProfileViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 { return 1 }
        else { return posts[0].count }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let photosCell = tableView.dequeueReusableCell(withIdentifier: PhotosTableViewCell.identifier, for: indexPath)
            return photosCell
        } else {
            let postCell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.identifier, for: indexPath) as! PostTableViewCell
            postCell.setupCell(model: posts[0][indexPath.row])
            return postCell
        }
    }

}

//MARK: - Gestures and Animations

extension ProfileViewController {

    private var widthBackView: CGFloat {
        profileHeader.backView.bounds.width
    }

    private var heightBackView: CGFloat {
        profileHeader.backView.bounds.height
    }

    private func setupGesture(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapAction))
        profileHeader.avatarImageView.addGestureRecognizer(tapGesture)
        let closeGesture = UITapGestureRecognizer(target: self, action: #selector(closeAction))
        profileHeader.closeButton.addGestureRecognizer(closeGesture)
    }

    @objc private func tapAction() {
        isAvatarOpen = true
        UIView.animate(withDuration: 0.5) {
            self.tabBarController?.tabBar.isHidden = true
            self.profileHeader.avatarImageView.layer.cornerRadius = 0
            self.profileHeader.avatarImageView.layer.borderWidth = 0
            self.profileHeader.widthAvatarImageView.constant = self.widthBackView
            self.profileHeader.heightAvatarImageView.constant = self.widthBackView
            self.profileHeader.leadingAvatarImageView.constant = 0
            self.profileHeader.topAvatarImageView.constant = (self.heightBackView - self.widthBackView) / 3
            self.profileHeader.layoutIfNeeded()
            self.profileHeader.avatarImageView.layer.zPosition = 1
            self.profileHeader.backView.alpha = 0.70
            self.tableView.isScrollEnabled = false
        } completion: { _ in
            UIView.animate(withDuration: 0.3) {
                self.profileHeader.closeButton.alpha = 1
            }
        }
    }

    @objc private func closeAction() {
        isAvatarOpen = false
        UIView.animate(withDuration: 0.3) {
            self.profileHeader.closeButton.alpha = 0
        } completion: { _ in
            UIView.animate(withDuration: 0.5) {
                self.tabBarController?.tabBar.isHidden = false
                self.profileHeader.avatarImageView.layer.cornerRadius = 50
                self.profileHeader.avatarImageView.layer.borderWidth = 3
                self.profileHeader.widthAvatarImageView.constant = 100
                self.profileHeader.heightAvatarImageView.constant = 100
                self.profileHeader.leadingAvatarImageView.constant = 16
                self.profileHeader.topAvatarImageView.constant = 16
                self.profileHeader.backView.alpha = 0
                self.profileHeader.layoutIfNeeded()
                self.tableView.isScrollEnabled = true
            }
        }
    }

}

