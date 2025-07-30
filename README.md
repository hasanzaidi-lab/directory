
# 👥 PeopleDirApp

A modern, lightweight iOS app built entirely with **UIKit** and **programmatic UI**, designed to fetch and display a directory of people from a remote API. Architected with **MVVM** for separation of concerns, scalability, and testability.

---

## 📱 Tech Stack

* **UIKit** – Fully programmatic UI, no Storyboards/XIBs
* **MVVM** – Separation of concerns with ViewModels managing presentation logic
* **URLSession + Result\<T, Error>** – Type-safe networking layer
* **Dependency Injection** – ViewModels receive injected API services
* **Auto Layout** – Responsive UI built with `NSLayoutConstraint`
* **Dark Mode Support** – Adapts to system appearance (light/dark)

---

## 🧱 Project Structure

```
PeopleDirApp/
├── Models/
│   └── Person.swift                 # Codable struct for person data
├── Views/
│   └── PersonTableViewCell.swift   # Custom UITableViewCell
├── ViewModels/
│   └── PeopleViewModel.swift       # Exposes state, handles business logic
├── Services/
│   └── APIService.swift            # Abstracted network layer using Result
├── Controllers/
│   ├── PeopleViewController.swift  # Displays people list using UITableView
│   └── PersonDetailViewController.swift # Modern detail view with avatar & info
├── Utilities/
│   └── ImageLoader.swift           # Simple image caching with NSCache
├── Resources/
│   └── Assets.xcassets             # App icons, system images, launch assets
└── AppDelegate.swift / SceneDelegate.swift
```

---

## ⚙️ Features

✅ Remote API Fetch with Loading State
✅ MVVM Architecture with Clean ViewModel Bindings
✅ Modern UI Design for List and Detail Views
✅ Typed Error Handling via `APIError` Enum
✅ Fully Programmatic UIKit Layout (No Storyboards)
✅ Safe Image Loading with NSCache
✅ Scene-based App Launch

---

## 🚀 How It Works

1. **SceneDelegate** initializes `PeopleViewController`, injecting the ViewModel.
2. `PeopleViewModel` fetches data from a REST API via `APIService`.
3. The controller observes state via closures or delegate and reloads UI accordingly.
4. On selection, it navigates to a **detail view** displaying avatar, name, and email in a clean stack layout.
5. Networking errors are surfaced and gracefully handled.

---

## 🔐 Error Handling

All network failures are captured in a typed enum:

```swift
enum APIError: Error, LocalizedError {
    case invalidURL
    case requestFailed(Error)
    case decodingFailed(Error)
    case unknown

    var errorDescription: String? {
        switch self {
        case .invalidURL: return "Invalid URL."
        case .requestFailed(let err): return "Network error: \(err.localizedDescription)"
        case .decodingFailed(let err): return "Failed to parse response: \(err.localizedDescription)"
        case .unknown: return "An unknown error occurred."
        }
    }
}
```

---

## 🧪 Testing Strategy

* ViewModels are unit-testable with **mocked services**
* No UIKit dependencies in business logic
* `Result` enables compile-time safety for async outcomes
* Each error case is verifiable independently

---

## 💡 Design Principles

✅ **Single Responsibility**: Views display UI only, ViewModels manage logic
✅ **Testability First**: Clean separation of concerns
✅ **UIKit Precision**: Preferred for granular layout and enterprise compatibility
✅ **Lightweight**: Zero external dependencies
✅ **Dark Mode**: Uses system color schemes and SF Symbols

---

## 🛠️ Future Improvements

* 🔄 Pull-to-refresh with `UIRefreshControl`
* 🔁 Migrate to Combine or Swift Concurrency
* 💾 Local persistence using Core Data
* 🧪 Unit + Snapshot Tests (`XCTest`, `XCUITest`)
* ⚙️ GitHub Actions for CI/CD pipeline

---

## 📸 Screenshots

> Coming soon – showcasing both list and detail views in light & dark mode.

---

## 👨🏻‍💻 Author

**Hasan Zaidi**
Lead iOS Engineer | 10+ years of experience
Domains: Fintech • Connected Vehicles • Airlines • E-commerce • Healthcare

