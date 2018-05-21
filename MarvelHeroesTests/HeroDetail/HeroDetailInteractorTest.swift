//
//  HeroDetailInteractorTest.swift
//  MarvelHeroesTests
//
//  Created by Alan Ostanik on 2018-05-21.
//  Copyright © 2018 Ostanik. All rights reserved.
//

import XCTest
@testable import MarvelHeroes

class HeroDetailInteractorTest: XCTestCase {
    class MockedUserDefaults: UserDefaults {
        var favorite: [Int]!

        convenience init() {
            self.init(suiteName: "Mock User Defaults")!
            favorite = []
        }

        override init?(suiteName suitename: String?) {
            UserDefaults().removePersistentDomain(forName: suitename!)
            favorite = []
            super.init(suiteName: suitename)
        }

        override func object(forKey defaultName: String) -> Any? {
            return favorite
        }

        override func set(_ value: Any?, forKey defaultName: String) {
            guard let value = value as? [Int] else { return }
            favorite = value
        }

        override func synchronize() -> Bool {
            return true
        }
    }

    var sut: HeroDetailInteractor!
        
    override func setUp() {
        let mockedUserDefaults = MockedUserDefaults()
        sut = HeroDetailInteractor(userDefaults: mockedUserDefaults)
        super.setUp()
    }
    
    func testUpdateHeroAsFavoritWithoutRegisterOnDefaults() {
        guard var hero: Hero = self.loadObjectFromJSON(withFileNamed: "3DMan"), let mockedUserDefaults = sut.userDefaults as? MockedUserDefaults else {
            XCTFail("Unable to load hero json")
            return
        }
        hero.favorite = true
        sut.updateHero(hero: hero)
        XCTAssertEqual(mockedUserDefaults.favorite.first, hero.id)
    }

    func testUpdateHeroAsFavoritWithRegisterOnDefaults() {
        guard var hero: Hero = self.loadObjectFromJSON(withFileNamed: "3DMan"), let mockedUserDefaults = sut.userDefaults as? MockedUserDefaults else {
            XCTFail("Unable to load hero json")
            return
        }
        mockedUserDefaults.favorite = [0]
        hero.favorite = true
        sut.updateHero(hero: hero)
        XCTAssert(mockedUserDefaults.favorite.index(of: hero.id) != nil)
    }

    func testRemoveHeroFromFavoritWithRegisterOnDefaults() {
        guard var hero: Hero = self.loadObjectFromJSON(withFileNamed: "3DMan"), let mockedUserDefaults = sut.userDefaults as? MockedUserDefaults else {
            XCTFail("Unable to load hero json")
            return
        }
        mockedUserDefaults.favorite = [0, hero.id]
        hero.favorite = false
        sut.updateHero(hero: hero)
        XCTAssert(mockedUserDefaults.favorite.index(of: hero.id) == nil)
    }

    func testRemoveHeroFromFavoritWithoutRegisterOnDefaults() {
        guard var hero: Hero = self.loadObjectFromJSON(withFileNamed: "3DMan"), let mockedUserDefaults = sut.userDefaults as? MockedUserDefaults else {
            XCTFail("Unable to load hero json")
            return
        }
        hero.favorite = false
        sut.updateHero(hero: hero)
        XCTAssert(mockedUserDefaults.favorite.index(of: hero.id) == nil)
    }
    
}
