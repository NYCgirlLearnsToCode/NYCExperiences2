//
//  URLSessionImageLoader.swift
//  NYCExperiences2
//
//  Created by Lisa J on 11/4/26.
//

import UIKit

class URLSessionImageLoader: ImageLoader {
    func getImageFrom(url: URL, completion: @escaping (UIImage?) -> Void) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                print(error)
                completion(nil)
                return
            }

            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                print("response invalid \(String(describing: response))")
                completion(nil)
                return
            }

            guard let image = UIImage(data: data) else {
                print("invalid, not image data")
                completion(nil)
                return
            }
            completion(image)
        }.resume()
    }
}
