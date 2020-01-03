//
//  LocationView.swift
//  BR iOS Engineering Test
//
//  Created by Vladimir on 02.01.2020.
//  Copyright © 2020 Vladimir. All rights reserved.
//

import MapKit

class LocationView: MKMarkerAnnotationView {

    override var annotation: MKAnnotation? {
        willSet {
            guard newValue as? CLLocation != nil else {return}
            displayPriority = .required
        }
    }    
}
