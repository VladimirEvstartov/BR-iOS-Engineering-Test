//
//  RetaurantMapViewController.swift
//  BR iOS Engineering Test
//
//  Created by Vladimir on 30.12.2019.
//  Copyright © 2019 Vladimir. All rights reserved.
//

import MapKit

protocol RestaurantMapDataSource: class {
    var restaurantsAnnotatios: [RestaurantAnnotation] {get}
}

class RestaurantMapViewController: UIViewController {

    var mapView: MKMapView!
    let closeButton = UIButton(frame: .zero)
    weak var dataSource: RestaurantMapDataSource?
    
    override func loadView() {
        mapView = MKMapView()
        view = mapView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        addRestautantPins()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        mapView.bringSubviewToFront(closeButton)
    }
    
    private func setupViews() {
        mapView.delegate = self
        mapView.register(LocationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        closeButton.setImage(UIImage(named: "ic_close"), for: .normal)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.addTarget(self, action: #selector(closeButtonPressed), for: .touchUpInside)
        view.addSubview(closeButton)
        closeButton.topAnchor.constraint(equalTo: mapView.topAnchor, constant: 16).isActive = true
        closeButton.trailingAnchor.constraint(equalTo: mapView.trailingAnchor, constant: -16).isActive = true
        view.bringSubviewToFront(closeButton)
    }
    
    private func addRestautantPins() {
        guard let reataurants = dataSource?.restaurantsAnnotatios else {return}
        var annotations = [RestaurantAnnotation]()
        for restaurant in reataurants {
            let annotation = RestaurantAnnotation(name: restaurant.name, category: restaurant.category, coordinate: restaurant.coordinate)
            annotations.append(annotation)
        }
        mapView.addAnnotations(annotations)
        mapView.showAnnotations(annotations, animated: false)
    }
    
    @objc private func closeButtonPressed() {
        dismiss(animated: true, completion: nil)
    }
}

// MARK: MKMapViewDelegate
extension RestaurantMapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let view: MKAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier, for: annotation)
        view.annotation = annotation
        view.displayPriority = .required
        return view
    }
}
