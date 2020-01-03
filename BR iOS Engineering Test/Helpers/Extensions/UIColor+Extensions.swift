//
//  UIColor+Extensions.swift
//  BR iOS Engineering Test
//
//  Created by Vladimir on 28.12.2019.
//  Copyright © 2019 Vladimir. All rights reserved.
//

import UIKit

extension UIColor {
    
    public convenience init?(hex: String, alpha: CGFloat = 1.0) {
        let r, g, b: CGFloat
        let expectedHexColorStringLenhth = 7

        guard hex.hasPrefix("#"), hex.count == expectedHexColorStringLenhth else {return nil}
        
        let start = hex.index(hex.startIndex, offsetBy: 1)
        let hexColor = String(hex[start...])
        let scanner = Scanner(string: hexColor)
        var hexNumber: UInt64 = 0

        guard scanner.scanHexInt64(&hexNumber) else {return nil}
        
        r = CGFloat((hexNumber & 0xff0000) >> 16) / 255
        g = CGFloat((hexNumber & 0x00ff00) >> 8) / 255
        b = CGFloat(hexNumber & 0x0000ff) / 255

        self.init(red: r, green: g, blue: b, alpha: alpha)
    }
}
