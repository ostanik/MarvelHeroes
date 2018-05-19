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

    func updateCharactersList(_ characters: [Character])
    func showError(message: String)
}

protocol HeroListPresentation: class {
    var view: HeroListView? {get set}
    var router: HeroListWireframe? {get set}
    var interactor: HeroListUseCase? {get set}

    func onFetchCharacters()
}

protocol HeroListUseCase: class {
    var output: HeroListInteractorOutput? {get set}

    func fetchCharactersList(offset: Int)
}

protocol HeroListInteractorOutput: class {
    func onSuccessFetchCharacters(_ characters: [Character])
    func onFailureFetchCharacters(_ error: Error)
}

protocol HeroListWireframe: class {}
