//
//  Experience.swift
//  NYCExperiences2
//
//  Created by Lisa J on 11/4/26.
//

import Foundation

struct Experience {
    let title: String
    let price: Double
    let imageUrl: String
    let description: String
}

extension Experience {
    init(product: Product) {
        self.title = product.title
        self.price = product.price
        self.imageUrl = product.thumbnail
        self.description = product.description
    }
}
