//
//  HeroDetailRouter.swift
//  MarvelHeros
//
//  Created by Alan Ostanik on 2018-05-20.
//  Copyright © 2018 Ostanik. All rights reserved.
//

import Foundation
import UIKit

class HeroDetailRouter {

    weak var view: UIViewController?

    // MARK: Static methods

    static func setupModule(hero: Hero,
                            presenter: HeroDetailPresentation & HeroDetailInteractorOutput = HeroDetailPresenter(),
                            interactor: HeroDetailUseCase = HeroDetailInteractor()) -> HeroDetailViewController {
        let viewController = UIStoryboard.loadViewController() as HeroDetailViewController
        let router = HeroDetailRouter()

        viewController.presenter =  presenter

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor
        presenter.hero = hero

        router.view = viewController

        interactor.output = presenter

        return viewController
    }
}

extension HeroDetailRouter: HeroDetailWireframe {

}
