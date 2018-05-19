//
//  HeroList.swift
//  MarvelHeros
//
//  Created by Alan Ostanik on 2018-05-17.
//  Copyright © 2018 Ostanik. All rights reserved.
//

import Foundation
import UIKit

class HeroListRouter: HeroListWireframe {

    weak var view: UIViewController?

    // MARK: Static methods

    static func setupModule(presenter: HeroListPresentation & HeroListInteractorOutput = HeroListPresenter(),
                            interactor: HeroListUseCase = HeroListInteractor()) -> HeroListViewController {
        let viewController = UIStoryboard.loadViewController() as HeroListViewController
        let router = HeroListRouter()

        viewController.presenter =  presenter

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor

        router.view = viewController

        interactor.output = presenter

        return viewController
    }

}
