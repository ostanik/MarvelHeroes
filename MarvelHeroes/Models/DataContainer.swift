//
//  Response.swift
//  MarvelHeroes
//
//  Created by Alan Ostanik on 2018-05-19.
//  Copyright © 2018 Ostanik. All rights reserved.
//

import Foundation

struct DataWrapper<T: Codable>: Codable {
    let data: DataContainer<T>
}

struct DataContainer<T: Codable>: Codable {
    let offset: Int
    let limit: Int
    let total: Int
    let count: Int
    let results: [T]
}

struct ListsContainer<T: Codable>: Codable {
    let avaliable: Int?
    let returned: Int?
    let collectionURI: String?
    let items: [T]
}

protocol Summary: Codable {
    var resourceURI: String? {get set}
    var name: String? {get set}
}

protocol Detailed: Codable {
    var id: Int { get set }
    var title: String? {get set}
    var description: String? {get set}
    var thumbnail: Thumbnail? {get set}
}
