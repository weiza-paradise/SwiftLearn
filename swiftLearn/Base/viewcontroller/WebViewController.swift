//
//  WebViewController.swift
//  swiftLearn
//
//  Created by wei on 2021/2/8.
//

//  https://developer.apple.com/documentation/webkit/viewing_desktop_or_mobile_web_content_using_a_web_view#overview

import UIKit
import WebKit

class WebViewController: BaseViewController {
    
    @IBOutlet fileprivate weak var webView: WKWebView!
    @IBOutlet fileprivate weak var forwardButton: UIButton!
    @IBOutlet fileprivate weak var backButton: UIButton!
    @IBOutlet fileprivate weak var refreshButton: UIButton!
    @IBOutlet fileprivate weak var closeButton: UIButton!
    @IBOutlet fileprivate weak var progressBar: UIView!
    @IBOutlet fileprivate weak var progressBarWidthConstraint: NSLayoutConstraint!
    @IBOutlet fileprivate weak var titleLabel: UILabel!
    
    fileprivate var estimatedProgressObservationToken: NSKeyValueObservation?
    fileprivate var canGoBackObservationToken: NSKeyValueObservation?
    fileprivate var canGoForwardObservationToken: NSKeyValueObservation?
    
    open var startUrl: String = ""
    open var titleStr: String = ""

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        titleLabel.text = titleStr
        let urlRequest = URLRequest(url:  URL(string: startUrl)!)
        webView.load(urlRequest)
        setUpObservation()
    }
    
    override func configUI() {
        webView.navigationDelegate = self
        webView.translatesAutoresizingMaskIntoConstraints = false
    }
    
}


extension WebViewController {
    
    @IBAction func reload() {
        webView.reload()
    }
    
    @IBAction func goBack(_ sender: Any) {
        webView.goBack()
    }
    
    @IBAction func goForward(_ sender: Any) {
        webView.goForward()
    }
    
    @IBAction func closeVC(_ sender: Any) {
        navigationController?.popViewController()
    }
    
    fileprivate func setUpObservation() {
        estimatedProgressObservationToken = webView.observe(\.estimatedProgress) { (object, change) in
            let estimatedProgress = self.webView.estimatedProgress
            self.progressBarWidthConstraint.constant = CGFloat(estimatedProgress) * (self.view.bounds.width)
            self.progressBar.alpha = 1
            if estimatedProgress >= 1 {
                UIView.animate(withDuration: 0.5, animations: {
                    self.progressBar.alpha = 0
                }, completion: { (finished) in
                    self.progressBarWidthConstraint.constant = 0
                })
            }
        }
        
        canGoBackObservationToken = webView.observe(\.canGoBack) { (object, change) in
            self.backButton.isEnabled = self.webView.canGoBack
        }
        
        canGoForwardObservationToken = webView.observe(\.canGoForward) { (object, change) in
            self.forwardButton.isEnabled = self.webView.canGoForward
        }
    }
    
}


extension WebViewController: WKUIDelegate,WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "确定", style: .default, handler: { (action) in
            completionHandler()
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Void) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "确定", style: .default, handler: { (action) in
            completionHandler(true)
        }))
        alert.addAction(UIAlertAction(title: "取消", style: .default, handler: { (action) in
            completionHandler(false)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func webView(_ webView: WKWebView, runJavaScriptTextInputPanelWithPrompt prompt: String, defaultText: String?, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (String?) -> Void) {
        let alert = UIAlertController(title: nil, message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "确定", style: .default, handler: { (action) in
            completionHandler(alert.textFields?.last?.text)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        print("didCommit")
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("didStartProvisionalNavigation")
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("didFinish")
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        decisionHandler( .allow)
    }
    
}
