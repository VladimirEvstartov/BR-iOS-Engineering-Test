//
//  RestaurantDetailsViewController.swift
//  BR iOS Engineering Test
//
//  Created by Vladimir on 30.12.2019.
//  Copyright © 2019 Vladimir. All rights reserved.
//

import UIKit
import MapKit

class RestaurantDetailsViewController: BaseViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var twitterLabel: UILabel!
    
    var model: Restaurant?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func setupViews() {
        nameLabel.text = model?.name
        categoryLabel.text = model?.category
        phoneLabel.text = model?.contact?.formattedPhone
        let twitter = model?.contact?.twitter
        twitterLabel.text = twitter == nil  ? twitter : "@\(twitter!)"
        let address = model?.location?.formattedAddress?.joined(separator: "\n")
        addressLabel.text = address
        setupMapView()
    }
    
    private func setupMapView() {
        guard let lat = model?.location?.lat, let lng = model?.location?.lng else {return}
              
        let restaurantLocation = CLLocation(latitude: lat, longitude: lng)
        let regionRadius: CLLocationDistance = 1000
        let coordinateRegion = MKCoordinateRegion(center: restaurantLocation.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        let restaurant = RestaurantAnnotation(name: model?.name, category: model?.category, coordinate: restaurantLocation.coordinate)
        mapView.addAnnotation(restaurant)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        title = BRStrings.lunchTabBarTitle
        navigationItem.title = BRStrings.lunchTitle
    }
    
}
