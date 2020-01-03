//
//  EdgeInsetLabel.swift
//  BR iOS Engineering Test
//
//  Created by Vladimir on 30.12.2019.
//  Copyright © 2019 Vladimir. All rights reserved.
//

import UIKit

class EdgeInsetLabel: UILabel {

    var edgeInsets: UIEdgeInsets = UIEdgeInsets.zero

    override func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
        var rect = super.textRect(forBounds: bounds.inset(by: edgeInsets), limitedToNumberOfLines: numberOfLines)

        rect.origin.x -= edgeInsets.left
        rect.origin.y -= edgeInsets.top
        rect.size.width  += (edgeInsets.left + edgeInsets.right)
        rect.size.height += (edgeInsets.top + edgeInsets.bottom)

        return rect
    }

    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: edgeInsets))
    }
}
