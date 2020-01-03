//
//  LunchPresentorDelegate.swift
//  BR iOS Engineering Test
//
//  Created by Vladimir on 03.01.2020.
//  Copyright © 2020 Vladimir. All rights reserved.
//

import Foundation

protocol LunchPresentorDelegate: class {
    func dataFetchDidStarted()
    func dataFetchDidFinished()
    func dataDidUpdated()
    func errorDidOccurred(_ error: Error)
}
