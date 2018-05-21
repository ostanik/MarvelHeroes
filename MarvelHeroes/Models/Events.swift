//
//  Events.swift
//  MarvelHeroes
//
//  Created by Alan Ostanik on 2018-05-20.
//  Copyright © 2018 Ostanik. All rights reserved.
//

import Foundation

struct EventSummary: Summary {
    var resourceURI: String?
    var name: String?
}

struct Event: Detailed {
    var id: Int
    var title: String?
    var description: String?
    var thumbnail: Thumbnail?
}
