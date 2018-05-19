//
//  HeroListInteractor.swift
//  MarvelHeros
//
//  Created by Alan Ostanik on 2018-05-17.
//  Copyright © 2018 Ostanik. All rights reserved.
//

import Foundation

class HeroListInteractor: HeroListUseCase {

    weak var output: HeroListInteractorOutput?
    private var dataProvider: CharactersProvider!

    init(dataProvider: CharactersProvider = CharacterDataProvider()) {
        self.dataProvider = dataProvider
    }

    // MARK: Protocol methods

    func fetchCharactersList(offset: Int) {
        dataProvider.fetchCharacter(offset: offset, completionHandler: { [weak self] (response, error) in
            guard error == nil else {
                self?.output?.onFailureFetchCharacters(error!)
                return
            }
            guard let response = response else {
                let error = CharactersProviderError.nilResults(description: "No results found.")
                self?.output?.onFailureFetchCharacters(error)
                return
            }
            self?.output?.onSuccessFetchCharacters(response.results)
        })
    }
}
