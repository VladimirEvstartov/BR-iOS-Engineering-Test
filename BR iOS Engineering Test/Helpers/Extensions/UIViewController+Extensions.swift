//
//  UIViewController  + Extensions.swift
//  BR iOS Engineering Test
//
//  Created by Vladimir on 03.01.2020.
//  Copyright © 2020 Vladimir. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func showError(_ errorText: String, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: BRStrings.errorTitle, message: errorText, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: BRStrings.labelOk, style: UIAlertAction.Style.default, handler: {_ in completion?()}))
        self.present(alert, animated: true, completion: nil)
    }
}
