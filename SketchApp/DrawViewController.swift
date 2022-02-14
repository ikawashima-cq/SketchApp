//
//  ViewController.swift
//  SketchApp
//
//  Created by Iichiro Kawashima on 2022/02/12.
//

import UIKit

class DrawViewController: UIViewController {

    var canvasView: SketchView!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.canvasView = SketchView(frame: self.view.bounds)
        self.view.addSubview(canvasView!)
        let title = UILabel()
        title.frame = CGRect(x: 0, y: 20, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height / 8)
        title.textAlignment = .center
        title.text = "Let's draw using UIImage"
        title.textColor = UIColor.black
        self.view.addSubview(title)
    }
}

