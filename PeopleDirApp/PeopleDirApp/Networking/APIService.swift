//
//  APIService.swift
//  PeopleDirApp
//
//  Created by Hasan Zaidi on 7/30/25.
//

import Foundation

enum APIError: Error {
    case invalidURL
    case network(Error)
    case decoding(Error)
    case unknown
}

class APIService {
    func fetchPeople(completion: @escaping (Result<[Person], APIError>) -> Void) {
        guard let url = URL(string: "https://61e947967bc0550017bc61bf.mockapi.io/api/v1/people") else {
            completion(.failure(.invalidURL))
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            if let err = error {
                completion(.failure(.network(err)))
                return
            }

            guard let data = data else {
                completion(.failure(.unknown))
                return
            }

            do {
                let people = try JSONDecoder().decode([Person].self, from: data)
                completion(.success(people))
            } catch {
                print("decoding failed")
                completion(.failure(.decoding(error)))
            }
        }.resume()
    }
}
