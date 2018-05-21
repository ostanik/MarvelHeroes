//
//  HeroListViewController.swift
//  MarvelHeroes
//
//  Created by Alan Ostanik on 2018-05-17.
//  Copyright © 2018 Ostanik. All rights reserved.
//

import UIKit

class HeroListViewController: UIViewController, IdentifiableNib, HeroListView {

    // MARK: Properties

    @IBOutlet var tableView: UITableView!
    var presenter: HeroListPresentation?
    let searchController = UISearchController(searchResultsController: nil)
    private var reachedEnd: Bool = true

    private var heroes = [Hero]() {
        didSet {
            tableView.reloadData()
        }
    }

    private var canShowLoading: Bool = true {
        didSet {
            tableView.reloadData()
        }
    }

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupTable()
        presenter?.onFetchHeroes()
    }

    override func viewWillAppear(_ animated: Bool) {
        presenter?.onViewWillAppear()
    }

    private func setupView() {
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
        searchController.searchBar.placeholder = "Search for heroes"
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }

    private func setupTable() {
        tableView.tableFooterView = UIView()
        tableView.register(HeroCell.self)
        tableView.register(SpinnerCell.self)
    }

    // MARK: HeroListView Protocol methods.

    func updateHeroesList(_ heroes: [Hero], reachedEnd: Bool) {
        self.heroes = heroes
        self.reachedEnd = reachedEnd
    }

    func showError(message: String) {
        let alert = UIAlertController(title: "Sorry", message: "We have some errors on our server. \nPlease try again latter. \nError Message: \(message)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true)
    }

    func fetchMoreHeroes() {
        presenter?.onFetchHeroesPagination()
    }

    func showLoading() {
        canShowLoading = true
    }

    func hideLoading() {
        canShowLoading = false
    }
}

extension HeroListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        presenter?.onSearchForHero(searchBar.text ?? "")
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        presenter?.onFetchHeroes()
    }
}

extension HeroListViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1 {
            return canShowLoading ? 1 : 0
        }
        return heroes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return indexPath.section == 0 ?
            tableView.dequeueReusable(forIndexPath: indexPath) as HeroCell : tableView.dequeueReusable(forIndexPath: indexPath) as SpinnerCell
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell = cell as? HeroCell, let hero = heroes[safe: indexPath.row] else { return }
        cell.bind(hero)
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            presenter?.onSelectedHero(at: indexPath.row)
        }
    }

    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        guard let hero = heroes[safe: indexPath.row] else { return nil }
        var actions = [UITableViewRowAction]()
        if !hero.favorite {
            let favorite = UITableViewRowAction(style: .normal, title: "Favorite") { [weak self] (_, index) in
                guard let hero = self?.heroes[safe: index.row] else { return }
                self?.presenter?.favorite(hero)
            }
            favorite.backgroundColor = UIColor(red: 39/255, green: 189/255, blue: 190/255, alpha: 1)
            actions.append(favorite)
        } else {
            let unfavorite = UITableViewRowAction(style: .destructive, title: "Unfavourite") { [weak self] (_, index) in
                guard let hero = self?.heroes[safe: index.row] else { return }
                self?.presenter?.unfavorite(hero)
            }
            actions.append(unfavorite)
        }
        return actions
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) { }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (scrollView.contentOffset.y >= (scrollView.contentSize.height - scrollView.frame.size.height)) && !canShowLoading && !reachedEnd {
            fetchMoreHeroes()
        }
    }
}
