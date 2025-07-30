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
        return viewModel.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let person = viewModel.person(at: indexPath.row)
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var config = UIListContentConfiguration.subtitleCell()
        config.text = "\(person.firstName) \(person.lastName)"
        config.image = UIImage(systemName: "person.circle") // placeholder
        cell.contentConfiguration = config

        ImageLoader.shared.load(from: person.avatar) { image in
            DispatchQueue.main.async {
                if let image = image {
                    config.image = image
                    cell.contentConfiguration = config
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
}
