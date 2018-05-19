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

    private var characters = [Character]() {
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

    func updateCharactersList(_ characters: [Character]) {
        self.characters = characters
    }

    func showError(message: String) {

    }

    func fetchMoreCharacters() {
        isFetchingData = true
        tableView.reloadSections(IndexSet(integer: 1), with: .automatic)
        presenter?.onFetchCharacters()
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
        return characters.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return indexPath.section == 0 ?
            tableView.dequeueReusable(forIndexPath: indexPath) as HeroCell : tableView.dequeueReusable(forIndexPath: indexPath) as SpinnerCell
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell = cell as? HeroCell, let character = characters[safe: indexPath.row] else { return }
        cell.bind(character)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height

        if (offsetY > contentHeight - scrollView.frame.height * 4) && !isFetchingData {
            fetchMoreCharacters()
        }
    }
}
