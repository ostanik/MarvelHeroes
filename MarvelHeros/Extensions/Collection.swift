//
//  Collection.swift
//  MarvelHeros
//
//  Created by Alan Ostanik on 2018-05-19.
//  Copyright © 2018 Ostanik. All rights reserved.
//

import Foundation

extension Collection {
    subscript (safe index: Index) -> Element? {
        return getOrNull(index)
    }

    func getOrNull(_ index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
