//
//  HeroDetailInteractor.swift
//  MarvelHeroes
//
//  Created by Alan Ostanik on 2018-05-20.
//  Copyright © 2018 Ostanik. All rights reserved.
//

import Foundation

class HeroDetailInteractor: HeroDetailUseCase {
    typealias Providers = (comicProvider: ComicProvider, eventProvider: EventProvider, seriesProvider: SeriesProvider, storyProvider: StoryProvider)

    weak var output: HeroDetailInteractorOutput?
    var providers: Providers
    var userDefaults: UserDefaults
    private let favoritesKey = "Favorites"

    init(providers: Providers = (ComicDatraProvider(), EventDataProvider(), SeriesDataProvider(), StoryDataProvider()), userDefaults: UserDefaults = UserDefaults.standard) {
        self.providers = providers
        self.userDefaults = userDefaults
    }

    // MARK: HeroDetailUseCase protocol methods

    func fetchDetail(summary: Summary) {
        guard let resource = summary.resourceURI else { return }
        switch summary.self {
        case is ComicSummary:
            providers.comicProvider.fetchDetail(detailPage: resource, completionHandler: fetchCallback())
        case is EventSummary:
            providers.eventProvider.fetchDetail(detailPage: resource, completionHandler: fetchCallback())
        case is SeriesSummary:
            providers.seriesProvider.fetchDetail(detailPage: resource, completionHandler: fetchCallback())
        case is StorySummary:
            providers.storyProvider.fetchDetail(detailPage: resource, completionHandler: fetchCallback())
        default: return
        }
    }

    func updateHero(hero: Hero) {
        var heroIds = [Int]()
        if let defaultIds = userDefaults.object(forKey: favoritesKey) as? [Int] {
            heroIds = findeHeroAndUpdate(defaultIds, hero)
        } else if hero.favorite {
            heroIds.append(hero.id)
        }
        saveFavorites(heroesIds: heroIds)
    }

    private func findeHeroAndUpdate(_ heroesIds: [Int], _ hero: Hero) -> [Int] {
        var newFavoriteHeroes = heroesIds
        if let index = newFavoriteHeroes.index(of: hero.id) {
            if !hero.favorite {
                newFavoriteHeroes.remove(at: index)
            }
        } else if hero.favorite {
            newFavoriteHeroes.append(hero.id)
        }
        return newFavoriteHeroes
    }

    private func saveFavorites(heroesIds: [Int]) {
        userDefaults.set(heroesIds, forKey: favoritesKey)
        userDefaults.synchronize()
    }

    private func fetchCallback<T: Codable>() -> (DataContainer<T>?, Error?) -> Void {
        return { [weak self] (dataContainer, error) in
            guard error == nil, dataContainer != nil, let result = dataContainer?.results.first else {
                self?.output?.onFailedFetch(error!)
                return
            }
            self?.output?.onSuccessFetch(result)
        }
    }
}
