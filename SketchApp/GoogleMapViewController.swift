//
//  GoogleMapViewController.swift
//  SketchApp
//
//  Created by Iichiro Kawashima on 2022/03/14.
//

import UIKit
import GoogleMaps

/*
  - GroundOverlayを用いることで図面データをMapに同期することができる
  -
 */
class GoogleMapViewController: UIViewController {

    private lazy var mapView: GMSMapView = {
        let camera = GMSCameraPosition.camera(
            withLatitude: 40.712216,
            longitude: -74.22655,
            zoom: 13
        )
        let mapView = GMSMapView.map(
            withFrame: self.view.frame,
            camera: camera
        )
        /*  MapViewのTypeを変更することで地図上の記載を消すこともできる。
            また以下LinkのようにMapView styleを定義することでも地図上の記載を消すこともできる。
            https://gist.github.com/TheTiger13/a0e94e1630463bac2f2536c63304f7f9
         　　https://developers.google.com/maps/documentation/ios-sdk/hiding-features
         */
        mapView.mapType = .satellite
        return mapView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        mapView.delegate = self
        view.backgroundColor = .white

        view.addSubview(mapView)
        let southWest = CLLocationCoordinate2D(
            latitude: 40.712216,
            longitude: -74.22655
        )

        let northEast = CLLocationCoordinate2D(
            latitude: 40.773941,
            longitude: -74.12544
        )

        let overlayBounds = GMSCoordinateBounds(
            coordinate: southWest,
            coordinate: northEast
        )

        let icon = UIImage(named: "newark_nj_1922")

        let overlay = GMSGroundOverlay(
            bounds: overlayBounds,
            icon: icon
        )
        overlay.bearing = 0
        overlay.map = mapView

        // 画像上でTapできる
        overlay.isTappable = true
    }
}

extension GoogleMapViewController: GMSMapViewDelegate {

    // Map長押しでマーカー追加
    // ※削除もできる
    func mapView(_ mapView: GMSMapView, didLongPressAt coordinate: CLLocationCoordinate2D) {

         //Creating Marker
         let marker = GMSMarker(position: coordinate)

         let decoder = CLGeocoder()

         //This method is used to get location details from coordinates
         decoder.reverseGeocodeLocation(CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)) { placemarks, err in
            if let placeMark = placemarks?.first {

                let placeName = placeMark.name ?? placeMark.subThoroughfare ?? placeMark.thoroughfare!   ///Title of Marker
                //Formatting for Marker Snippet/Subtitle
                var address : String! = ""
                if let subLocality = placeMark.subLocality ?? placeMark.name {
                    address.append(subLocality)
                    address.append(", ")
                }
                if let city = placeMark.locality ?? placeMark.subAdministrativeArea {
                    address.append(city)
                    address.append(", ")
                }
                if let state = placeMark.administrativeArea, let country = placeMark.country {
                    address.append(state)
                    address.append(", ")
                    address.append(country)
                }

                // Adding Marker Details
                // ドラッグもできる
                marker.isDraggable = true
                marker.title = placeName
                marker.snippet = address
                marker.appearAnimation = .pop
                marker.map = mapView
            }
        }
    }

    // マーカーのドラッグ
    func mapView(_ mapView: GMSMapView, didDrag marker: GMSMarker) {
        debugPrint("DraggingMarker")
    }
}
