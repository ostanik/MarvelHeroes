//
//  Hero.swift
//  MarvelHeros
//
//  Created by Alan Ostanik on 2018-05-19.
//  Copyright © 2018 Ostanik. All rights reserved.
//

import Foundation
import UIKit

struct Hero: Codable {
    let id: Int
    let name: String?
    let description: String?
    let resourceURI: String?
    let thumbnail: Thumbnail?

    let comics: ListsContainer<ComicSummary>?
    let events: ListsContainer<EventSummary>?
    let series: ListsContainer<SeriesSummary>?
    let stories: ListsContainer<StorySummary>?

    var detailedComics = [Comic]()
    var detailedEvents = [Event]()
    var detailedSeries = [Series]()
    var detailedStories = [Story]()

    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case resourceURI
        case thumbnail
        case comics
        case events
        case series
        case stories
    }
}
