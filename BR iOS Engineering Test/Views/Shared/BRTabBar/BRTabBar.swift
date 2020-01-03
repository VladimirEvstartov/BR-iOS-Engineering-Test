//
//  BRTabBar.swift
//  BR iOS Engineering Test
//
//  Created by Vladimir on 28.12.2019.
//  Copyright © 2019 Vladimir. All rights reserved.
//

import UIKit

class BRTabBar: UITabBar {

    var height: CGFloat = BRUIConstants.tabBarHeight

    override open func sizeThatFits(_ size: CGSize) -> CGSize {
        guard let window =  UIApplication.shared.mainWindow else {
            return super.sizeThatFits(size)
        }
        
        var sizeThatFits = super.sizeThatFits(size)

        if #available(iOS 11.0, *) {
            sizeThatFits.height = height + window.safeAreaInsets.bottom
        } else {
            sizeThatFits.height = height
        }
 
        return sizeThatFits
    }
}
