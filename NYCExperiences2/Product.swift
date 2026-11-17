//
//  Product.swift
//  NYCExperiences2
//
//  Created by Lisa J on 11/10/26.
//

import Foundation

nonisolated struct ProductsWrapper: Codable, Sendable {
    let products: [Product]
}

nonisolated struct Product: Codable, Sendable {
    let id: Int
    let title: String
    let description: String
    let category: String
    let price: Double
    let rating: Double
    let stock: Int
    let tags: [String]
    let brand: String
    let availabilityStatus: String
    let thumbnail: String
}

