//
//  HeroCell.swift
//  MarvelHeros
//
//  Created by Alan Ostanik on 2018-05-19.
//  Copyright © 2018 Ostanik. All rights reserved.
//

import Foundation
import UIKit

class HeroCell: UITableViewCell, IdentifiableNib {
    @IBOutlet var heroName: UILabel!
    @IBOutlet var heroImage: UIImageView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        heroImage.image = nil
        activityIndicator.startAnimating()
    }

    func bind(_ hero: Hero) {
        heroName?.text = hero.name
        loadImage(hero.thumbnail)
    }

    private func loadImage(_ thumbnail: Thumbnail?) {
        guard let thumbnail = thumbnail, let url = URL(string: thumbnail.downloadablePath(.landscape, .medium)) else { return }
        heroImage.downloadImage(url: url) { [weak self] (_, _) in
            self?.activityIndicator.stopAnimating()
        }
    }

}
