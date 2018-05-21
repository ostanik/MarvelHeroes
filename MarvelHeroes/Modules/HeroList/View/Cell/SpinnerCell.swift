//
//  SpinnerCellTableViewCell.swift
//  MarvelHeroes
//
//  Created by Alan Ostanik on 2018-05-19.
//  Copyright © 2018 Ostanik. All rights reserved.
//

import UIKit

class SpinnerCell: UITableViewCell, IdentifiableNib {
    @IBOutlet var activityIndicator: UIActivityIndicatorView!

    override func prepareForReuse() {
        super.prepareForReuse()
        activityIndicator.startAnimating()
    }
}
