//
//  RootRouter.swift
//  MarvelHeros
//
//  Created by Alan Ostanik on 2018-05-17.
//  Copyright © 2018 Ostanik. All rights reserved.
//

import Foundation
import UIKit

class RootRouter: RootWireframe {

    // MARK: Protocol methods

    func showMainView() {
        let viewController = HeroListRouter.setupModule()
        let navigationController = UINavigationController(rootViewController: viewController)
        presentView(navigationController)
    }

    // MARK: Private methods

    private func presentView(_ viewController: UIViewController) {
        guard let window = UIApplication.shared.delegate?.window! else { return }
        window.backgroundColor = UIColor.white
        window.makeKeyAndVisible()
        window.rootViewController = viewController
    }
}
