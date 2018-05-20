//
//  HeroListViewController.swift
//  MarvelHeros
//
//  Created by Alan Ostanik on 2018-05-17.
//  Copyright © 2018 Ostanik. All rights reserved.
//

import UIKit

class HeroListViewController: UIViewController, IdentifiableNib, HeroListView {
    @IBOutlet var tableView: UITableView!
    var presenter: HeroListPresentation?

    private var isFetchingData: Bool = false

    private var heros = [Hero]() {
        didSet {
            isFetchingData = false
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupTable()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    private func setupView() {
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    private func setupTable() {
        tableView.tableFooterView = UIView()
        tableView.register(HeroCell.self)
        tableView.register(SpinnerCell.self)
    }

    // MARK: HeroListView Protocol methods.

    func updateHerosList(_ heros: [Hero]) {
        self.heros = heros
    }

    func showError(message: String) {
        let alert = UIAlertController(title: "Sorry", message: "We have some errors on our server. \nPlease try again latter. \nError Message: \(message)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true)
    }

    func fetchMoreHeros() {
        isFetchingData = true
        tableView.reloadSections(IndexSet(integer: 1), with: .automatic)
        presenter?.onFetchHeros()
    }
}

extension HeroListViewController: UITableViewDataSource, UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1 {
            return isFetchingData ? 1 : 0
        }
        return heros.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return indexPath.section == 0 ?
            tableView.dequeueReusable(forIndexPath: indexPath) as HeroCell : tableView.dequeueReusable(forIndexPath: indexPath) as SpinnerCell
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell = cell as? HeroCell, let hero = heros[safe: indexPath.row] else { return }
        cell.bind(hero)
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.onSelectedHero(at: indexPath)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height

        if (offsetY > contentHeight - scrollView.frame.height * 4) && !isFetchingData {
            fetchMoreHeros()
        }
    }
}
