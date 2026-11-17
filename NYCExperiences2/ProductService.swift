//
//  ProductService.swift
//  NYCExperiences2
//
//  Created by Lisa J on 11/10/26.
//

import Foundation

enum ProductServiceError: Error {
    case invalidURL
    case noData
    case invalidResponse
    case httpStatusCode(Int)
}

class ProductService {
    func getProducts(completion: @escaping (Result<[Product], Error>) -> Void) {
        guard let url = URL(string: "https://dummyjson.com/products?limit=10") else {
            https://dummyjson.com/products/category/nonexistent
            print("invalid url")
            completion(.failure(ProductServiceError.invalidURL))
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error)
                completion(.failure(error))
                return
            }

            guard let data = data else {
                print("No data recieved")
                completion(.failure(ProductServiceError.noData))
                return
            }

            guard let response = response as? HTTPURLResponse else {
                print("response invalid \(String(describing: response))")
                completion(.failure(ProductServiceError.invalidResponse))
                return
            }

            let statusCode = response.statusCode
            if !(200...299).contains(statusCode) {
                completion(.failure(ProductServiceError.httpStatusCode(statusCode)))
                return
            }

            do {
                let productsWrapper = try JSONDecoder().decode(ProductsWrapper.self, from: data)
                completion(.success(productsWrapper.products))
            } catch {
                print(error)
                completion(.failure(error))
            }
        }.resume()
    }
}
