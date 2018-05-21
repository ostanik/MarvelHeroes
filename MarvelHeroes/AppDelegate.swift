//
//  AppDelegate.swift
//  MarvelHeroes
//
//  Created by Alan Ostanik on 2018-05-17.
//  Copyright © 2018 Ostanik. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var rootPresenter: RootPresenter!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        presentInitialScreen()
        return true
    }

    private func presentInitialScreen() {
        rootPresenter = RootPresenter()
        rootPresenter.onAppDidLoad()
    }

}
