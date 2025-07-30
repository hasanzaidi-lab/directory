//
//  PeopleListViewModel.swift
//  PeopleDirApp
//
//  Created by Hasan Zaidi on 7/30/25.
//

import Foundation

class PeopleListViewModel {
    private let apiService = APIService()

    var people: [Person] = []

    var onLoadingStateChange: ((Bool) -> Void)?
    var onDataUpdate: (() -> Void)?
    var onError: ((String) -> Void)?

    func fetchPeople() {
        onLoadingStateChange?(true)
        apiService.fetchPeople { [weak self] result in
            DispatchQueue.main.async {
                self?.onLoadingStateChange?(false)
                switch result {
                case .success(let people):
                    self?.people = people
                    self?.onDataUpdate?()
                case .failure(let error):
                    self?.onError?("Failed to load people: \(error.localizedDescription)")
                }
            }
        }
    }

    func person(at index: Int) -> Person {
        return people[index]
    }

    var count: Int {
        return people.count
    }
}
