//
//  TabBarViewController.swift
//  SketchApp
//
//  Created by Iichiro Kawashima on 2022/02/12.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        if #available(iOS 15.0, *) {
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .brown

            self.tabBar.standardAppearance = appearance
            self.tabBar.scrollEdgeAppearance = tabBar.standardAppearance
        }

        let drawScreen = DrawViewController()
        drawScreen.tabBarItem = UITabBarItem(title: "Default", image: .none, tag: 0)

        let imageDrawScreen = ImageDrawViewController()
        imageDrawScreen.tabBarItem = UITabBarItem(title: "Image", image: .none, tag: 1)

        let pencilScreen = PencilViewController()
        pencilScreen.tabBarItem = UITabBarItem(title: "Pencil", image: .none, tag: 2)

        let pdfScreen = PDFAnnotationViewController()
        pdfScreen.tabBarItem = UITabBarItem(title: "PDF Annotation", image: .none, tag: 3)

        let arScreen = ARViewController()
        arScreen.tabBarItem = UITabBarItem(title: "AR", image: .none, tag: 4)

        self.viewControllers = [drawScreen, imageDrawScreen, pencilScreen, pdfScreen, arScreen]
    }
}
