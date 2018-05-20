//
//  HeroDetailInteractor.swift
//  MarvelHeros
//
//  Created by Alan Ostanik on 2018-05-20.
//  Copyright © 2018 Ostanik. All rights reserved.
//

import Foundation

class HeroDetailInteractor: HeroDetailUseCase {
    typealias Providers = (comicProvider: ComicProvider, eventProvider: EventProvider, seriesProvider: SeriesProvider, storyProvider: StoryProvider)
    weak var output: HeroDetailInteractorOutput?
    var providers: Providers

    init(providers: Providers = (ComicDatraProvider(), EventDataProvider(), SeriesDataProvider(), StoryDataProvider())) {
        self.providers = providers
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
