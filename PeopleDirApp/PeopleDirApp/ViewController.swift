//
//  ViewController.swift
//  PeopleDirApp
//
//  Created by Hasan Zaidi on 7/30/25.
//

import UIKit

class PeopleListViewController: UIViewController {
    private let tableView = UITableView()
    private let viewModel = PeopleListViewModel()
    private let refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(PersonTableViewCell.self, forCellReuseIdentifier: PersonTableViewCell.reuseIdentifier)
        title = "People"
        view.backgroundColor = .systemBackground
        setupTableView()
        bindViewModel()
        viewModel.fetchPeople()
    }

    private func setupTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.frame = view.bounds
        tableView.dataSource = self
        tableView.delegate = self
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        tableView.refreshControl = refreshControl
        view.addSubview(tableView)
    }

    private func bindViewModel() {
        viewModel.onLoadingStateChange = { [weak self] isLoading in
            if !isLoading {
                self?.refreshControl.endRefreshing()
            }
        }

        viewModel.onDataUpdate = { [weak self] in
            self?.tableView.reloadData()
        }

        viewModel.onError = { [weak self] message in
            let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Retry", style: .default) { _ in
                self?.viewModel.fetchPeople()
            })
            self?.present(alert, animated: true)
        }
    }

    @objc private func refreshData() {
        viewModel.fetchPeople()
    }
}

extension PeopleListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let person = viewModel.person(at: indexPath.row)
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        var config = UIListContentConfiguration.subtitleCell()
        config.text = "\(person.firstName) \(person.lastName)"
        config.secondaryText = person.email
        config.image = UIImage(systemName: "person.circle") // default placeholder
        config.imageProperties.cornerRadius = 20
        config.imageProperties.maximumSize = CGSize(width: 40, height: 40)
        config.textProperties.font = .boldSystemFont(ofSize: 17)
        config.secondaryTextProperties.color = .darkGray

        cell.contentConfiguration = config
        cell.selectionStyle = .none
        cell.backgroundColor = .secondarySystemBackground
        cell.layer.cornerRadius = 12
        cell.clipsToBounds = true

        ImageLoader.shared.load(from: person.avatar) { image in
            DispatchQueue.main.async {
                if let image = image, tableView.indexPath(for: cell) == indexPath {
                    var updatedConfig = config
                    updatedConfig.image = image
                    cell.contentConfiguration = updatedConfig
                }
            }
        }

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let person = viewModel.person(at: indexPath.row)
        let detailVC = PersonDetailViewController(person: person)
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.contentView.layer.masksToBounds = true
        cell.contentView.layer.cornerRadius = 12
        cell.contentView.layer.borderWidth = 0.5
        cell.contentView.layer.borderColor = UIColor.separator.cgColor
        cell.contentView.backgroundColor = .systemBackground

        // Add vertical padding
        let marginTransform = CGAffineTransform(translationX: 0, y: 5)
        cell.transform = marginTransform
    }

}
