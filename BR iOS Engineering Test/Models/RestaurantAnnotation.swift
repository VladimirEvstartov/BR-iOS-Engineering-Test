//
//  RestaurantAnnotation.swift
//  BR iOS Engineering Test
//
//  Created by Vladimir on 30.12.2019.
//  Copyright © 2019 Vladimir. All rights reserved.
//

import MapKit

class RestaurantAnnotation: NSObject, MKAnnotation {
    let name: String?
    let category: String?
    let coordinate: CLLocationCoordinate2D
    var title: String? {
        return name
    }

    var subtitle: String? {
        return category
    }

    init(name: String?, category: String?, coordinate: CLLocationCoordinate2D) {
        self.name = name
        self.category = category
        self.coordinate = coordinate
        super.init()
    }
    
    init(name: String?, category: String?, lat: Double, lgn: Double) {
        self.name = name
        self.category = category
        self.coordinate = CLLocation(latitude: lat, longitude: lgn).coordinate
        super.init()
    }
}
