//
//  ImageLoader.swift
//  NYCExperiences2
//
//  Created by Lisa J on 11/4/26.
//

import UIKit

protocol ImageLoader {
    func getImageFrom(url: URL,
                      completion: @escaping (UIImage?) -> Void)
}
