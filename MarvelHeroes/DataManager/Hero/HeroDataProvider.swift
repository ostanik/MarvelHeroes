//
//  HeroDataProvider.swift
//  MarvelHeroes
//
//  Created by Alan Ostanik on 2018-05-19.
//  Copyright © 2018 Ostanik. All rights reserved.
//

import Foundation

class HeroDataProvider: BaseDataProvider, HeroesProvider {
    func fetchHero(startName: String, offset: Int, completionHandler: @escaping HeroesProvider.CompletionHandler) {
        var stringUrl = baseAddress + "/characters?" + [authenticationParameters, "offset=\(offset)"].joined(separator: "&")
        if !startName.isEmpty {
            stringUrl += "&nameStartsWith=\(startName)"
        }
        request(stringUrl, method: .get) { ( container: DataContainer<Hero>?, error: Error?) in
            guard error == nil else {
                completionHandler(nil, error!)
                return
            }
            completionHandler(container, nil)
        }
    }
}
