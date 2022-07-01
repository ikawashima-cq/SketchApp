//
//  MapBoxViewController.swift
//  SketchApp
//
//  Created by Iichiro Kawashima on 2022/03/14.
//

import UIKit
import WebKit
class MapBoxViewController: UIViewController {

    private let webview = WKWebView()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(webview)
        webview.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            webview.topAnchor.constraint(equalTo: self.view.topAnchor),
            webview.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            webview.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            webview.rightAnchor.constraint(equalTo: self.view.rightAnchor),
        ])

        webview.load(URLRequest(url: URL.init(string: "http://192.168.1.58:8080/")!))
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)


    }
}
