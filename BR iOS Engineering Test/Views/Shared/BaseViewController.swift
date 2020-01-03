//
//  BaseViewController.swift
//  BR iOS Engineering Test
//
//  Created by Vladimir on 29.12.2019.
//  Copyright © 2019 Vladimir. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    let loadingView = LoadingView(frame: .zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
    }
    
    func setupNavigationBar() {
        if let mapButton = (navigationController as? BRNavigationController)?.mapButton {
            navigationItem.rightBarButtonItem = mapButton
        }
    }
}
