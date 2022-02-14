//
//  PDFAnnotationViewController.swift
//  SketchApp
//
//  Created by Iichiro Kawashima on 2022/02/12.
//

import UIKit
import PDFKit

// PDFKit
// https://betterprogramming.pub/ios-pdfkit-ink-annotations-tutorial-4ba19b474dce
// https://github.com/poluektov/pdfkit-ink-annotations/
// https://pdfkit.org/docs/annotations.html

// PSPDFKit
// https://pspdfkit.com/pricing/
// https://pspdfkit.com/blog/2019/custom-annotation-data/

class PDFAnnotationViewController: UIViewController, PDFViewDelegate {

    var pdfView: PDFView!
    var pdfDocument: PDFDocument!

    override func viewDidLoad() {
        super.viewDidLoad()

        let pdfView = PDFView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height))

        guard let path = Bundle.main.url(forResource: "YOUR_FILE_NAME", withExtension: "pdf") else { return }
        guard let document = PDFDocument(url: path) else {
            return
        }
        pdfView.document = document
        pdfView.displayMode = .singlePageContinuous
        pdfView.autoScales = true
        pdfView.displayDirection = .horizontal
        pdfView.autoresizingMask = [.flexibleWidth, .flexibleHeight, .flexibleTopMargin, .flexibleBottomMargin]
        pdfView.maxScaleFactor = 4
        pdfView.delegate = self
        pdfView.minScaleFactor = pdfView.scaleFactorForSizeToFit
        pdfView.usePageViewController(true, withViewOptions: nil)
        pdfView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(pdfView)
        self.pdfView = pdfView
        self.pdfDocument = document
        //let highLightItem = UIMenuItem(title:"Highlight"), action: #selector(highlightFromMenuItem))


        let annotateButton = UIButton()
        annotateButton.frame = CGRect(x: 0, y: 20, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height / 8)
        annotateButton.setTitle("Add annotate", for: .normal)
        annotateButton.backgroundColor = UIColor.black
        annotateButton.addTarget(self, action: #selector(addAnnotate), for: .touchUpInside)
        self.view.addSubview(annotateButton)

        let shareButton = UIButton()
        shareButton.frame = CGRect(x: 0, y: 100, width: UIScreen.main.bounds.size.width, height: 40)
        shareButton.setTitle("Share", for: .normal)
        shareButton.backgroundColor = UIColor.black
        shareButton.addTarget(self, action: #selector(shareButtonTapped), for: .touchUpInside)
        self.view.addSubview(shareButton)

        self.setupNotification()
    }

    @objc func highlightFromMenuItem() {
        if let document = self.pdfDocument {
            let pdfSelection : PDFSelection = PDFSelection(document: document)
            pdfSelection.add((self.pdfView?.currentSelection)!)
            let arrayByLines = self.pdfView?.currentSelection?.selectionsByLine()
            arrayByLines?.forEach({ (selection) in
                let annotation = PDFAnnotation(bounds: selection.bounds(for: (self.pdfView?.currentPage)!), forType: .highlight, withProperties: nil)
                annotation.color = .yellow
                self.pdfView?.currentPage?.addAnnotation(annotation)
            })
        }
    }

    @objc func addAnnotate() {
        let annotation = PDFAnnotation(bounds: CGRect(x: 200, y: 400, width: 200, height: 50), forType: .freeText, withProperties: nil)
        annotation.contents = "PDFAnnotation"
        annotation.font = .systemFont(ofSize: 14)
        annotation.fontColor = .red
        annotation.color = .yellow

        // 対象のPDFPageへPDFAnnotationを設定する
        pdfView.currentPage?.addAnnotation(annotation)
    }

    private func setupNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(didTapAnnotation(_:)), name: .PDFViewAnnotationHit, object: nil)
    }

    @objc func didTapAnnotation(_ notification: Notification) {
        // タップされたPDFAnnotationを取得する
        guard
            let annotation = notification.userInfo?["PDFAnnotationHit"] as? PDFAnnotation
        else {
            return
        }

        annotation.contents = "TAPPED"
    }

    @objc private func shareButtonTapped() {
        guard let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        let path = url.appendingPathComponent("output.pdf")
        pdfDocument.write(to: path)

        let activityViewController = UIActivityViewController(activityItems: [path] , applicationActivities: nil)
        present(activityViewController, animated: true)
    }
}
