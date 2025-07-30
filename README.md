

# 👥 PeopleDirApp

A lightweight, scalable iOS application built using UIKit and programmatic UI that fetches and displays a list of people from a remote RESTful API. Architected with MVVM to ensure separation of concerns, testability, and clean dependency management.

## 📱 Tech Stack

- **UIKit** – Programmatic view layer, no Storyboard/XIBs.
- **MVVM Architecture** – ViewModel layer manages presentation logic, API decoupling.
- **URLSession + Result<T, Error>** – Typed async networking abstraction.
- **Dependency Injection** – API service injected into the ViewModel.
- **Auto Layout** – NSLayoutConstraint-based layout, supports all screen sizes.

---

## 🧱 Project Structure

```plaintext
PeopleDirApp/
├── Models/
│   └── Person.swift                # Codable struct representing a person
├── Views/
│   └── PersonTableViewCell.swift  # Custom UITableViewCell with labels
├── ViewModels/
│   └── PeopleViewModel.swift      # Observable ViewModel exposes data + error
├── Services/
│   └── APIService.swift           # URLSession logic with Result<T, Error>
├── Controllers/
│   └── PeopleViewController.swift # UITableViewController that binds to VM
├── Resources/
│   └── Assets.xcassets            # App icons, launch assets
└── AppDelegate.swift / SceneDelegate.swift
```

---

## ⚙️ Features

* ✅ **Remote Fetching**: Fetches data from an external REST API.
* ✅ **MVVM-Ready**: ViewModels expose observable state and decouple API layer.
* ✅ **Typed Error Handling**: Custom `APIError` enum allows for detailed error resolution.
* ✅ **No Storyboard Dependency**: Built entirely with UIKit programmatic views.
* ✅ **Black Screen Fix**: Scene lifecycle manually initializes the root view in code.

---

## 🚀 How It Works

1. `SceneDelegate` bootstraps the app by instantiating `PeopleViewController` and injecting the `ViewModel`.
2. `PeopleViewModel` makes a network request using `APIService`.
3. Results are published to the ViewController via closures or delegate binding.
4. `PeopleViewController` displays fetched `Person` objects in a custom cell.
5. Errors (e.g., `.invalidURL`, `.decodingFailed`) are printed or handled gracefully.

---

## 🔐 Error Handling

All networking errors conform to `LocalizedError` via a custom `APIError`:

```swift
enum APIError: Error {
    case invalidURL
    case requestFailed(Error)
    case decodingFailed(Error)
    case unknown
}
```

Each case returns a localized error description for debugging and potential user-facing alerts.

---

## 🧪 Testing Strategy

* ViewModels are unit-testable in isolation by mocking `APIService`.
* No reliance on UIKit in the model or network layers.
* Result type ensures compile-time safety and explicit error propagation.

---

## 💡 Design Philosophy

* ✅ Single Responsibility: Views display data, ViewModels manage it.
* ✅ Testability First: All business logic extracted from controllers.
* ✅ UIKit Fidelity: Preferred for fine-grained control and legacy integration.
* ✅ Lightweight: No third-party dependencies.

---

## 🛠️ Future Improvements

* Add pull-to-refresh using `UIRefreshControl`
* Migrate to Combine/Swift Concurrency
* Add persistence via Core Data
* Unit and snapshot tests with XCTest + XCUITest
* CI integration with GitHub Actions

---

## 📸 Screenshots

Coming soon…

---

## 👨🏻‍💻 Author

Hasan Zaidi
Lead iOS Engineer with 10+ years of enterprise app experience
Fintech • Connected Vehicles • Airlines • E-commerce • Healthcare

---

## 📄 License

MIT

```

---

Would you like me to generate the actual `README.md` file for GitHub or include badges (e.g., Swift version, build status, license)?
```
