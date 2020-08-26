//
//  FullCoverageWebViewController.swift
//  NewsAPP
//
//  Created by Aashish on 8/26/20.
//  Copyright © 2020 aashish. All rights reserved.
//

import UIKit
import WebKit
import NVActivityIndicatorView
class FullCoverageWebViewController: UIViewController {
    @IBOutlet weak var contentView: UIView!
    var url: String?
    private var webView = WKWebView()
    var urlRequest: URLRequest?
    let activityData = ActivityData(size: CGSize(width: 50.0, height: 50.0), message: "Loading....", messageFont: UIFont(name: "Montserrat", size: 18), messageSpacing: 10.0, type: .ballSpinFadeLoader, color: .appColor, padding: 10.0, displayTimeThreshold: 8, minimumDisplayTime: 5, backgroundColor: .clear, textColor: .appColor)
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.uISetup()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupForWebiew()
        
    }
    override func viewDidAppear(_ animated: Bool) {
           super.viewDidAppear(animated)
           if let request = urlRequest {
               webView.load(request)
           }
       }
}
extension FullCoverageWebViewController {
    func uISetup(){
        self.title = Titles.FullCoverageWebViewControllerTitle.rawValue
    }
    func setupForWebiew() {
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(self.activityData)
        contentView.addSubview(webView)
        webView.uiDelegate = self
        webView.navigationDelegate = self
        webView.translatesAutoresizingMaskIntoConstraints = false
        let left = NSLayoutConstraint(item: webView, attribute: .leading, relatedBy: .equal, toItem: contentView, attribute: .leading, multiplier: 1.0, constant: 0.0)
        let right = NSLayoutConstraint(item: webView, attribute: .trailing, relatedBy: .equal, toItem: contentView, attribute: .trailing, multiplier: 1.0, constant: 0.0)
        let top = NSLayoutConstraint(item: webView, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1.0, constant: 0.0)
        let bottom = NSLayoutConstraint(item: webView, attribute: .bottom, relatedBy: .equal, toItem: contentView, attribute: .bottom, multiplier: 1.0, constant: 0.0)
        NSLayoutConstraint.activate([left, right, top, bottom])
        urlRequest = URLRequest(url: URL(string: url ?? "" )!)
    }
}
//Delegates For WebView
extension FullCoverageWebViewController: WKUIDelegate,WKNavigationDelegate {
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
    }
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(self.activityData)
    }
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
       NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
    }
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
    }
    
}
