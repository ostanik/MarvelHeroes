//
//  EventProvider.swift
//  MarvelHeroes
//
//  Created by Alan Ostanik on 2018-05-20.
//  Copyright © 2018 Ostanik. All rights reserved.
//

import Foundation

protocol EventProvider {
    typealias CompletionHandler = (_ result: DataContainer<Event>?, _ error: Error?) -> Void
    func fetchDetail(detailPage: String, completionHandler: @escaping CompletionHandler)
}
