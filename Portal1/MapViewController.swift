//
//  MapViewController.swift
//  Portal1
//
//  Created by Nicat Guliyev on 11/12/18.
//  Copyright © 2018 Nicat Guliyev. All rights reserved.
//

import UIKit
import GoogleMaps

class MapViewController: UIViewController {

    @IBOutlet weak var MapView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        MapView.layer.cornerRadius = 10
        
        let camera = GMSCameraPosition.camera(withLatitude: 40.409960, longitude:  49.862265, zoom: 15.0)
        let mapView = GMSMapView.map(withFrame:  CGRect(x: 0, y: 0, width: self.view.frame.size.width - 60, height: self.view.frame.size.height - 140), camera: camera)
        mapView.layer.cornerRadius = 10
        MapView.addSubview(mapView)
        MapView.clipsToBounds = true
        
        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: 40.409960, longitude: 49.862265)
        marker.title = "Sydney"
        marker.snippet = "Australia"
        marker.map = mapView
        

    }


    @IBAction func closeClicked(_ sender: Any) {
    
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func testBtn(_ sender: Any) {
        print("Click")
    }
}
