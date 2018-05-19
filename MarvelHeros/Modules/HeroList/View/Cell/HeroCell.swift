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

    func bind(_ character: Character) {
        heroName?.text = character.name
        loadImage(character.thumbnail)
    }

    private func loadImage(_ thumbnail: Thumbnail?) {
        guard let thumbnail = thumbnail, let url = URL(string: thumbnail.downloadablePath(.landscape, .medium)) else { return }
        ImageDataProvider.shared.downloadImage(url: url) { [weak self] (image, _) in
            self?.activityIndicator.stopAnimating()
            if let image = image {
                self?.heroImage.image = image
            }
        }
    }

}
