//
//  HeroDetailPresenterTest.swift
//  MarvelHeroesTests
//
//  Created by Alan Ostanik on 2018-05-20.
//  Copyright © 2018 Ostanik. All rights reserved.
//

import XCTest
@testable import MarvelHeroes

class HeroDetailPresenterTest: XCTestCase {
    var sut: HeroDetailPresenter!

    class MockInteractor: HeroDetailUseCase {
        var output: HeroDetailInteractorOutput?
        var shouldShowSuccess = true
        var results: Event!
        func fetchDetail(summary: Summary) {
            if shouldShowSuccess {
                self.output?.onSuccessFetch(results)
            } else {
                self.output?.onFailedFetch(XCTestCase.AnyError.any)
            }
        }

        func updateHero(hero: Hero) { }
    }
    
    override func setUp() {
        super.setUp()
        let mockedInteractor = MockInteractor()
        sut = HeroDetailPresenter(interactor: mockedInteractor)
        mockedInteractor.output = sut
        mockedInteractor.results = Event(id: 0, title: nil, description: nil, thumbnail: nil)
    }

    func testWhaitForAllCallsToUpdateViewWithoutRequestError() {
        guard let hero: Hero = self.loadObjectFromJSON(withFileNamed: "3DMan") else {
            XCTFail("Unable to load mocked character")
            return
        }
        sut.hero = hero
        sut.fetchDetails()
        XCTAssertEqual(sut.totalFetchMade, 0)
    }

    func testWhaitForAllCallsToUpdateViewWithRequestError() {
        guard let hero: Hero = self.loadObjectFromJSON(withFileNamed: "3DMan"),
              let mockedInteractor = sut.interactor as? MockInteractor else {
            XCTFail("Unable to load mocked character")
            return
        }
        mockedInteractor.shouldShowSuccess = false
        sut.hero = hero
        sut.fetchDetails()
        XCTAssertEqual(sut.totalFetchMade, 0)
    }

    func testResultsWithEmptyHeroData() {
        guard let hero: Hero = self.loadObjectFromJSON(withFileNamed: "EmptyHero") ,
            let mockedInteractor = sut.interactor as? MockInteractor else {
            XCTFail("Unable to load mocked character")
            return
        }
        mockedInteractor.shouldShowSuccess = false
        sut.hero = hero
        XCTAssertEqual(sut.totalFetchMade, 0)
    }
    
}
