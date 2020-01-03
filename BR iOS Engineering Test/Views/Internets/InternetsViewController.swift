//
//  InternetsViewController.swift
//  BR iOS Engineering Test
//
//  Created by Vladimir on 28.12.2019.
//  Copyright © 2019 Vladimir. All rights reserved.
//

import WebKit

class InternetsViewController: UIViewController {
    
    var webWiew: WKWebView!
    let url = URL(string: "https://www.bottlerocketstudios.com")

    override func viewDidLoad() {
        super.viewDidLoad()
        setupWebView()
        setupNavigation()
    }
    
    private func setupWebView() {
        let configuration = WKWebViewConfiguration()
        configuration.allowsInlineMediaPlayback = true
        webWiew = WKWebView(frame: .zero, configuration: configuration)
        webWiew.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(webWiew)
        
        webWiew.leftAnchor.constraint(equalTo: view.safeLeftAnchor).isActive = true
        webWiew.rightAnchor.constraint(equalTo: view.safeRightAnchor).isActive = true
        webWiew.topAnchor.constraint(equalTo: view.safeTopAnchor).isActive = true
        webWiew.bottomAnchor.constraint(equalTo: view.safeBottomAnchor).isActive = true
        webWiew.allowsBackForwardNavigationGestures = true
        
        guard let url = url else {return}
        webWiew.load(URLRequest(url: url))
    }
    
    private func setupNavigation() {
        let backButtonImage = UIImage(named: "ic_webBack")?.withRenderingMode(.alwaysTemplate)
        let forwardButtonImage = UIImage(named: "ic_webForward")?.withRenderingMode(.alwaysTemplate)
        let refreshButtonImage = UIImage(named: "ic_webRefresh")?.withRenderingMode(.alwaysTemplate)
        var buttonItems = [UIBarButtonItem]()
        buttonItems.append(UIBarButtonItem(image: backButtonImage, style: .plain, target: self, action: #selector(backButtonPressd)))
        buttonItems.append(UIBarButtonItem(image: refreshButtonImage, style: .plain, target: self, action: #selector(refreshButtonPressd)))
        buttonItems.append(UIBarButtonItem(image: forwardButtonImage, style: .plain, target: self, action: #selector(forwardButtonPressd)))
        
        navigationItem.leftBarButtonItems = buttonItems
    }
    
    @objc private func backButtonPressd() {
        if webWiew.canGoBack {
            webWiew.goBack()
        }
    }
    
    @objc private func forwardButtonPressd() {
        if webWiew.canGoForward {
            webWiew.goForward()
        }
    }
    
    @objc private func refreshButtonPressd() {
        webWiew.reload()
    }
}
