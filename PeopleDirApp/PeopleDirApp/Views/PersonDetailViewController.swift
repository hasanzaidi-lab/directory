//
//  PersonDetailViewController.swift
//  PeopleDirApp
//
//  Created by Hasan Zaidi on 7/30/25.
//

import UIKit

class PersonDetailViewController: UIViewController {
    private let person: Person

    init(person: Person) {
        self.person = person
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) { fatalError() }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
    }

    private func setupUI() {
        let imageView = UIImageView()
        let nameLabel = UILabel()
        let emailLabel = UILabel()
        let jobLabel = UILabel()
        let colorLabel = UILabel()

        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 50
        imageView.clipsToBounds = true

        nameLabel.text = "\(person.firstName) \(person.lastName)"
        emailLabel.text = "Email: \(person.email)"
        jobLabel.text = "Job: \(person.jobtitle)"
        colorLabel.text = "Color: \(person.favouriteColor)"

        [imageView, nameLabel, emailLabel, jobLabel, colorLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 100),
            imageView.heightAnchor.constraint(equalToConstant: 100),

            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            emailLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            emailLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            jobLabel.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 10),
            jobLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            colorLabel.topAnchor.constraint(equalTo: jobLabel.bottomAnchor, constant: 10),
            colorLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])

        ImageLoader.shared.load(from: person.avatar) { image in
            DispatchQueue.main.async {
                imageView.image = image
            }
        }
    }
}
