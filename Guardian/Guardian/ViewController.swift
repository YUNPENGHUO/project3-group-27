//
//  ViewController.swift
//  Guardian
//
//  Created by Edwardchen on 19/5/18.
//  Copyright © 2018 Edwardchen. All rights reserved.
//

import UIKit
import MapKit
import MessageUI
import AVFoundation

class ViewController: UIViewController,MKMapViewDelegate,CLLocationManagerDelegate,UINavigationControllerDelegate, MFMessageComposeViewControllerDelegate {
    
    @IBOutlet weak var labelVal: UILabel!
    @IBOutlet weak var mapKitView: MKMapView!
    let locationManager = CLLocationManager()
    var currentLongitude = "";
    var currentLatitude = "";
    var emerNum = "";
    var userName = "";
    var emerName = "";

    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        controller.dismiss(animated: true, completion: nil)
        switch result{
        case .sent:
            print("Message Sent")
        case .cancelled:
            print("Message Cancelled")
        case .failed:
            print("Fail to sent the message")
            // Get the result of sending messages
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Ask allowence of using GPS
        self.locationManager.requestWhenInUseAuthorization()
        // Estimate if the locationservice is on
        if CLLocationManager.locationServicesEnabled(){
        // Start locating the user
            locationManager.delegate = self
            mapKitView.showsUserLocation = true
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
        
    }

    
    @IBAction func MainOneTap(_ sender: Any) {
        let controller = MFMessageComposeViewController()
        userName = UserDefaults.standard.string(forKey: "userName")!;
        emerName = UserDefaults.standard.string(forKey: "emerName")!;
        emerNum = UserDefaults.standard.string(forKey: "emerNum")!;
        // Get the saved user information
        controller.body = "Hi " + emerName + ", I, " + userName + " am in danger! My current Longitude is:" + currentLongitude + ", current Latitude is:" + currentLatitude + ". Check my situation now! "
        // Set the content of the message
        controller.recipients = [self.emerNum]
        // Set the destination number of your message
        controller.messageComposeDelegate = self
        self.present(controller, animated: true, completion: nil)
        // Present the message interface
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // Get user's coordinate
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        currentLongitude = String(locValue.longitude);
        currentLatitude = String(locValue.latitude);
        // Relocate user's coordinate when it changed
        let userLocation = locations.last
        let viewRegion = MKCoordinateRegionMakeWithDistance((userLocation?.coordinate)!, 600, 600)
        // Update mapview
        mapKitView.setRegion(viewRegion,animated:true)
 
    }
    
    @IBAction func lightToggle(_ sender: Any) {
    let device = AVCaptureDevice.default(for: AVMediaType.video)
        if (device != nil) {
            if (device!.hasTorch) {
                do {
                    try device!.lockForConfiguration()
                    if (device!.torchMode == AVCaptureDevice.TorchMode.on)
       // Turn on the flashlight
                    {
                        device!.torchMode = AVCaptureDevice.TorchMode.off
       // Turn off the flashlight
                    } else {
                        do {
                            try device!.setTorchModeOn(level: 1.0)
       // Set flashlight
                        } catch {
                            print(error)
                        }
                    }
                    
                    device!.unlockForConfiguration()
                } catch {
                    print(error)
                }
            }
        }
    }
}


