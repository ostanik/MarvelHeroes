//
//  HeroListInteractor.swift
//  MarvelHeroes
//
//  Created by Alan Ostanik on 2018-05-17.
//  Copyright © 2018 Ostanik. All rights reserved.
//

import Foundation

class HeroListInteractor: HeroListUseCase {

    weak var output: HeroListInteractorOutput?
    private var dataProvider: HeroesProvider
    private var userDefaults: UserDefaults
    private let favoritesKey = "Favorites"

    init(dataProvider: HeroesProvider = HeroDataProvider(), userDefaults: UserDefaults = UserDefaults.standard) {
        self.dataProvider = dataProvider
        self.userDefaults = userDefaults
    }

    // MARK: Protocol methods

    func fetchHeroesList(name: String, offset: Int) {
        dataProvider.fetchHero(startName: name, offset: offset, completionHandler: { [weak self] (response, error) in
            guard error == nil, let response = response else {
                self?.output?.onFailureFetchHeroes(error!)
                return
            }
            self?.output?.onSuccessFetchHeroes(response)
        })
    }

    func fetchFavorites() {
        if let favorites = userDefaults.object(forKey: favoritesKey) as? [Int] {
            self.output?.onFetchFavorites(favorites)
        } else {
            self.output?.onFetchFavorites([])
        }
    }

    func saveFavorites(_ heroesIds: [Int]) {
        userDefaults.set(heroesIds, forKey: favoritesKey)
        userDefaults.synchronize()
    }
}
