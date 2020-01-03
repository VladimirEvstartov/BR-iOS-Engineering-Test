//
//  LunchPresenter.swift
//  BR iOS Engineering Test
//
//  Created by Vladimir on 29.12.2019.
//  Copyright © 2019 Vladimir. All rights reserved.
//

import Foundation

class LunchPresenter {

    weak var delegate: LunchPresentorDelegate?
    private let networkSevice: LunchNetworkService = LunchNetworkService()
    private var restaurants: [Restaurant] = [Restaurant]()
    
    func updateRestaurants() {
        delegate?.dataFetchDidStarted()
        networkSevice.getRestaurants { [weak self] restaurants, error in
            self?.delegate?.dataFetchDidFinished()
            if let data = restaurants {
                self?.restaurants = data
                self?.delegate?.dataDidUpdated()
            }

            if let error = error {
                self?.delegate?.errorDidOccurred(error)
            }
        }
    }
    
    func numberOfRestaurants(section: Int) -> Int {
        return section == 0 ? restaurants.count : 0
    }
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func modelForCellAt(section: Int, row: Int) -> Restaurant? {
        guard section == 0, restaurants.indices.contains(row) else {return nil}
        return restaurants[row]
    }
}

// MARK: RestaurantMapDataSource
extension LunchPresenter: RestaurantMapDataSource {
    
    var restaurantsAnnotatios: [RestaurantAnnotation] {
        return restaurants.filter({$0.location?.lat != nil && $0.location?.lng != nil}).map({ restaraunt -> RestaurantAnnotation in
            return RestaurantAnnotation(name: restaraunt.name, category: restaraunt.category, lat: restaraunt.location?.lat ?? 0.0, lgn: restaraunt.location?.lng ?? 0.0)
        })
    }
}
