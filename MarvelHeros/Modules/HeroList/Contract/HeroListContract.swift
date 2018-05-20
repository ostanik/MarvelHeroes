//
//  HeroContract.swift
//  MarvelHeros
//
//  Created by Alan Ostanik on 2018-05-17.
//  Copyright © 2018 Ostanik. All rights reserved.
//

import Foundation

protocol HeroListView: class {
    var presenter: HeroListPresentation? {get set}

    func updateHerosList(_ heros: [Hero], reachedEnd: Bool)
    func showError(message: String)
    func showLoading()
    func hideLoading()
}

protocol HeroListPresentation: class {
    var view: HeroListView? {get set}
    var router: HeroListWireframe? {get set}
    var interactor: HeroListUseCase? {get set}

    func onFetchHeros()
    func onFetchHerosPagination()
    func onSelectedHero(at: IndexPath)
    func onSearchForHero(_ name: String)
}

protocol HeroListUseCase: class {
    var output: HeroListInteractorOutput? {get set}

    func fetchHerosList(name: String, offset: Int)
}

protocol HeroListInteractorOutput: class {
    func onSuccessFetchHeros(_ dataContainer: DataContainer<Hero>)
    func onFailureFetchHeros(_ error: Error)
}

protocol HeroListWireframe: class {
    func openDetailOf(_ hero: Hero)
}
