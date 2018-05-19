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

    private var characters = [Character]()

    init(view: HeroListView = HeroListViewController(), router: HeroListWireframe = HeroListRouter(), interactor: HeroListUseCase = HeroListInteractor()) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
}

extension HeroListPresenter: HeroListPresentation {
    func onFetchCharacters() {
        interactor?.fetchCharactersList(offset: characters.count)
    }
}

extension HeroListPresenter: HeroListInteractorOutput {
    func onSuccessFetchCharacters(_ characters: [Character]) {
        self.characters.append(contentsOf: characters)
        view?.updateCharactersList(self.characters)
    }

    func onFailureFetchCharacters(_ error: Error) {
        if let error = error as? CharactersProviderError {
            view?.showError(message: error.description)
        } else {
            view?.showError(message: error.localizedDescription)
        }
    }
}
