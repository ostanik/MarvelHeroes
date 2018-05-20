//
//  HeroDetailViewController.swift
//  MarvelHeros
//
//  Created by Alan Ostanik on 2018-05-20.
//Copyright © 2018 Ostanik. All rights reserved.
//

import Foundation
import UIKit

class HeroDetailViewController: UIViewController, IdentifiableNib, HeroDetailView {

    // MARK: Properties
    @IBOutlet var tableView: UITableView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var noResultsFound: UILabel!
    
    var presenter: HeroDetailPresentation?
    var hero: Hero? {
        didSet {
            tableView.reloadData()
        }
    }

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        presenter?.onViewDidLoad()
    }

    private func setupTableView() {
        tableView.tableFooterView = UIView()
        tableView.register(DetailsCell.self)
    }

    // MARK: HeroDetailView protocol methods

    func setupPageTitle(_ string: String) {
        title = string
    }

    func updateScreenWith(_ hero: Hero) {
        self.hero = hero
        activityIndicator.stopAnimating()
        noResultsFound.isHidden = totalResults() != 0
        tableView.isHidden = !noResultsFound.isHidden
    }

    private func totalResults() -> Int {
        let total = [0...3].enumerated().map({ heroCollection(for: $0.offset).count }).reduce(0, +)
        return total
    }
}

extension HeroDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return heroCollection(for: section).count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusable(forIndexPath: indexPath) as DetailsCell
        if let detailedObject = object(at: indexPath) {
            cell.bind(detailedObject)
        }
        return cell
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0: return "Comics"
        case 1: return "Events"
        case 2: return "Series"
        case 3: return "Stories"
        default: return nil 
        }
    }

    private func object(at indexPath: IndexPath) -> Detailed? {
        let collection = heroCollection(for: indexPath.section)
        guard let detailedObject = collection[safe: indexPath.row] else { return nil}
        return detailedObject
    }

    private func heroCollection(for section: Int) -> [Detailed] {
        guard let hero = hero else { return [] }
        switch section {
        case 0: return hero.detailedComics
        case 1: return hero.detailedEvents
        case 2: return hero.detailedSeries
        case 3: return hero.detailedStories
        default: return []
        }
    }
}
