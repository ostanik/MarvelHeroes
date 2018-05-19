//
//  Character.swift
//  MarvelHeros
//
//  Created by Alan Ostanik on 2018-05-19.
//  Copyright © 2018 Ostanik. All rights reserved.
//

import Foundation
import UIKit

struct Character: Codable {
    let id: Int
    let name: String?
    let description: String?
    let resourceURI: String?
    let thumbnail: Thumbnail?

    var image: UIImage?

    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case resourceURI
        case thumbnail
    }
//    let urls: [String] //(Array[Url], optional): A set of public web site URLs for the resource.,
//    let thumbnail (Image, optional): The representative image for this character.,
//    let comics (ComicList, optional): A resource list containing comics which feature this character.,
//    let stories (StoryList, optional): A resource list of stories in which this character appears.,
//    let events (EventList, optional): A resource list of events in which this character appears.,
//    let series (SeriesList, optional): A resource list of series in which this character appears.
}
