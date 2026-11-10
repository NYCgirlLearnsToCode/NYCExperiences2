//
//  URLSessionImageLoader.swift
//  NYCExperiences2
//
//  Created by Lisa J on 11/4/26.
//

import UIKit

class URLSessionImageLoader: ImageLoader {

    private let imageCache = NSCache<NSString, UIImage>()

    func getImageFrom(url: URL,completion: @escaping (UIImage?) -> Void) {
        //check if image exists in cache

        if let image = imageCache.object(forKey: NSString(string: url.absoluteString)) {
            completion(image)
            return
        }

        //if it does, get from cache, else proceed
        URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard let self = self else { return }
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
            //put in cache
            self.imageCache.setObject(image, forKey: NSString(string: url.absoluteString))
            completion(image)
        }.resume()
    }
}
