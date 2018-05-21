//
//  RootPresenter.swift
//  MarvelHeroes
//
//  Created by Alan Ostanik on 2018-05-17.
//  Copyright © 2018 Ostanik. All rights reserved.
//

import Foundation

class RootPresenter: RootPresentation {
    var router: RootWireframe?

    init(router: RootWireframe = RootRouter()) {
        self.router = router
    }

    // MARK: Protocol methods

    func onAppDidLoad() {
        router?.showMainView()
    }
}
