//
//  HeroListInteractor.swift
//  MarvelHeroesTests
//
//  Created by Alan Ostanik on 2018-05-21.
//  Copyright © 2018 Ostanik. All rights reserved.
//

import XCTest
@testable import MarvelHeroes

class HeroListInteractor: XCTestCase {
    // swiftlint:disable force_cast
    class MockeInteractor: HeroListUseCase {
        var fetchedHeros: DataContainer<Hero>?
        var favorites = [Int]()
        var output: HeroListInteractorOutput?
        var savedFavorites: Int = 0

        func fetchHeroesList(name: String, offset: Int) {
            guard let dataContainer = fetchedHeros else {
                self.output?.onFailureFetchHeroes(XCTestCase.AnyError.any)
                return
            }
            self.output?.onSuccessFetchHeroes(dataContainer)
        }

        func fetchFavorites() {
            self.output?.onFetchFavorites(favorites)
        }

        func saveFavorites(_ heroesIds: [Int]) {
            favorites = heroesIds
            savedFavorites += 1
        }
    }

    var sut: HeroListPresenter!
    
    override func setUp() {
        super.setUp()
        let mockedInteractor = MockeInteractor()
        sut = HeroListPresenter(interactor: mockedInteractor)
        mockedInteractor.output = sut
    }

    func testFetchFavoritedHeroesWithoutHeroesList() {
        let mockedInteractor = sut.interactor as! MockeInteractor
        mockedInteractor.favorites = [0]
        sut.onViewWillAppear()
        XCTAssert(sut.favoritedHeroesIds.first == nil)
    }

    func testFetchFavoritedHeroesWithHeroesList() {
        guard let hero: Hero = self.loadObjectFromJSON(withFileNamed: "3DMan") else {
            XCTFail("Unable to load the json file")
            return
        }
        let mockedInteractor = sut.interactor as! MockeInteractor
        mockedInteractor.favorites = [0]
        sut.heroes = [hero]
        sut.onViewWillAppear()
        XCTAssertEqual(sut.favoritedHeroesIds.first, mockedInteractor.favorites.first)
    }

    func testClearFetchHeroes() {
        guard let container: DataContainer<Hero> = self.loadObjectFromJSON(withFileNamed: "DataContainer") else {
            XCTFail("Unable to load the json file")
            return
        }
        let mockedInteractor = sut.interactor as! MockeInteractor
        mockedInteractor.fetchedHeros = container
        sut.onFetchHeroes()

        XCTAssert(sut.searchName.isEmpty)
        XCTAssertEqual(sut.heroes.first?.id, 1011334) // JSON first Hero ID
    }

    func testClearFechHeroesWithFavorite() {
        guard let container: DataContainer<Hero> = self.loadObjectFromJSON(withFileNamed: "DataContainer") else {
            XCTFail("Unable to load the json file")
            return
        }
        let mockedInteractor = sut.interactor as! MockeInteractor
        mockedInteractor.fetchedHeros = container
        mockedInteractor.favorites = [1011334]
        sut.onFetchHeroes()
        XCTAssertEqual(sut.favoritedHeroesIds.first, 1011334) // JSON first Hero ID
    }

    func testClearFechHeroesReachedEnd() {
        let container = DataContainer<Hero>(offset: 15, limit: 0, total: 30, count: 15, results: [])
        let mockedInteractor = sut.interactor as! MockeInteractor
        mockedInteractor.fetchedHeros = container
        sut.onFetchHeroes()
        // to reachedEnd be true count + offeset must be equal total
        XCTAssert(sut.reachedEnd)
    }

    func testClearFechHeroesDidintReachedEnd() {
        let container = DataContainer<Hero>(offset: 20, limit: 0, total: 130, count: 20, results: [])
        let mockedInteractor = sut.interactor as! MockeInteractor
        mockedInteractor.fetchedHeros = container
        sut.onFetchHeroes()
        // to reachedEnd be true count + offeset must be equal total
        XCTAssert(!sut.reachedEnd)
    }

    func testSetHeroToFavorite() {
        guard let hero: Hero = self.loadObjectFromJSON(withFileNamed: "3DMan") else {
            XCTFail("Unable to load the json file")
            return
        }
        let mockedInteractor = sut.interactor as! MockeInteractor
        sut.heroes = [hero]
        sut.favorite(hero)
        XCTAssertEqual(sut.favoritedHeroesIds.first, 1011334)
        XCTAssertEqual(mockedInteractor.favorites.first, 1011334)
        XCTAssertEqual(mockedInteractor.savedFavorites, 1)
    }

    func testSetHeroToUnfavourit() {
        guard let hero: Hero = self.loadObjectFromJSON(withFileNamed: "3DMan") else {
            XCTFail("Unable to load the json file")
            return
        }
        let mockedInteractor = sut.interactor as! MockeInteractor
        mockedInteractor.favorites = [1011334]
        sut.heroes = [hero]
        sut.unfavorite(hero)
        XCTAssertEqual(sut.favoritedHeroesIds.count, 0)
        XCTAssertEqual(mockedInteractor.favorites.count, 0)
        XCTAssertEqual(mockedInteractor.savedFavorites, 1)
    }

    // swiftlint:enable force_cast

}
