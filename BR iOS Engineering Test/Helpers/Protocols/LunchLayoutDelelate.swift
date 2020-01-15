//
//  LunchLayoutDelelate.swift
//  BR iOS Engineering Test
//
//  Created by Vladimir on 03.01.2020.
//  Copyright © 2020 Vladimir. All rights reserved.
//

import UIKit

protocol LunchLayoutDelelate: class {
    var numberOfColumns: Int {get}
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAt indexPath: IndexPath) -> CGFloat
}
