//
//  UIStoryboard.swift
//  MarvelHeros
//
//  Created by Alan Ostanik on 2018-05-17.
//  Copyright © 2018 Ostanik. All rights reserved.
//

import Foundation
import UIKit

extension UIStoryboard {
    static func loadViewController<T>() -> T where T: IdentifiableNib, T: UIViewController {
        // swiftlint:disable:next force_cast
        return UIStoryboard(name: T.fileName(), bundle: nil).instantiateViewController(withIdentifier: T.identifier()) as! T
    }
}
