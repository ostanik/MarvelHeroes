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

    init(view: HeroListView = HeroListViewController(), router: HeroListWireframe = HeroListRouter(), interactor: HeroListUseCase = HeroListInteractor()) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
}

extension HeroListPresenter: HeroListPresentation {
    func onFetchHeros() {
        interactor?.fetchHerosList(offset: heros.count)
    }

    func onSelectedHero(at index: IndexPath) {
        guard let char = heros[safe: index.row] else { return }
        router?.openDetailOf(char)
    }
}

extension HeroListPresenter: HeroListInteractorOutput {
    func onSuccessFetchHeros(_ heros: [Hero]) {
        self.heros.append(contentsOf: heros)
        view?.updateHerosList(self.heros)
    }

    func onFailureFetchHeros(_ error: Error) {
        if let error = error as? RequestError {
            view?.showError(message: error.description)
        } else {
            view?.showError(message: error.localizedDescription)
        }
    }
}
