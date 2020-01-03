//
//  LunchCollectionViewCell.swift
//  BR iOS Engineering Test
//
//  Created by Vladimir on 30.12.2019.
//  Copyright © 2019 Vladimir. All rights reserved.
//

import UIKit

class LunchCollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var restarauntLogo: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var categotyLabel: UILabel!
    
    var model: Restaurant? {
        didSet {
            restarauntLogo.image = model?.backgroundImage
            nameLabel.text = model?.name
            categotyLabel.text = model?.category
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
