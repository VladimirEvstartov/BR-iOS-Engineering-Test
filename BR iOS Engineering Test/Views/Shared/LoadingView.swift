//
//  LoadingView.swift
//  BR iOS Engineering Test
//
//  Created by Vladimir on 30.12.2019.
//  Copyright © 2019 Vladimir. All rights reserved.
//

import UIKit

class LoadingView: UIView {

    private let spinner = UIActivityIndicatorView()
    
    var isLosding: Bool {
        return spinner.isAnimating
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.gray.withAlphaComponent(0.8)
        if #available(iOS 13.0, *) {
            spinner.style = .large
        } else {
            spinner.style = .gray
        }
        spinner.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(spinner)
        spinner.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
    func startSpinner() {
        spinner.startAnimating()
    }
    
    func stopSpinner() {
        spinner.stopAnimating()
        self.removeFromSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
