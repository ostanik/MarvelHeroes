//
//  HeroDetailContract.swift
//  MarvelHeros
//
//  Created by Alan Ostanik on 2018-05-20.
//  Copyright © 2018 Ostanik. All rights reserved. d
//

import Foundation

protocol HeroDetailView: class {
    var presenter: HeroDetailPresentation? {get set}

    func setupPageTitle(_ string: String)
    func updateScreenWith(_ hero: Hero)
}

protocol HeroDetailPresentation: class {
    var view: HeroDetailView? {get set}
    var router: HeroDetailWireframe? {get set}
    var interactor: HeroDetailUseCase? {get set}
    var hero: Hero! {get set}

    func onViewDidLoad()
    func fetchDetails()
}

protocol HeroDetailUseCase: class {
    var output: HeroDetailInteractorOutput? {get set}

    func fetchDetail(summary: Summary)
}

protocol HeroDetailInteractorOutput: class {
    func onSuccessFetch<T: Codable>(_ result: T)
    func onFailedFetch(_ error: Error)
}

protocol HeroDetailWireframe: class {}
