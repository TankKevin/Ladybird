//
//  WebViewController.swift
//  Ladybird
//
//  Created by 谭凯文 on 2018/4/12.
//  Copyright © 2018年 Tan Kevin. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    @IBOutlet var webView: WKWebView!
    override func viewDidLoad() {
        let url = URL(string: "https://github.com/TankKevin")!
        let request = URLRequest(url: url)
        webView.load(request)
    }
}
