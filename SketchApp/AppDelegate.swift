//
//  AppDelegate.swift
//  SketchApp
//
//  Created by Iichiro Kawashima on 2022/02/12.
//

import UIKit
import GoogleMaps

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    private let googleMapsAPIKey: String = "AIzaSyDfPQtp13AXIT0Os5wnD3Et6u10XzLSeE4"

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        GMSServices.provideAPIKey(googleMapsAPIKey)

        self.window = UIWindow(frame: UIScreen.main.bounds)
        let rootScreen = UINavigationController(rootViewController: MapBoxViewController())
        self.window?.rootViewController = rootScreen
        self.window?.makeKeyAndVisible()

        return true
    }
}

