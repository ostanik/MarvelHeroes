//
//  Comic.swift
//  MarvelHeros
//
//  Created by Alan Ostanik on 2018-05-20.
//  Copyright © 2018 Ostanik. All rights reserved.
//

import Foundation

struct ComicSummary: Summary {
    var resourceURI: String?
    var name: String?
}

struct Comic: Detailed {
    var id: Int
    var title: String?
    var description: String?
    var thumbnail: Thumbnail?
}
