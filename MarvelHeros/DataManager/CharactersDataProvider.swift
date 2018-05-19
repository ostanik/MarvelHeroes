//
//  CharacterDataProvider.swift
//  MarvelHeros
//
//  Created by Alan Ostanik on 2018-05-19.
//  Copyright © 2018 Ostanik. All rights reserved.
//

import Foundation

struct CharacterDataProvider: CharactersProvider {

    private var APIAddress = "https://gateway.marvel.com/v1/public"
    private var session: URLSession!

    init(with cachePolicy: NSURLRequest.CachePolicy = .reloadRevalidatingCacheData) {
        session = URLSession(configuration: .default)
        session.configuration.requestCachePolicy = cachePolicy
    }

    func fetchCharacter(offset: Int, completionHandler: @escaping CharactersProvider.CompletionHandler) {
        guard let url = URL(string: APIAddress + "/characters?" + [BaseProvider.shared.authenticationParameters, "offset=\(offset)"].joined(separator: "&")) else {
            let error = CharactersProviderError.urlError(description: "Unable to create API URL")
            completionHandler(nil, error)
            return
        }

        let request = getRequest(url: url)
        performRequest(with: request) { (data, _, error) in
            guard error == nil else {
                completionHandler(nil, error!)
                return
            }

            guard let responseData = data else {
                let error = CharactersProviderError.objectSerialization(description: "No data in response")
                completionHandler(nil, error)
                return
            }

            do {
                let encoder = JSONDecoder()
                let result = try encoder.decode(DataWrapper<Character>.self, from: responseData)
                completionHandler(result.data, nil)
            } catch {
                completionHandler(nil, error)
                return
            }
        }
    }

    // MARK: Private

    private func getRequest(url: URL) -> URLRequest {
        return URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 60)
    }

    private func performRequest(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        DispatchQueue.global(qos: .background).async {
            self.session.dataTask(with: request) { (data, response, error) in
                DispatchQueue.main.async {
                    completionHandler(data, response, error)
                }
            }.resume()
        }
    }
}
