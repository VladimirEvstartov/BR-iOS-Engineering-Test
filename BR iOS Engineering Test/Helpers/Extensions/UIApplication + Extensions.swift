//
//  UIApplicationExtensions.swift
//  BR iOS Engineering Test
//
//  Created by Vladimir on 28.12.2019.
//  Copyright © 2019 Vladimir. All rights reserved.
//

import UIKit

extension UIApplication {
    
    var mainWindow: UIWindow? {
        return windows.first(where: { $0.isKeyWindow })
    }
}
