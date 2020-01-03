//
//  BRNavigationController.swift
//  BR iOS Engineering Test
//
//  Created by Vladimir on 29.12.2019.
//  Copyright © 2019 Vladimir. All rights reserved.
//

import UIKit

class BRNavigationController: UINavigationController {
    
    var mapButton: UIBarButtonItem?
    var mapDataSorce: RestaurantMapDataSource?

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateMapButtonStatus()
        self.setNeedsStatusBarAppearanceUpdate()
    }
    
    private func configureNavBar() {
        let textAttributes = [
            NSAttributedString.Key.foregroundColor: BRUIConstants.navBarTextColor,
            NSAttributedString.Key.font: BRUIConstants.navBarFont]
        
        navigationBar.titleTextAttributes = textAttributes as [NSAttributedString.Key: Any]
        let BarButtonItemAppearance = UIBarButtonItem.appearance()
        BarButtonItemAppearance.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.clear], for: .normal)
       
        let image = UIImage(named: "icon_map")?.withRenderingMode(.alwaysTemplate)
        mapButton = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(presentRestauntMap))
        mapButton?.tintColor = BRUIConstants.navBarTextColor

        navigationBar.barTintColor = BRUIConstants.navBarTintColor
        navigationBar.tintColor = BRUIConstants.navBarTextColor
    }
    
    @objc private func presentRestauntMap() {
        let mapVC = RestaurantMapViewController()
        mapVC.dataSource = mapDataSorce
        topViewController?.present(mapVC, animated: true, completion: nil)
    }
    
    func updateMapButtonStatus() {
         mapButton?.isEnabled = !(mapDataSorce?.restaurantsAnnotatios.isEmpty ?? true)
    }
}
