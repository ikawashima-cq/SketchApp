//
//  PencilViewController.swift
//  SketchApp
//
//  Created by Iichiro Kawashima on 2022/02/12.
//

import UIKit
import PencilKit

class PencilViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let canvas = PKCanvasView(frame: view.frame)
        view.addSubview(canvas)
        canvas.tool = PKInkingTool(.pen, color: .black, width: 30)
        canvas.drawingPolicy = .anyInput

        if let _ = UIApplication.shared.windows.first {
            let toolPicker = PKToolPicker()
            toolPicker.addObserver(canvas)
            toolPicker.setVisible(true, forFirstResponder: canvas)
            canvas.becomeFirstResponder()
        }

        let title = UILabel()
        title.frame = CGRect(x: 0, y: 20, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height / 8)
        title.textAlignment = .center
        title.text = "Let's draw using PencilKit"
        title.textColor = UIColor.black
        self.view.addSubview(title)
    }
}
