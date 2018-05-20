//
//  HeroDetailPresenterTest.swift
//  MarvelHerosTests
//
//  Created by Alan Ostanik on 2018-05-20.
//  Copyright © 2018 Ostanik. All rights reserved.
//

import XCTest
@testable import MarvelHeros

class HeroDetailPresenterTest: XCTestCase {
    var sut: HeroDetailPresenter!

    enum AnyError: Error {
        case any
    }

    class MockInteractor: HeroDetailUseCase {
        var output: HeroDetailInteractorOutput?
        var shouldShowSuccess = true
        var results: Event!

        func fetchDetail(summary: Summary) {
            if shouldShowSuccess {
                self.output?.onSuccessFetch(results)
            } else {
                self.output?.onFailedFetch(AnyError.any)
            }
        }
    }
    
    override func setUp() {
        super.setUp()
    }

    private func setupMockedInteractor() -> MockInteractor {
        let mockedInteractor = MockInteractor()
        sut = HeroDetailPresenter(interactor: mockedInteractor)
        mockedInteractor.output = sut
        mockedInteractor.results = Event(id: 0, title: nil, description: nil, thumbnail: nil)
        return mockedInteractor
    }

    func testWhaitForAllCallsToUpdateViewWithoutRequestError() {
        guard let hero: Hero = self.loadObjectFromJSON(withFileNamed: "3DMan") else {
            XCTFail("Unable to load mocked character")
            return
        }
        _ = setupMockedInteractor()
        sut.hero = hero
        sut.fetchDetails()
        XCTAssertEqual(sut.totalFetchRequestsMade, 0)
    }

    func testWhaitForAllCallsToUpdateViewWithRequestError() {
        guard let hero: Hero = self.loadObjectFromJSON(withFileNamed: "3DMan") else {
            XCTFail("Unable to load mocked character")
            return
        }
        let mockedInteractor = setupMockedInteractor()
        mockedInteractor.shouldShowSuccess = false
        sut.hero = hero
        sut.fetchDetails()
        XCTAssertEqual(sut.totalFetchRequestsMade, 0)
    }

    func testResultsWithEmptyHeroData() {
        guard let hero: Hero = self.loadObjectFromJSON(withFileNamed: "EmptyHero") else {
            XCTFail("Unable to load mocked character")
            return
        }
        let mockedInteractor = setupMockedInteractor()
        mockedInteractor.shouldShowSuccess = false
        sut.hero = hero
        XCTAssertEqual(sut.totalFetchRequestsMade, 0)
    }
    
}
