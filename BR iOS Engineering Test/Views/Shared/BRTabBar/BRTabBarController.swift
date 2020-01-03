//
//  BRTabBarController.swift
//  BR iOS Engineering Test
//
//  Created by Vladimir on 28.12.2019.
//  Copyright © 2019 Vladimir. All rights reserved.
//

import UIKit

class BRTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabBar()
    }
    
    private func configureTabBar() {
        tabBar.barTintColor = BRUIConstants.tabBarTintColor
        tabBar.tintColor = BRUIConstants.tabBarSelectedItemColor
        tabBar.unselectedItemTintColor = BRUIConstants.tabBarUnselectedItemColor
        let fontAttributes = [NSAttributedString.Key.font: BRUIConstants.tabBarItemFont]
        UITabBarItem.appearance().setTitleTextAttributes(fontAttributes as [NSAttributedString.Key: Any], for: .normal)
    }
}
