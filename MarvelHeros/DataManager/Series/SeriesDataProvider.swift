//
//  SeriesDataProvider.swift
//  MarvelHeros
//
//  Created by Alan Ostanik on 2018-05-20.
//  Copyright © 2018 Ostanik. All rights reserved.
//

import Foundation

class SeriesDataProvider: BaseDataProvider, SeriesProvider {
    func fetchDetail(detailPage: String, completionHandler: @escaping SeriesProvider.CompletionHandler) {
        request(detailPage + "?\(authenticationParameters)", method: .get) { ( container: DataContainer<Series>?, error: Error?) in
            guard error == nil else {
                completionHandler(nil, error!)
                return
            }
            completionHandler(container, nil)
        }
    }
}
