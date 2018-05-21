//
//  HeroListPresenter.swift
//  MarvelHeroes
//
//  Created by Alan Ostanik on 2018-05-17.
//  Copyright © 2018 Ostanik. All rights reserved.
//

import Foundation
import UIKit

class HeroListPresenter {

    weak var view: HeroListView?
    var router: HeroListWireframe
    var interactor: HeroListUseCase

    var heroes = [Hero]()
    var favoritedHeroesIds = [Int]()
    var searchName = ""
    var reachedEnd: Bool = true

    init(router: HeroListWireframe = HeroListRouter(), interactor: HeroListUseCase = HeroListInteractor()) {
        self.router = router
        self.interactor = interactor
    }
}

extension HeroListPresenter: HeroListPresentation {
    func onViewWillAppear() {
        if heroes.count > 0 {
            interactor.fetchFavorites()
        }
    }

    func onFetchHeroes() {
        searchName = ""
        heroes = []
        view?.showLoading()
        view?.updateHeroesList([], reachedEnd: true)
        interactor.fetchHeroesList(name: searchName, offset: heroes.count)
        interactor.fetchFavorites()
    }

    func onFetchHeroesPagination() {
        view?.showLoading()
        if !reachedEnd {
            interactor.fetchHeroesList(name: searchName, offset: heroes.count)
        } else {
            view?.hideLoading()
        }
    }

    func onSelectedHero(at: Int) {
        guard let char = heroes[safe: at] else { return }
        router.openDetailOf(char)
    }

    func onSearchForHero(_ name: String) {
        view?.updateHeroesList([], reachedEnd: true)
        view?.showLoading()
        heroes = []
        searchName = name
        interactor.fetchHeroesList(name: searchName, offset: 0)
    }

    func favorite(_ hero: Hero) {
        if favoritedHeroesIds.index(where: {$0 == hero.id}) == nil {
            favoritedHeroesIds.append(hero.id)
        }
        updateFavoritedHeroes()
    }

    func unfavorite(_ hero: Hero) {
        if let index = favoritedHeroesIds.index(where: {$0 == hero.id}) {
            favoritedHeroesIds.remove(at: index)
        }
        updateFavoritedHeroes()
    }

    private func updateFavoritedHeroes() {
        interactor.saveFavorites(favoritedHeroesIds)
        heroes = getFavoritedHeros(heroes: heroes, favoriteIds: favoritedHeroesIds)
        view?.updateHeroesList(heroes, reachedEnd: reachedEnd)
    }
}

extension HeroListPresenter: HeroListInteractorOutput {

    func onFetchFavorites(_ heroesIds: [Int]) {
        favoritedHeroesIds = heroesIds
        heroes = getFavoritedHeros(heroes: heroes, favoriteIds: favoritedHeroesIds)
        view?.updateHeroesList(heroes, reachedEnd: reachedEnd)
        view?.hideLoading()
    }

    func onSuccessFetchHeroes(_ dataContainer: DataContainer<Hero>) {
        reachedEnd = dataContainer.count + dataContainer.offset == dataContainer.total
        heroes.append(contentsOf: dataContainer.results)
        interactor.fetchFavorites()
    }

    func onFailureFetchHeroes(_ error: Error) {
        if let error = error as? RequestError {
            view?.showError(message: error.description)
        } else {
            view?.showError(message: error.localizedDescription)
        }
        view?.hideLoading()
    }

    private func getFavoritedHeros(heroes: [Hero], favoriteIds: [Int]) -> [Hero] {
        let newHeroes: [Hero] = heroes.map { hero in
            var mutableHero = hero
            mutableHero.favorite = favoriteIds.index(where: { $0 == hero.id }) != nil
            return mutableHero
        }
        return newHeroes
    }
}
