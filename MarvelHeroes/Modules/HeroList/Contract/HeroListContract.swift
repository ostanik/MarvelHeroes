//
//  HeroContract.swift
//  MarvelHeroes
//
//  Created by Alan Ostanik on 2018-05-17.
//  Copyright © 2018 Ostanik. All rights reserved.
//

import Foundation

protocol HeroListView: class {
    var presenter: HeroListPresentation? {get set}

    func updateHeroesList(_ heroes: [Hero], reachedEnd: Bool)
    func showError(message: String)
    func showLoading()
    func hideLoading()
}

protocol HeroListPresentation: class {
    var view: HeroListView? {get set}
    var router: HeroListWireframe {get set}
    var interactor: HeroListUseCase {get set}

    func onViewWillAppear()
    func onFetchHeroes()
    func onFetchHeroesPagination()
    func onSelectedHero(at: Int)
    func onSearchForHero(_ name: String)
    func favorite(_ hero: Hero)
    func unfavorite(_ hero: Hero)
}

protocol HeroListUseCase: class {
    var output: HeroListInteractorOutput? {get set}

    func fetchHeroesList(name: String, offset: Int)
    func fetchFavorites()
    func saveFavorites(_ heroesIds: [Int])
}

protocol HeroListInteractorOutput: class {
    func onFetchFavorites(_ heroesIds: [Int])
    func onSuccessFetchHeroes(_ dataContainer: DataContainer<Hero>)
    func onFailureFetchHeroes(_ error: Error)
}

protocol HeroListWireframe: class {
    func openDetailOf(_ hero: Hero)
}
