//
//  LunchNetworkService.swift
//  BR iOS Engineering Test
//
//  Created by Vladimir on 29.12.2019.
//  Copyright © 2019 Vladimir. All rights reserved.
//

import UIKit

class LunchNetworkService: BRNetworkProtocol {
    
    private let apiUrlString: String = "https://s3.amazonaws.com/br-codingexams/restaurants.json"
    
    private let imageCache = NSCache<NSString, UIImage>()
    
    func getRestaurants(completion: (([Restaurant]?, Error?) -> Void)?) {
        guard let url = URL(string: apiUrlString) else {
            completion?(nil, BRError.badURL)
            return
        }
        
        loadJsonData(url: url, returningClass: Response.self) { [weak self] response, error in
            guard var restaurants = response?.restaurants, error == nil else {
                completion?(response?.restaurants, error)
                return
            }
            DispatchQueue.global(qos: .userInitiated).async {
                let group = DispatchGroup()
                for index in restaurants.indices {
                    guard let urlString = restaurants[index].backgroundImageURL else {continue}
                    if let image = self?.imageCache.object(forKey: urlString as NSString) {
                        restaurants[index].backgroundImage = image
                        continue
                    }
                    group.enter()
                    self?.getImage(urlString: urlString) {  image in
                        guard let image = image else {
                            group.leave()
                            return
                        }
                        self?.imageCache.setObject(image, forKey: urlString as NSString)
                        restaurants[index].backgroundImage = image
                        group.leave()
                    }
                }
                group.wait()
                DispatchQueue.main.async {
                    completion?(restaurants, nil)
                }
            }
        }
    }
}
