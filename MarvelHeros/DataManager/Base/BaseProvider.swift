//
//  BaseProvider.swift
//  MarvelHeros
//
//  Created by Alan Ostanik on 2018-05-20.
//  Copyright © 2018 Ostanik. All rights reserved.
//

import Foundation

enum RequestMethod: String {
    case get, post, put, delete, patch
}

enum RequestError: Error {
    case urlError(description: String)
    case objectSerialization(description: String)
    case nilResults(description: String)

    var description: String {
        switch self {
        case .urlError(let description), .nilResults(let description), .objectSerialization(let description):
            return description
        }
    }
}

protocol BaseProvider {
    func request<T: Codable>(_ url: String, method: RequestMethod, completionHandler: @escaping (_ result: DataContainer<T>?, _ error: Error?) -> Void)
    func request<T: Codable>(_ url: URL, method: RequestMethod, completionHandler: @escaping (_ result: DataContainer<T>?, _ error: Error?) -> Void)
}
