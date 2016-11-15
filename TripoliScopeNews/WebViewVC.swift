//
//  WebViewVC.swift
//  TripoliScopeNews
//
//  Created by Ghas San on 11/15/16.
//  Copyright © 2016 Ghassan Jaam. All rights reserved.
//

import UIKit

class WebViewVC: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    
    var url: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.loadRequest(URLRequest(url: URL(string: url!)!))

    }



}
