//
//  PersonDetailViewController.swift
//  PeopleDirApp
//
//  Created by Hasan Zaidi on 7/30/25.
//

import UIKit

class PersonDetailViewController: UIViewController {
    private let person: Person

    private let imageView = UIImageView()
    private let nameLabel = UILabel()
    private let emailLabel = UILabel()
    private let jobLabel = UILabel()
    private let colorLabel = UILabel()

    init(person: Person) {
        self.person = person
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Profile"
        view.backgroundColor = .systemBackground
        setupUI()
        loadImage()
    }

    private func setupUI() {
        // Image View
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 60
        imageView.clipsToBounds = true
        imageView.image = UIImage(systemName: "person.circle.fill")
        imageView.tintColor = .secondaryLabel
        imageView.accessibilityLabel = "Profile image"

        // Labels with modern fonts
        nameLabel.text = "\(person.firstName) \(person.lastName)"
        nameLabel.font = UIFont.preferredFont(forTextStyle: .title2)
        nameLabel.textAlignment = .center

        emailLabel.text = "📧 \(person.email)"
        jobLabel.text = "💼 \(person.jobtitle)"
        colorLabel.text = "🎨 Favorite Color: \(person.favouriteColor)"

        [emailLabel, jobLabel, colorLabel].forEach {
            $0.font = UIFont.preferredFont(forTextStyle: .body)
            $0.textAlignment = .center
            $0.numberOfLines = 0
        }

        // Stack View
        let stack = UIStackView(arrangedSubviews: [imageView, nameLabel, emailLabel, jobLabel, colorLabel])
        stack.axis = .vertical
        stack.spacing = 16
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(stack)

        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 120),
            imageView.heightAnchor.constraint(equalToConstant: 120),

            stack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }

    private func loadImage() {
        ImageLoader.shared.load(from: person.avatar) { [weak self] image in
            DispatchQueue.main.async {
                if let image = image {
                    self?.imageView.image = image
                }
            }
        }
    }
}
