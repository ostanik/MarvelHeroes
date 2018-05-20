//
//  HeroDetailPresenter.swift
//  MarvelHeros
//
//  Created by Alan Ostanik on 2018-05-20.
//  Copyright © 2018 Ostanik. All rights reserved.
//

import Foundation

class HeroDetailPresenter {

    weak var view: HeroDetailView?
    var router: HeroDetailWireframe?
    var interactor: HeroDetailUseCase?
    var hero: Hero!
    private var totalFetchMade = 0
    private var didFetchAllDetails: Bool {
        return totalFetchMade == 0
    }

    var totalFetchRequestsMade: Int {
        return totalFetchMade
    }

    var totalItensToFetch: Int {
        return summaryCollection(hero: hero).map({ $0.count }).reduce(0, +)
    }

    init(view: HeroDetailView = HeroDetailViewController(),
         router: HeroDetailWireframe = HeroDetailRouter(),
         interactor: HeroDetailUseCase = HeroDetailInteractor()) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension HeroDetailPresenter: HeroDetailPresentation {
    func onViewDidLoad() {
        view?.setupPageTitle(hero.name ?? "")
        fetchDetails()
    }

    func fetchDetails() {
        if totalItensToFetch != 0 {
            summaryCollection(hero: hero).forEach {
                $0.prefix(3).forEach(performFetch())
            }
        } else {
            view?.updateScreenWith(hero)
        }
    }

    fileprivate func summaryCollection(hero: Hero) -> [[Summary]] {
        return [hero.comics?.items ?? [], hero.events?.items ?? [], hero.series?.items ?? [], hero.stories?.items ?? []]
    }

    fileprivate func performFetch() -> (Summary) -> Void {
        return {
            self.totalFetchMade += 1
            self.interactor?.fetchDetail(summary: $0)
        }
    }
}

extension HeroDetailPresenter: HeroDetailInteractorOutput {
    func onFailedFetch(_ error: Error) {
        totalFetchMade -= 1
        if didFetchAllDetails {
            view?.updateScreenWith(hero)
        }
    }

    func onSuccessFetch<T: Codable>(_ result: T) {
        // swiftlint:disable force_cast
        switch result.self {
        case is Comic:
            hero.detailedComics.append(result as! Comic)
        case is Event:
            hero.detailedEvents.append(result as! Event)
        case is Series:
            hero.detailedSeries.append(result as! Series)
        case is Story:
            hero.detailedStories.append(result as! Story)
        default: return
        }
        // swiftlint:enable force_cast
        totalFetchMade -= 1
        if didFetchAllDetails {
            view?.updateScreenWith(hero)
        }
    }
}
