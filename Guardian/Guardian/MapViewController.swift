//
//  ViewController.swift
//  Guardian
//
//  Created by Edwardchen on 19/5/18.
//  Copyright © 2018 Edwardchen. All rights reserved.
//
/*
import UIKit
import MapKit

class MapViewController: UIViewController,MKMapViewDelegate,CLLocationManagerDelegate {

    let locationManager = CLLocationManager()

    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled(){
            locationManager.delegate = self
            
            mapKitView.showsUserLocation = true
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        print("userLocation:\(locValue.latitude)and\(locValue.longitude)")
        labelVal.text = "\(locValue.latitude) and \(locValue.longitude)"
        let userLocation = locations.last
        let viewRegion = MKCoordinateRegionMakeWithDistance((userLocation?.coordinate)!, 600, 600)
        mapKitView.setRegion(viewRegion,animated:true)
    }
}
*/

