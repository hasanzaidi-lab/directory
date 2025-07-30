//
//  ImageLoader.swift
//  PeopleDirApp
//
//  Created by Hasan Zaidi on 7/30/25.
//

import UIKit

class ImageLoader {
    static let shared = ImageLoader()
    private let cache = NSCache<NSURL, UIImage>()

    func load(from urlString: String, completion: @escaping (UIImage?) -> Void) {
        guard let url = NSURL(string: urlString) else {
            completion(nil)
            return
        }

        if let cached = cache.object(forKey: url) {
            completion(cached)
            return
        }

        URLSession.shared.dataTask(with: url as URL) { data, _, _ in
            guard let data = data, let image = UIImage(data: data) else {
                completion(nil)
                return
            }

            self.cache.setObject(image, forKey: url)
            completion(image)
        }.resume()
    }
}
