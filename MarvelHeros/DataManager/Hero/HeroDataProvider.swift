//
//  HeroDataProvider.swift
//  MarvelHeros
//
//  Created by Alan Ostanik on 2018-05-19.
//  Copyright © 2018 Ostanik. All rights reserved.
//

import Foundation

class HeroDataProvider: BaseDataProvider, HerosProvider {
    func fetchHero(offset: Int, completionHandler: @escaping HerosProvider.CompletionHandler) {
        let stringUrl = baseAddress + "/characters?" + [authenticationParameters, "offset=\(offset)"].joined(separator: "&")
        request(stringUrl, method: .get) { ( container: DataContainer<Hero>?, error: Error?) in
            guard error == nil else {
                completionHandler(nil, error!)
                return
            }
            completionHandler(container, nil)
        }
    }
}
