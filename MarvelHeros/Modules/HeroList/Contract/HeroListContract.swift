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

    func updateHerosList(_ heros: [Hero])
    func showError(message: String)
}

protocol HeroListPresentation: class {
    var view: HeroListView? {get set}
    var router: HeroListWireframe? {get set}
    var interactor: HeroListUseCase? {get set}

    func onFetchHeros()
    func onSelectedHero(at: IndexPath)
}

protocol HeroListUseCase: class {
    var output: HeroListInteractorOutput? {get set}

    func fetchHerosList(offset: Int)
}

protocol HeroListInteractorOutput: class {
    func onSuccessFetchHeros(_ heros: [Hero])
    func onFailureFetchHeros(_ error: Error)
}

protocol HeroListWireframe: class {
    func openDetailOf(_ hero: Hero)
}
