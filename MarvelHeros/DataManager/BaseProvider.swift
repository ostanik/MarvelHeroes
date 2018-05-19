//
//  BaseProvider.swift
//  MarvelHeros
//
//  Created by Alan Ostanik on 2018-05-19.
//  Copyright © 2018 Ostanik. All rights reserved.
//

import Foundation

class BaseProvider {
    private var apiPublicKey = "3106aa442a60d2bf99c4d19647a9b1fb"
    private var apiPrivateKey = "58177030188879a8f37fb9a7e2a2aa63472fb209"

    static let shared = BaseProvider()

    var authenticationParameters: String {
        let timestamp = String(Date().timeIntervalSince1970)
        let hash = requestHash(timestamp: timestamp, apiPrivateKey: apiPrivateKey, apiPublicKey: apiPublicKey)
        return requestAutenticationParameters(timestamp: timestamp, apiPublicKey: apiPublicKey, hash: hash)
    }

    func requestAutenticationParameters(timestamp: String, apiPublicKey: String, hash: String) -> String {
        return ["ts=\(timestamp)", "apikey=\(apiPublicKey)", "hash=\(hash)"].joined(separator: "&")
    }

    func requestHash(timestamp: String, apiPrivateKey: String, apiPublicKey: String) -> String {
        let hash = MD5(string: timestamp + apiPrivateKey + apiPublicKey)
        return hash.map { String(format: "%02hhx", $0) }.joined()
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
