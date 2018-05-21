//
//  BaseProvider.swift
//  MarvelHeroes
//
//  Created by Alan Ostanik on 2018-05-19.
//  Copyright © 2018 Ostanik. All rights reserved.
//

import Foundation

class BaseDataProvider: BaseProvider {

    // MARK: Properties

    private let apiPublicKey = "3106aa442a60d2bf99c4d19647a9b1fb"
    private let apiPrivateKey = "58177030188879a8f37fb9a7e2a2aa63472fb209"
    private let apiAddress = "https://gateway.marvel.com/v1/public"
    private var session: URLSession!

    // MARK: Computed vars

    var baseAddress: String {
        return apiAddress
    }

    var authenticationParameters: String {
        let timestamp = String(Date().timeIntervalSince1970)
        let hash = requestHash(timestamp: timestamp, apiPrivateKey: apiPrivateKey, apiPublicKey: apiPublicKey)
        return requestAutenticationParameters(timestamp: timestamp, apiPublicKey: apiPublicKey, hash: hash)
    }

    // MARK: lifecycle

    init(with cachePolicy: NSURLRequest.CachePolicy = .reloadRevalidatingCacheData) {
        session = URLSession(configuration: .default)
        session.configuration.requestCachePolicy = cachePolicy
    }

    func requestAutenticationParameters(timestamp: String, apiPublicKey: String, hash: String) -> String {
        return ["ts=\(timestamp)", "apikey=\(apiPublicKey)", "hash=\(hash)"].joined(separator: "&")
    }

    func requestHash(timestamp: String, apiPrivateKey: String, apiPublicKey: String) -> String {
        let hash = MD5(string: timestamp + apiPrivateKey + apiPublicKey)
        return hash.map { String(format: "%02hhx", $0) }.joined()
    }

    func request<T: Codable>(_ url: String, method: RequestMethod, completionHandler: @escaping (DataContainer<T>?, Error?) -> Void) {
        guard let url = URL(string: url) else {
            completionHandler(nil, RequestError.urlError(description: "Unable to create API URL"))
            return
        }

        request(url, method: method, completionHandler: completionHandler)
    }

    func request<T: Codable>(_ url: URL, method: RequestMethod, completionHandler: @escaping (DataContainer<T>?, Error?) -> Void) {
        let request = getRequest(url: url, method: method)
        performRequest(with: request) { (data, _, error) in
            guard error == nil else {
                completionHandler(nil, error!)
                return
            }

            guard let responseData = data else {
                let error = RequestError.nilResults(description: "No data in response")
                completionHandler(nil, error)
                return
            }

            do {
                let encoder = JSONDecoder()
                let result = try encoder.decode(DataWrapper<T>.self, from: responseData)
                completionHandler(result.data, nil)
            } catch {
                print(error)
                completionHandler(nil, RequestError.objectSerialization(description: "Unable to serialize the response object"))
                return
            }
        }
    }

    // MARK: Private

    private func getRequest(url: URL, method: RequestMethod) -> URLRequest {
        var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 60)
        request.httpMethod = method.rawValue
        return request
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

    private func MD5(string: String) -> Data {
        let messageData = string.data(using: .utf8)!
        var digestData = Data(count: Int(CC_MD5_DIGEST_LENGTH))

        _ = digestData.withUnsafeMutableBytes {digestBytes in
            messageData.withUnsafeBytes {messageBytes in
                CC_MD5(messageBytes, CC_LONG(messageData.count), digestBytes)
            }
        }

        return digestData
    }
}
