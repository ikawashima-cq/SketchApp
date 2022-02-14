//
//  PencilViewController.swift
//  SketchApp
//
//  Created by Iichiro Kawashima on 2022/02/12.
//

import UIKit
import PencilKit

class PencilViewController: UIViewController {

    lazy var canvas = PKCanvasView(frame: view.frame)
    var toolPicker = PKToolPicker()

    override func viewDidLoad() {
        super.viewDidLoad()

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

        self.addOptions()
    }

    private func addOptions() {
        // redo, do, delete, save, add image, tools

        let options = UIStackView()
        self.view.addSubview(options)
        options.frame = CGRect(x: 0, y: 100, width: UIScreen.main.bounds.size.width, height: 40)
        options.axis = .horizontal
        options.spacing = 4
        options.backgroundColor = .black

        let undoButton = UIButton()
        undoButton.setTitle("undo", for: .normal)
        undoButton.addTarget(self, action: #selector(undo), for: .touchUpInside)
        options.addArrangedSubview(undoButton)


        let redoButton = UIButton()
        redoButton.setTitle("redo", for: .normal)
        redoButton.addTarget(self, action: #selector(redo), for: .touchUpInside)
        options.addArrangedSubview(redoButton)

        let deleteButton = UIButton()
        deleteButton.setTitle("delete", for: .normal)
        deleteButton.addTarget(self, action: #selector(clear), for: .touchUpInside)
        options.addArrangedSubview(deleteButton)

        let toolPickerButton = UIButton()
        toolPickerButton.setTitle("toolPicker", for: .normal)
        toolPickerButton.addTarget(self, action: #selector(showToolPicker), for: .touchUpInside)
        options.addArrangedSubview(toolPickerButton)

    }

    @objc private func undo() {
        canvas.undoManager?.undo()
    }

    @objc private func redo() {
        canvas.undoManager?.redo()
    }

    @objc private func clear() {
        canvas.drawing = PKDrawing()
    }

    @objc private func showToolPicker() {

        toolPicker.setVisible(true, forFirstResponder: canvas)

        toolPicker.addObserver(canvas)

        canvas.becomeFirstResponder()
    }
}
