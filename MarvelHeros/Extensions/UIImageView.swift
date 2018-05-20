//
//  UIImageViewe.swift
//  MarvelHeros
//
//  Created by Alan Ostanik on 2018-05-20.
//  Copyright © 2018 Ostanik. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    func downloadImage(url: URL, completion: ((_ image: UIImage?, _ error: Error?) -> Void)? = nil) {
        ImageDataProvider.shared.downloadImage(url: url) { [weak self] (image, error) in
            if let image = image {
                self?.image = image
            }
            completion?(image, error)
        }
    }
}
