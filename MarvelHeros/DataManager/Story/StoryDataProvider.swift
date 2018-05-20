//
//  EventsDataProvider.swift
//  MarvelHeros
//
//  Created by Alan Ostanik on 2018-05-20.
//  Copyright © 2018 Ostanik. All rights reserved.
//

import Foundation

class StoryDataProvider: BaseDataProvider, StoryProvider {
    func fetchDetail(detailPage: String, completionHandler: @escaping StoryProvider.CompletionHandler) {
        request(detailPage + "?\(authenticationParameters)", method: .get) { ( container: DataContainer<Story>?, error: Error?) in
            guard error == nil else {
                completionHandler(nil, error!)
                return
            }
            completionHandler(container, nil)
        }
    }
}
