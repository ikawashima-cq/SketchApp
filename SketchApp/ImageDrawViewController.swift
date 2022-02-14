//
//  ImageDrawViewController.swift
//  SketchApp
//
//  Created by Iichiro Kawashima on 2022/02/12.
//


import UIKit

class ImageDrawViewController: UIViewController {

    var drawView: DrawView!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.drawView = DrawView(frame: self.view.bounds)
        drawView.image = UIImage(systemName: "swift")
        self.view.addSubview(drawView!)
        let title = UILabel()
        title.frame = CGRect(x: 0, y: 20, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height / 8)
        title.textAlignment = .center
        title.text = "Let's draw using UIImageView"
        title.textColor = UIColor.black
        self.view.addSubview(title)
    }
}

