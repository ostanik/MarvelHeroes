//
//  CharactersProvider.swift
//  MarvelHeros
//
//  Created by Alan Ostanik on 2018-05-19.
//  Copyright © 2018 Ostanik. All rights reserved.
//

import Foundation

enum CharactersProviderError: Error {
    case urlError(description: String)
    case objectSerialization(description: String)
    case nilResults(description: String)

    var description: String {
        switch self {
        case .nilResults(let description), .objectSerialization(let description), .urlError(let description):
            return description
        }
    }
}

protocol CharactersProvider {
    typealias CompletionHandler = (_ result: DataContainer<Character>?, _ error: Error?) -> Void

    func fetchCharacter(offset: Int, completionHandler: @escaping CompletionHandler)
}
