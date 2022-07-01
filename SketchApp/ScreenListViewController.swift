//
//  ScreenListViewController.swift
//  SketchApp
//
//  Created by Iichiro Kawashima on 2022/03/10.
//

import UIKit

enum Screen {
    case sketch(Sketch)
    case measure(Measure)
    case pdf(PDF)
    case map(Map)

    enum Sketch: String, CaseIterable {
        case pencilKit
        case uiImageView
        case uiview
    }

    enum Measure: String, CaseIterable {
        case arKit
    }

    enum PDF: String, CaseIterable {
        case pdfkit
    }

    enum Map: String, CaseIterable {
        case googleMap
        case mapBox
    }

    static var allCases: [Screen] {
        return Sketch.allCases.map(Screen.sketch) + Measure.allCases.map(Screen.measure) + PDF.allCases.map(Screen.pdf) + Map.allCases.map(Screen.map)
    }

    static func make(index: Int) -> UIViewController {
        switch index {
        case 0:
            return PencilViewController()

        case 1:
            return ImageDrawViewController()

        case 2:
            return DrawViewController()

        case 3:
            return ARViewController()

        case 4:
            return PDFAnnotationViewController()

        case 5:
            return GoogleMapViewController()

        case 6:
            return MapBoxViewController()

        default:
            return UIViewController()
        }
    }

    static func getTitle(index: Int) -> String {
        switch index {
        case 0:
            return Sketch.pencilKit.rawValue

        case 1:
            return Sketch.uiImageView.rawValue

        case 2:
            return Sketch.uiview.rawValue

        case 3:
            return Measure.arKit.rawValue

        case 4:
            return PDF.pdfkit.rawValue

        case 5:
            return Map.googleMap.rawValue

        case 6:
            return Map.mapBox.rawValue

        default:
            return ""
        }
    }
}

final class ScreenListViewController: UIViewController {

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = 50
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "検証機能一覧"
        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
        ])
    }
}

extension ScreenListViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Screen.allCases.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = Screen.getTitle(index: indexPath.row)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let vc = Screen.make(index: indexPath.row)
        self.navigationController?.present(vc, animated: true)
    }
}
