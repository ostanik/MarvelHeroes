//
//  DetailsCell.swift
//  MarvelHeros
//
//  Created by Alan Ostanik on 2018-05-20.
//  Copyright © 2018 Ostanik. All rights reserved.
//

import UIKit

class DetailsCell: UITableViewCell, IdentifiableNib {
    @IBOutlet var cover: UIImageView!
    @IBOutlet var title: UILabel!
    @IBOutlet var info: UILabel!

    func bind(_ object: Detailed) {
        title.text = object.title
        info.text = object.description
        loadImage(object.thumbnail)
    }

    private func loadImage(_ thumbnail: Thumbnail?) {
        guard let thumbnail = thumbnail, let url = URL(string: thumbnail.downloadablePath(.portrait, .fantastic)) else { return }
        cover.downloadImage(url: url) { [weak self] (_, _) in
//            self?.activityIndicator.stopAnimating()
        }
    }
    
}
