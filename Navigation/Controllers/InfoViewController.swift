//
//  InfoViewController.swift
//  Navigation
//
//  Created by Артем Свиридов on 07.03.2022.
//

import UIKit

final class InfoViewController: UIViewController {

    //MARK: - Private

    //MARK: Variables 

    private var service: NetworkServiceProtocol
    private var residents = [String]()
    private var links = [String]()
    private let group = DispatchGroup()

    //MARK: UI

    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.delegate = self
        table.dataSource = self
        return table
    }()

    private lazy var titleLabel = makeLabel()
    private lazy var orbitalPeriodLabel = makeLabel()

    //MARK: - Initialization

    init(service: NetworkServiceProtocol) {
        self.service = service
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - Override functions

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        setupLayout()
        getData()
        group.enter()
        getPlanetDescription()
        group.wait()
        getResident(for: links)
        tableView.reloadData()
    }

}

//MARK: - UITableViewDelegate

extension InfoViewController: UITableViewDelegate {}

//MARK: - UITableViewDataSource

extension InfoViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        residents.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        var content: UIListContentConfiguration = cell.defaultContentConfiguration()

        content.text = residents[indexPath.row]
        cell.contentConfiguration = content

        return cell
    }

}

//MARK: - Private functions

private extension InfoViewController {

    func setupView() {
        view.backgroundColor = .systemBlue
        title = "Info"
    }

    func setupLayout() {
        [titleLabel, orbitalPeriodLabel, tableView].forEach { view.addSubview($0) }

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])

        NSLayoutConstraint.activate([
            orbitalPeriodLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            orbitalPeriodLabel.centerXAnchor.constraint(equalTo: titleLabel.centerXAnchor)
        ])

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: orbitalPeriodLabel.bottomAnchor, constant: 16),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

    }

    func getData() {
        service.getData { [weak self] result in
            switch result {
            case .success(let data):
                guard let data = data else { return }

                DispatchQueue.main.async {
                    self?.titleLabel.text = data.title
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    func getPlanetDescription() {
        service.getPlanetDescription { [weak self] result in
            switch result {
            case .success(let model):
                guard let model = model else { return }

                self?.links.append(contentsOf: model.residents)
                DispatchQueue.main.async {
                    self?.orbitalPeriodLabel.text = "Planet Tatuin period: \(model.orbitalPeriod)"
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
            self?.group.leave()
        }
    }

    func getResident(for links: [String]) {
        links.forEach { link in
            self.service.getResident(for: link) { [weak self] result in
                switch result {
                case .success(let success):
                    guard let person = success else { return }

                    self?.residents.append(person.name)

                    DispatchQueue.main.async {
                        self?.tableView.reloadData()
                    }
                case .failure(let failure):
                    print(failure.localizedDescription)
                }
            }
        }
    }

    func makeLabel() -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }

}
