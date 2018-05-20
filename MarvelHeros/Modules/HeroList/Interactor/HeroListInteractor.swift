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
    private var dataProvider: HerosProvider!

    init(dataProvider: HerosProvider = HeroDataProvider()) {
        self.dataProvider = dataProvider
    }

    // MARK: Protocol methods

    func fetchHerosList(name: String, offset: Int) {
        dataProvider.fetchHero(startName: name, offset: offset, completionHandler: { [weak self] (response, error) in
            guard error == nil, let response = response else {
                self?.output?.onFailureFetchHeros(error!)
                return
            }
            self?.output?.onSuccessFetchHeros(response)
        })
    }
}
