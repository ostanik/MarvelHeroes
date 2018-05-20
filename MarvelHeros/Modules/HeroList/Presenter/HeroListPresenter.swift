//
//  HeroListPresenter.swift
//  MarvelHeros
//
//  Created by Alan Ostanik on 2018-05-17.
//  Copyright © 2018 Ostanik. All rights reserved.
//

import Foundation
import UIKit

class HeroListPresenter {

    weak var view: HeroListView?
    var router: HeroListWireframe?
    var interactor: HeroListUseCase?

    private var heros = [Hero]()
    private var searchName = ""
    private var reachedEnd: Bool = true

    init(view: HeroListView = HeroListViewController(), router: HeroListWireframe = HeroListRouter(), interactor: HeroListUseCase = HeroListInteractor()) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
}

extension HeroListPresenter: HeroListPresentation {
    func onFetchHeros() {
        searchName = ""
        heros = []
        view?.showLoading()
        view?.updateHerosList([], reachedEnd: true)
        interactor?.fetchHerosList(name: searchName, offset: heros.count)
    }

    func onFetchHerosPagination() {
        view?.showLoading()
        if !reachedEnd {
            interactor?.fetchHerosList(name: searchName, offset: heros.count)
        } else {
            view?.hideLoading()
        }
    }

    func onSelectedHero(at index: IndexPath) {
        guard let char = heros[safe: index.row] else { return }
        router?.openDetailOf(char)
    }

    func onSearchForHero(_ name: String) {
        view?.updateHerosList([], reachedEnd: true)
        view?.showLoading()
        heros = []
        searchName = name
        interactor?.fetchHerosList(name: searchName, offset: 0)
    }
}

extension HeroListPresenter: HeroListInteractorOutput {
    func onSuccessFetchHeros(_ dataContainer: DataContainer<Hero>) {
        reachedEnd = dataContainer.count + dataContainer.offset == dataContainer.total
        self.heros.append(contentsOf: dataContainer.results)
        view?.updateHerosList(self.heros, reachedEnd: reachedEnd)
        view?.hideLoading()
    }

    func onFailureFetchHeros(_ error: Error) {
        if let error = error as? RequestError {
            view?.showError(message: error.description)
        } else {
            view?.showError(message: error.localizedDescription)
        }
        view?.hideLoading()
    }
}
