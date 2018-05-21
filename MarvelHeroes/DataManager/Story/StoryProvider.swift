//
//  StoryProvider.swift
//  MarvelHeroes
//
//  Created by Alan Ostanik on 2018-05-20.
//  Copyright © 2018 Ostanik. All rights reserved.
//

import Foundation

protocol StoryProvider {
    typealias CompletionHandler = (_ result: DataContainer<Story>?, _ error: Error?) -> Void
    func fetchDetail(detailPage: String, completionHandler: @escaping CompletionHandler)
}
