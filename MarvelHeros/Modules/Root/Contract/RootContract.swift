//
//  RootContract.swift
//  MarvelHeros
//
//  Created by Alan Ostanik on 2018-05-17.
//  Copyright © 2018 Ostanik. All rights reserved. d
//

import Foundation

protocol RootPresentation: class {
    func onAppDidLoad()
}

protocol RootWireframe: class {
    func showMainView()
}
