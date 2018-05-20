//
//  Story.swift
//  MarvelHeros
//
//  Created by Alan Ostanik on 2018-05-20.
//  Copyright © 2018 Ostanik. All rights reserved.
//

import Foundation

struct StorySummary: Summary {
    var resourceURI: String?
    var name: String?
    var type: String?
}

struct Story: Detailed {
    var id: Int
    var title: String?
    var description: String?
    var thumbnail: Thumbnail?
    var type: String?
}
