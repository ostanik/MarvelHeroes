//
//  UITableView.swift
//  CryptoCap
//
//  Created by Alan Ostanik on 2018-02-11.
//  Copyright © 2018 Alan Ostanik. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {

    func register<T>(_ type: T.Type) where T: UITableViewCell, T: IdentifiableNib {
        let nib = UINib.init(nibName: T.fileName(), bundle: nil)
        self.register(nib, forCellReuseIdentifier: T.identifier())
    }

    func dequeueReusable<T: UITableViewCell>(forIndexPath indexPath: IndexPath) -> T where T: IdentifiableNib {
        guard let cell = dequeueReusableCell(withIdentifier: T.identifier(), for: indexPath) as? T else {
            fatalError("Couldn't dequeue cell with identifier: \(T.identifier()).")
        }
        return cell
    }

}
