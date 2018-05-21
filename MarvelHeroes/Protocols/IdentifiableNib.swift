//
//  IdentifiableNib.swift
//  MarvelHeroes
//
//  Created by Alan Ostanik on 2018-05-17.
//  Copyright © 2018 Ostanik. All rights reserved.
//

import Foundation
import UIKit

protocol IdentifiableNib {
    static func fileName() -> String
    static func identifier() -> String
}

extension IdentifiableNib {
    static func fileName() -> String {
        return String(describing: Self.self)
    }

    static func identifier() -> String {
        return String(describing: Self.self)
    }
}

extension IdentifiableNib where Self: UIViewController {
    static func fileName() -> String {
        return String(describing: Self.self).replacingOccurrences(of: "ViewController", with: "")
    }
}

extension IdentifiableNib where Self: UITableViewController {
    static func fileName() -> String {
        return String(describing: Self.self).replacingOccurrences(of: "TableViewController", with: "")
    }
}
