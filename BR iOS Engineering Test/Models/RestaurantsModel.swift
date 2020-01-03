//
//  RestaurantsModel.swift
//  BR iOS Engineering Test
//
//  Created by Vladimir on 29.12.2019.
//  Copyright © 2019 Vladimir. All rights reserved.
//

import UIKit

struct Restaurant: Codable {
    let name: String?
    let backgroundImageURL: String?
    let category: String?
    let location: RestourantLocation?
    let contact: RestourantContact?
    var backgroundImage: UIImage?
    
    enum CodingKeys: String, CodingKey {
        case name
        case backgroundImageURL
        case category
        case location
        case contact
    }
}

struct Response: Codable {
    let restaurants: [Restaurant]?
}

struct RestourantLocation: Codable {
    let address: String?
    let crossStreet: String?
    let lat: Double?
    let lng: Double?
    let postalCode: String?
    let cc: String?
    let city: String?
    let state: String?
    let country: String?
    let formattedAddress: [String]?
}

struct RestourantContact: Codable {
    let phone: String?
    let formattedPhone: String?
    let twitter: String?
}
