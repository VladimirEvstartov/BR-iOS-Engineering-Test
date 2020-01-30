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
    private var backButton: UIBarButtonItem!
    private var refreshButton: UIBarButtonItem!
    private var forwardButton: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupWebView()
        setupNavigation()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        updateNavButtons()
    }
    
    private func setupWebView() {
        let configuration = WKWebViewConfiguration()
        configuration.allowsInlineMediaPlayback = true
        webWiew = WKWebView(frame: .zero, configuration: configuration)
        webWiew.translatesAutoresizingMaskIntoConstraints = false
        webWiew.navigationDelegate = self
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
        var buttonItems = [UIBarButtonItem]()
        let backButtonImage = UIImage(named: "ic_webBack")?.withRenderingMode(.alwaysTemplate)
        let forwardButtonImage = UIImage(named: "ic_webForward")?.withRenderingMode(.alwaysTemplate)
        let refreshButtonImage = UIImage(named: "ic_webRefresh")?.withRenderingMode(.alwaysTemplate)
        backButton = UIBarButtonItem(image: backButtonImage, style: .plain, target: self, action: #selector(backButtonPressd))
        buttonItems.append(backButton)
        refreshButton = UIBarButtonItem(image: refreshButtonImage, style: .plain, target: self, action: #selector(refreshButtonPressd))
        buttonItems.append(refreshButton)
        refreshButton.isEnabled = false
        forwardButton = UIBarButtonItem(image: forwardButtonImage, style: .plain, target: self, action: #selector(forwardButtonPressd))
        buttonItems.append(forwardButton)
        
        navigationItem.leftBarButtonItems = buttonItems
    }
    
    fileprivate func updateNavButtons() {
        backButton.isEnabled = webWiew.canGoBack
        forwardButton.isEnabled = webWiew.canGoForward
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

extension InternetsViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        refreshButton.isEnabled = true
        updateNavButtons()
    }
}
