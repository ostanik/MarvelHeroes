//
//  Thumbnail.swift
//  MarvelHeros
//
//  Created by Alan Ostanik on 2018-05-19.
//  Copyright © 2018 Ostanik. All rights reserved.
//

import Foundation

struct Thumbnail: Codable {
    let path: String
    let `extension`: String

    func downloadablePath(_ aspect: AspectRatio, _ size: Size) -> String {
        return "\(path)/\(aspect.rawValue)_\(size.rawValue).\(self.extension)"
    }

    enum Size: String {
        case small, medium, large, xlarge, fantastic, amazing
    }

    enum AspectRatio: String {
        case portrait, standard, landscape
    }
}
