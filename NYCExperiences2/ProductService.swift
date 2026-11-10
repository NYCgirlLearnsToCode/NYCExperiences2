//
//  ProductService.swift
//  NYCExperiences2
//
//  Created by Lisa J on 11/10/26.
//

import Foundation

class ProductService {
    func getProducts(completion: @escaping ([Product]?) -> Void) {
        guard let url = URL(string: "https://dummyjson.com/products?limit=10") else {
            print("invalid url")
            completion(nil)
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error)
                completion(nil)
                return
            }

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
            do {
                let productsWrapper = try JSONDecoder().decode(ProductsWrapper.self, from: data)
                completion(productsWrapper.products)
            } catch {
                print(error)
                completion(nil)
            }
        }.resume()
    }
}
