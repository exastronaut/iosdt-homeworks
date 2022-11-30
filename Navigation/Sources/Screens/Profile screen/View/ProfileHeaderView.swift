//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Артем Свиридов on 17.03.2022.
//
import UIKit

protocol ProfileHeaderViewDelegate: AnyObject {
    func didTapAvatar()
    func didTapCloseButton()
}

class ProfileHeaderView: UIView {
    //MARK: - Properties
    weak var delegate: ProfileHeaderViewDelegate?

    private var statusText: String?

    let avatarImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "avatar")
        image.clipsToBounds = true
        image.layer.cornerRadius = 50
        image.layer.borderWidth = 3
        image.layer.borderColor = UIColor.white.cgColor
        image.isUserInteractionEnabled = true
        return image
    }()

    private let fullNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.text = "Zhong Xina"
        label.textColor = .black
        return label
    }()

    private let statusLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.text = "Waiting for something..."
        label.textColor = .gray
        return label
    }()

    private lazy var statusTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        textField.textColor = .black
        textField.clearButtonMode = .whileEditing
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 12
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.black.cgColor
        textField.ident(size: 10)
        textField.delegate = self
        textField.addTarget(self, action: #selector(statusTextChanged), for: .editingChanged)
        return textField
    }()

    private lazy var setStatusButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .blue
        button.setTitle("Show status", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 4
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowRadius = 4
        button.layer.shadowOpacity = 0.7
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        return button
    }()

    let backView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .black
        view.alpha = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let closeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.alpha = 0
        return button
    }()

    /// avatarImageView constraints
    var heightAvatarImageView = NSLayoutConstraint()
    var widthAvatarImageView = NSLayoutConstraint()
    var topAvatarImageView = NSLayoutConstraint()
    var leadingAvatarImageView = NSLayoutConstraint()
    var trailingAvatarImageView = NSLayoutConstraint()

    //MARK: - Lifecycle

    init() {
        super.init(frame: .zero)
        layout()
        setupGesture()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods

    @objc
    func buttonPressed() {
        guard let text = statusTextField.text, !text.isEmpty else {
            statusLabel.text = "Waiting for something..."
            return
        }
        statusLabel.text = statusText
        statusTextField.text = ""
    }

    @objc
    func statusTextChanged(_ textField: UITextField) {
        statusText = textField.text
    }

    private func layout() {
        [avatarImageView, setStatusButton, fullNameLabel,
         statusLabel, statusTextField, backView, closeButton].forEach { addSubview($0) }

        heightAvatarImageView = avatarImageView.heightAnchor.constraint(equalToConstant: 100)
        widthAvatarImageView = avatarImageView.widthAnchor.constraint(equalToConstant: 100)
        topAvatarImageView = avatarImageView.topAnchor.constraint(equalTo: topAnchor, constant: 16)
        leadingAvatarImageView = avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16)

        let heightScreen: CGFloat = UIScreen.main.bounds.height

        NSLayoutConstraint.activate([
            backView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backView.heightAnchor.constraint(equalToConstant: heightScreen),
            backView.topAnchor.constraint(equalTo: topAnchor),
            backView.leadingAnchor.constraint(equalTo: leadingAnchor),

            closeButton.topAnchor.constraint(equalTo: backView.topAnchor, constant: 8),
            closeButton.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -8),

            heightAvatarImageView, widthAvatarImageView, topAvatarImageView, leadingAvatarImageView,

            setStatusButton.topAnchor.constraint(equalTo: statusTextField.bottomAnchor, constant: 16),
            setStatusButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            setStatusButton.heightAnchor.constraint(equalToConstant: 50),
            setStatusButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),

            fullNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            fullNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 138),
            fullNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),

            statusTextField.heightAnchor.constraint(equalToConstant: 40),
            statusTextField.leadingAnchor.constraint(equalTo: statusLabel.leadingAnchor),
            statusTextField.topAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant: 8),
            statusTextField.trailingAnchor.constraint(equalTo: statusLabel.trailingAnchor),

            statusLabel.leadingAnchor.constraint(equalTo: fullNameLabel.leadingAnchor),
            statusLabel.topAnchor.constraint(equalTo: fullNameLabel.bottomAnchor, constant: 16),
            statusLabel.trailingAnchor.constraint(equalTo: fullNameLabel.trailingAnchor)
        ])
    }
}

//MARK: - UITextFieldDelegate

extension ProfileHeaderView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        endEditing(true)
    }
}

//MARK: - Gestures and Animations

extension ProfileHeaderView {
    var widthBackView: CGFloat {
        backView.bounds.width
    }

    var heightBackView: CGFloat {
        backView.bounds.height
    }

    func setupGesture(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapAction))
        avatarImageView.addGestureRecognizer(tapGesture)
        let closeGesture = UITapGestureRecognizer(target: self, action: #selector(closeAction))
        closeButton.addGestureRecognizer(closeGesture)
    }

    @objc
    func tapAction() {
        delegate?.didTapAvatar()
        UIView.animate(withDuration: 0.5) {
            self.avatarImageView.layer.cornerRadius = 0
            self.avatarImageView.layer.borderWidth = 0
            self.widthAvatarImageView.constant = self.widthBackView
            self.heightAvatarImageView.constant = self.widthBackView
            self.leadingAvatarImageView.constant = 0
            self.topAvatarImageView.constant = (self.heightBackView - self.widthBackView) / 3
            self.layoutIfNeeded()
            self.avatarImageView.layer.zPosition = 1
            self.backView.alpha = 0.70
//
        } completion: { _ in
            UIView.animate(withDuration: 0.3) {
                self.closeButton.alpha = 1
            }
        }
    }

    @objc
    func closeAction() {
        delegate?.didTapCloseButton()
        UIView.animate(withDuration: 0.3) {
            self.closeButton.alpha = 0
        } completion: { _ in
            UIView.animate(withDuration: 0.5) {
                self.avatarImageView.layer.cornerRadius = 50
                self.avatarImageView.layer.borderWidth = 3
                self.widthAvatarImageView.constant = 100
                self.heightAvatarImageView.constant = 100
                self.leadingAvatarImageView.constant = 16
                self.topAvatarImageView.constant = 16
                self.backView.alpha = 0
                self.layoutIfNeeded()
//                self.tableView.isScrollEnabled = true
            }
        }
    }
}
