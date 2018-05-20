//
//  ImageProvider.swift
//  MarvelHeros
//
//  Created by Alan Ostanik on 2018-05-19.
//  Copyright © 2018 Ostanik. All rights reserved.
//

import Foundation
import UIKit

class ImageDataProvider {
    let imageCache = NSCache<NSString, UIImage>()
    static var shared = ImageDataProvider()

    private func getDataFromUrl(url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        DispatchQueue.global(qos: .background).async {
            URLSession.shared.dataTask(with: url) { data, response, error in
                completion(data, response, error)
            }.resume()
        }
    }

    private func fetchImageFromCache(_ url: URL) -> UIImage? {
        guard let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) else { return nil }
        return cachedImage
    }

    func downloadImage(url: URL, completion: @escaping (_ image: UIImage?, _ error: Error?) -> Void) {
        if let image = fetchImageFromCache(url) {
            completion(image, nil)
        } else {
            getDataFromUrl(url: url) { data, _, error in
                DispatchQueue.main.async { [weak self] in
                    if let data = data, error == nil, let image = UIImage(data: data) {
                        self?.imageCache.setObject(image, forKey: url.absoluteString as NSString)
                        completion(image, nil)
                    } else {
                        completion(nil, error)
                    }
                }
            }
        }
    }
}
