//
//  ViewController.swift
//  AnalysisTest
//
//  Created by Ami Intwala on 21/03/20.
//

import UIKit
import WebKit

class AdsVC: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadRequest()
        // Do any additional setup after loading the view.
    }

    fileprivate func loadRequest() {
        if let url = URL(string: API.tokenURL + token) {
            webView.load(URLRequest(url: url))
        }
    }
}

